import {initializeApp} from 'firebase-admin/app';
import {getFirestore} from 'firebase-admin/firestore';
import {publishDailyHorizon, utcDateKey} from './daily.js';

async function main(): Promise<void> {
  const option = (name: string): string | undefined =>
    process.argv.find((arg) => arg.startsWith(`${name}=`))?.slice(name.length + 1);
  const project = option('--project');
  const date = option('--date') ?? utcDateKey(new Date());
  if (!project || option('--confirm-project') !== project ||
      !/^\d{4}-\d{2}-\d{2}$/.test(date)) {
    throw new Error('Pass --project=ID --confirm-project=ID [--date=yyyy-MM-dd]');
  }
  initializeApp({projectId: project});
  const result = await publishDailyHorizon(getFirestore(), date);
  console.log(JSON.stringify({project, date, ...result}));
}

if (require.main === module) {
  main().catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  });
}
