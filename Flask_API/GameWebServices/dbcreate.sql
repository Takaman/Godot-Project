CREATE TABLE "PlayerProgress" (
	"username"	TEXT NOT NULL UNIQUE,
	"name"	TEXT,
	"company"	TEXT,
	"date_joined"	TEXT,
	"current_lvl"	TEXT,
	"points"	INTEGER,
	"comp_rate"	REAL,
	"last_played"	TEXT,
	PRIMARY KEY("username")
)

CREATE TABLE "login" (
	"name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	"password"	INTEGER NOT NULL,
	PRIMARY KEY("email")
)

-- PlayerProgress v0.2 
--  Removed "current_lvl"
--  Added "accountStatus"

CREATE TABLE "PlayerProgress" (
	"username"	TEXT NOT NULL UNIQUE,
	"name"	TEXT,
	"company"	TEXT,
	"date_joined"	TEXT,
	"points"	INTEGER,
	"comp_rate"	REAL,
	"last_played"	TEXT,
	"accountStatus"	TEXT,
	PRIMARY KEY("username")
)

-- PlayerProgress v0.3
	-- Added "se_correct"
	-- Added "se_completed"
	-- Added "policy_correct"
	-- Added "policy_completed"
	-- Added "breakdown"

CREATE TABLE "PlayerProgress" (
	"username"	TEXT NOT NULL UNIQUE,
	"name"	TEXT,
	"company"	TEXT,
	"date_joined"	TEXT,
	"points"	INTEGER,
	"comp_rate"	REAL,
	"last_played"	TEXT,
	"se_correct"	INTEGER,
	"se_completed"	INTEGER,
	"policy_correct"	INTEGER,
	"policy_completed"	INTEGER,
	"breakdown"	TEXT,
	"accountStatus"	TEXT,
	PRIMARY KEY("username")
)