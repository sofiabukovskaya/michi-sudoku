import {createHash} from 'node:crypto';
import {getFirestore, FieldValue, type Firestore} from 'firebase-admin/firestore';
import {onSchedule} from 'firebase-functions/v2/scheduler';
import {logger} from 'firebase-functions';

export const DAILY_HORIZON_DAYS = 14;
export const RECENT_DAILY_DAYS = 30;

export function utcDateKey(date: Date): string {
  return date.toISOString().slice(0, 10);
}

export function addUtcDays(dateKey: string, days: number): string {
  const date = new Date(`${dateKey}T12:00:00.000Z`);
  date.setUTCDate(date.getUTCDate() + days);
  return utcDateKey(date);
}

/** Stable across processes, deployments and Node runtimes. */
export function selectDailyPuzzle(
  date: string,
  releaseId: string,
  eligibleIds: readonly string[],
  recentIds: readonly string[],
): string {
  const sorted = [...new Set(eligibleIds)].sort();
  if (sorted.length === 0) throw new Error('No published Daily-eligible puzzles');
  const recent = new Set(recentIds);
  const available = sorted.filter((id) => !recent.has(id));
  const pool = available.length > 0 ? available : sorted;
  const digest = createHash('sha256')
    .update(JSON.stringify([date, releaseId, sorted])).digest();
  const index = Number(digest.readBigUInt64BE(0) % BigInt(pool.length));
  return pool[index];
}

export async function publishDailyHorizon(
  db: Firestore,
  today: string,
  horizon = DAILY_HORIZON_DAYS,
): Promise<{created: number; existing: number}> {
  const releaseRows = await db.collection('contentReleases')
    .where('status', '==', 'published')
    .orderBy('publishedAt', 'desc').limit(1).get();
  if (releaseRows.empty) throw new Error('No published content release');
  const release = releaseRows.docs[0];
  const ids = release.get('puzzleIds');
  if (!Array.isArray(ids) || ids.length === 0) throw new Error('Release has no puzzles');
  const puzzleDocs = await db.getAll(...ids.map((id: string) => db.collection('puzzles').doc(id)));
  const eligible = puzzleDocs.filter((doc) =>
    doc.exists && doc.get('status') === 'published' && doc.get('dailyEligible') === true,
  ).map((doc) => doc.id);
  if (eligible.length === 0) throw new Error('No published Daily-eligible puzzles');
  const previousKeys = Array.from({length: RECENT_DAILY_DAYS}, (_, n) =>
    addUtcDays(today, -RECENT_DAILY_DAYS + n));
  const previous = await db.getAll(...previousKeys.map((key) =>
    db.collection('dailyChallenges').doc(key)));
  const recent = previous.filter((doc) => doc.exists).map((doc) => doc.get('puzzleId') as string);
  let created = 0;
  let existing = 0;
  for (let offset = 0; offset <= horizon; offset++) {
    const date = addUtcDays(today, offset);
    const ref = db.collection('dailyChallenges').doc(date);
    const result = await db.runTransaction(async (transaction) => {
      const prior = await transaction.get(ref);
      if (prior.exists) return {created: false, puzzleId: prior.get('puzzleId') as string};
      const puzzleId = selectDailyPuzzle(date, release.id, eligible, recent.slice(-RECENT_DAILY_DAYS));
      transaction.create(ref, {
        schemaVersion: 1,
        date,
        puzzleId,
        challengeKey: `${date}|published:${puzzleId}`,
        releaseId: release.id,
        status: 'published',
        publishedAt: FieldValue.serverTimestamp(),
      });
      return {created: true, puzzleId};
    });
    recent.push(result.puzzleId);
    if (result.created) created++;
    else existing++;
  }
  return {created, existing};
}

export const ensureDailyChallengesPublished = onSchedule(
  {schedule: '15 0 * * *', timeZone: 'Etc/UTC', region: 'europe-west1',
    timeoutSeconds: 540},
  async () => {
    const started = Date.now();
    const date = utcDateKey(new Date());
    const result = await publishDailyHorizon(getFirestore(), date);
    logger.info('Daily horizon ensured', {function: 'ensureDailyChallengesPublished',
      date, ...result, durationMs: Date.now() - started});
  },
);
