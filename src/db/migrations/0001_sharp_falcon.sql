CREATE TABLE IF NOT EXISTS "roles" (
	"id" uuid DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(256) NOT NULL,
	"applicationId" uuid NOT NULL,
	"permissions" text[],
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "roles_name_applicationId_pk" PRIMARY KEY("name","applicationId")
);

CREATE TABLE IF NOT EXISTS "users" (
	"id" uuid DEFAULT gen_random_uuid() NOT NULL,
	"email" varchar(256) NOT NULL,
	"name" varchar(256) NOT NULL,
	"applicationId" uuid NOT NULL,
	"password" varchar(256) NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "users_email_applicationId_pk" PRIMARY KEY("email","applicationId")
);

CREATE UNIQUE INDEX IF NOT EXISTS "roles_id_index" ON "roles" ("id");
CREATE UNIQUE INDEX IF NOT EXISTS "users_id_index" ON "users" ("id");
DO $$ BEGIN
 ALTER TABLE "roles" ADD CONSTRAINT "roles_applicationId_applications_id_fk" FOREIGN KEY ("applicationId") REFERENCES "applications"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
 ALTER TABLE "users" ADD CONSTRAINT "users_applicationId_applications_id_fk" FOREIGN KEY ("applicationId") REFERENCES "applications"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
