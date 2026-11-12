import {createHash} from 'node:crypto';
import {readFile} from 'node:fs/promises';
import {initializeApp} from 'firebase-admin/app';
import {FieldValue, getFirestore, type Firestore} from 'firebase-admin/firestore';

type Puzzle = {
  id: string; board: string; difficulty: string;
  requiredTechniques: string[]; dailyEligible: boolean;
};
type Artifact = {
  schemaVersion: number; releaseId: string; contentVersion: number;
  puzzles: Puzzle[]; sha256: string;
};

export function verifyArtifact(value: unknown): Artifact {
  if (typeof value !== 'object' || value === null) throw new Error('Invalid artifact');
  const data = value as Partial<Artifact>;
  if (data.schemaVersion !== 1 || !data.releaseId || !/^[a-z0-9_-]+$/.test(data.releaseId) ||
      typeof data.contentVersion !== 'number' || !Number.isInteger(data.contentVersion) ||
      data.contentVersion < 1 || !Array.isArray(data.puzzles) ||
      data.puzzles.length === 0 || !data.sha256) throw new Error('Invalid artifact schema');
  const ids = new Set<string>();
  for (const puzzle of data.puzzles) {
    if (!puzzle || typeof puzzle.id !== 'string' || !/^[a-z0-9_]+$/.test(puzzle.id) ||
        ids.has(puzzle.id) || !/^[0-9]{81}$/.test(puzzle.board) ||
        !['easy', 'medium', 'advanced', 'expert'].includes(puzzle.difficulty) ||
        !Array.isArray(puzzle.requiredTechniques) ||
        !puzzle.requiredTechniques.every((item) => typeof item === 'string') ||
        typeof puzzle.dailyEligible !== 'boolean') throw new Error('Invalid puzzle schema');
    ids.add(puzzle.id);
  }
  const {sha256, ...payload} = data as Artifact;
  const actual = createHash('sha256').update(JSON.stringify(payload)).digest('hex');
  if (actual !== sha256) throw new Error('Artifact checksum mismatch; run Dart validation');
  return data as Artifact;
}

export async function publishArtifact(db: Firestore, artifact: Artifact, apply = false): Promise<{
  created: number; alreadyIdentical: number;
}> {
  const releaseRef = db.collection('contentReleases').doc(artifact.releaseId);
  const existingRelease = await releaseRef.get();
  if (existingRelease.exists && existingRelease.get('sha256') !== artifact.sha256) {
    throw new Error('Immutable release ID conflict');
  }
  let created = 0;
  let identical = 0;
  const newPuzzles: Array<{id: string; puzzle: Puzzle; hash: string}> = [];
  for (const puzzle of artifact.puzzles) {
    const hash = createHash('sha256').update(JSON.stringify(puzzle)).digest('hex');
    const existing = await db.collection('puzzles').doc(puzzle.id).get();
    if (existing.exists) {
      if (existing.get('contentHash') !== hash) throw new Error(`Immutable puzzle conflict: ${puzzle.id}`);
      identical++;
    } else {
      created++;
      newPuzzles.push({id: puzzle.id, puzzle, hash});
    }
  }
  if (!apply) return {created, alreadyIdentical: identical};
  for (let start = 0; start < newPuzzles.length; start += 400) {
    const batch = db.batch();
    for (const item of newPuzzles.slice(start, start + 400)) {
      batch.create(db.collection('puzzles').doc(item.id), {
        ...item.puzzle, schemaVersion: 1, contentVersion: artifact.contentVersion,
        releaseId: artifact.releaseId, status: 'published',
        contentHash: item.hash, publishedAt: FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }
  if (!existingRelease.exists) {
    await releaseRef.create({schemaVersion: 1, status: 'published',
      contentVersion: artifact.contentVersion,
      puzzleIds: artifact.puzzles.map((puzzle) => puzzle.id),
      sha256: artifact.sha256, publishedAt: FieldValue.serverTimestamp()});
  }
  return {created, alreadyIdentical: identical};
}

async function main(): Promise<void> {
  const args = process.argv.slice(2);
  const option = (name: string): string | undefined => args.find((arg) =>
    arg.startsWith(`${name}=`))?.slice(name.length + 1);
  const artifactPath = option('--artifact');
  const project = option('--project');
  const apply = args.includes('--apply');
  if (!artifactPath || !project) throw new Error('Pass --artifact=PATH --project=PROJECT');
  if (apply && option('--confirm-project') !== project) {
    throw new Error('Publishing requires --confirm-project matching --project');
  }
  const artifact = verifyArtifact(JSON.parse(await readFile(artifactPath, 'utf8')));
  initializeApp({projectId: project});
  const report = await publishArtifact(getFirestore(), artifact, apply);
  console.log(JSON.stringify({project, releaseId: artifact.releaseId,
    mode: apply ? 'apply' : 'dry-run', ...report,
    conflict: 0, failed: 0}));
}

if (require.main === module) {
  main().catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  });
}
