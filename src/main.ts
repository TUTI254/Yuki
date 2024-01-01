import { env } from "./config/env";
import { createServer } from "./utils/server";

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
