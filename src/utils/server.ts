import fastify from "fastify";
import { logger } from "./logger";

export async function createServer() {
  const server = fastify({
    logger,
  });

  // * we can register plugins here

  // * we can register routes here

  return server;
}
