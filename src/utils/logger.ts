import pino from "pino";

export const logger = pino({
  level: "debug",
  transport: {
    target: "pino-pretty",
    options: {
      ignore: "pid,hostname",
    },
  },
  redact: ["DATABASE_CONNECTION"],
});
