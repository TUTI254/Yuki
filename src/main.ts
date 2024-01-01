import { env } from "./config/env";
import { db } from "./db";
import { createServer } from "./utils/server";
import { migrate } from "drizzle-orm/node-postgres/migrator";

async function gracefulShutDown({
  server,
}: {
  server: Awaited<ReturnType<typeof createServer>>;
}) {
  await server.close();
}

async function main() {
  const server = await createServer();

  await server.listen({
    port: env.PORT,
    host: env.HOST,
  });

  await migrate(db, {
    migrationsFolder: "./src/db/migrations",
  });

  const signals = ["SIGINT", "SIGTERM"];

  for (const signal of signals) {
    process.on(signal, async () => {
      console.log(`Received ${signal}. Shutting down.`);
      await gracefulShutDown({ server });
      process.exit(0);
    });
  }
}

main();
