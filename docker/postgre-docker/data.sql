-- create database
DROP database IF EXISTS docker_database;
create database docker_database;
-- switch to database
\c docker_database;
-- create tables
DROP TABLE IF EXISTS SQFASRT_ACCT_ENTRY;
CREATE TABLE SQFASRT_ACCT_ENTRY (
	FASRT_ACCT_ENTRY_ID SERIAL primary key,
	METADATA VARCHAR(2048),
	GROUP_VERSION DECIMAL(38,0) NOT NULL,
	COMMAND_ID DECIMAL(38,0) NOT NULL,
    EVENT_ID DECIMAL(38,0) NOT NULL,
    DATA_SOURCE int NOT NULL,
    ACCOUNT_ID DECIMAL(38,0) NOT NULL,
    ACCOUNT_DEDUP_ID VARCHAR(1024) NOT NULL,
    FAS_BATCH_ID DECIMAL(38,0),
    JOURNAL_ENTRY_DEDUP_ID VARCHAR(1024) NOT NULL,
    INDEX_IN_JOURNAL_ENTRY int NOT NULL,
    CREDIT_QUANTITY DECIMAL(22,5) NOT NULL,
    CREDIT_UNIT_ID int NOT NULL,
    DEBIT_QUANTITY DECIMAL(22,5) NOT NULL,
    DEBIT_UNIT_ID int NOT NULL,
    BALANCE_AMOUNT DECIMAL(22,5) NOT NULL,
    BALANCE_UNIT_ID int NOT NULL,
    TRANSACTION_DATE DATE,
    JOURNAL_TYPE_ID int NOT NULL,
    JOURNAL_LINE_SEQ_ID DECIMAL(38,0),
    EXTERNAL_TRX_ID VARCHAR(128) NOT NULL,
    EXTERNAL_TRX_TYPE VARCHAR(128) NOT NULL,
    EXTERNAL_REF_ID1 VARCHAR(256),
    EXTERNAL_REF_ID2 VARCHAR(256),
    EXTERNAL_REF_ID3 VARCHAR(256),
    PERSIST_DATE DATE NOT NULL,
    JOURNAL_DATE DATE NOT NULL,
    MEMO VARCHAR(4000),
    MGR_FROM int,
    MGR_INFO VARCHAR(1024),
    SIGNATURE VARCHAR(256),
    CREATION_DATE DATE,
    LAST_MODIFIED_DATE DATE,
    SEQUENCE_NUM DECIMAL(38,0)
--    CONSTRAINT SQFASRT_ACCT_ENTRY_PK PRIMARY KEY (FASRT_ACCT_ENTRY_ID)
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX1 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE,
ACCOUNT_ID
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX2 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
EXTERNAL_REF_ID1
)
;

CREATE INDEX SQFASRT_ACCT_ENTRY_IX3 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
EXTERNAL_REF_ID2
)
;

CREATE INDEX SQFASRT_ACCT_ENTRY_IX4 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
EXTERNAL_TRX_ID
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX5 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
PERSIST_DATE
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX6 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
ACCOUNT_ID ,
PERSIST_DATE
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX7 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
JOURNAL_DATE
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX8 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
ACCOUNT_ID ,
JOURNAL_DATE
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX9 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
ACCOUNT_ID ,
GROUP_VERSION ,
COMMAND_ID ,
EVENT_ID
);

CREATE UNIQUE INDEX SQFASRT_ACCT_ENTRY_UX1 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
JOURNAL_ENTRY_DEDUP_ID ,
INDEX_IN_JOURNAL_ENTRY
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX10 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
ACCOUNT_ID ,
SEQUENCE_NUM ,
PERSIST_DATE
);

CREATE INDEX SQFASRT_ACCT_ENTRY_IX11 ON SQFASRT_ACCT_ENTRY (
DATA_SOURCE ,
EXTERNAL_REF_ID3
);

DROP TABLE IF EXISTS SQFASRT_EVENT;
CREATE TABLE SQFASRT_EVENT(
    FASRT_EVENT_ID SERIAL primary key,
    METADATA VARCHAR(2048),
    MSG_BROKER VARCHAR(128) NOT NULL,
    MSG_PARTITION VARCHAR(128) NOT NULL,
    MSG_OFFSET DECIMAL(38,0) NOT NULL,
    GROUP_ID DECIMAL(38,0) NOT NULL,
    GROUP_VERSION DECIMAL(38,0) NOT NULL,
    COMMAND_ID DECIMAL(38,0) NOT NULL,
    EVENT_ID DECIMAL(38,0) NOT NULL,
    EVENT_TYPE INT NOT NULL,
    PAYLOAD TEXT,
    PERSIST_DATE DATE NOT NULL,
    SIGNATURE VARCHAR(256),
    CREATION_DATE DATE,
    DATA_SOURCE INT NOT NULL,
    LAST_MODIFIED_DATE DATE
--    CONSTRAINT SQFASRT_EVENT_PK PRIMARY KEY (FASRT_EVENT_ID)
);

CREATE INDEX SQFASRT_EVENT_IX1 ON SQFASRT_EVENT (
DATA_SOURCE ,
GROUP_ID ,
GROUP_VERSION ,
PERSIST_DATE
);

CREATE INDEX SQFASRT_EVENT_IX2 ON SQFASRT_EVENT (
DATA_SOURCE ,
MSG_BROKER ,
MSG_PARTITION ,
GROUP_ID ,
GROUP_VERSION
);

CREATE INDEX SQFASRT_EVENT_IX3 ON SQFASRT_EVENT (
DATA_SOURCE ,
MSG_BROKER ,
MSG_PARTITION ,
GROUP_ID ,
GROUP_VERSION ,
COMMAND_ID ,
EVENT_ID
);

CREATE UNIQUE INDEX SQFASRT_EVENT_UX1 ON SQFASRT_EVENT (
DATA_SOURCE ,
GROUP_ID ,
GROUP_VERSION ,
COMMAND_ID ,
EVENT_ID
);

DROP TABLE IF EXISTS SQFASRT_JNL_ENTRY;
CREATE TABLE SQFASRT_JNL_ENTRY(
    FASRT_JNL_ENTRY_ID SERIAL primary key,
    METADATA VARCHAR(2048),
    DATA_SOURCE INT NOT NULL,
    JOURNAL_TYPE_ID INT NOT NULL,
    DEDUP_ID VARCHAR(1024) NOT NULL,
    SOURCE_SYSTEM VARCHAR(128),
    EXTERNAL_TRX_ID VARCHAR(128) NOT NULL,
    EXTERNAL_TRX_TYPE VARCHAR(128) NOT NULL,
    JOURNAL_LINE_COUNT INT,
    TRANSACTION_DATE DATE,
    EXTERNAL_REF_ID1 VARCHAR(256),
    EXTERNAL_REF_ID2 VARCHAR(256),
    EXTERNAL_REF_ID3 VARCHAR(256),
    PERSIST_DATE DATE NOT NULL,
    JOURNAL_DATE DATE NOT NULL,
    MEMO VARCHAR(4000),
    MGR_FROM INT,
    MGR_INFO VARCHAR(1024),
    SIGNATURE VARCHAR(256),
    CREATION_DATE DATE,
    LAST_MODIFIED_DATE DATE
--    CONSTRAINT SQFASRT_JNL_ENTRY_PK PRIMARY KEY (FASRT_JNL_ENTRY_ID)
);

CREATE INDEX SQFASRT_JNL_ENTRY_IX1 ON SQFASRT_JNL_ENTRY (
DATA_SOURCE ,
EXTERNAL_TRX_ID ,
EXTERNAL_TRX_TYPE
);

CREATE INDEX SQFASRT_JNL_ENTRY_IX2 ON SQFASRT_JNL_ENTRY (
DATA_SOURCE ,
EXTERNAL_REF_ID1
);

CREATE INDEX SQFASRT_JNL_ENTRY_IX3 ON SQFASRT_JNL_ENTRY (
DATA_SOURCE ,
EXTERNAL_REF_ID2
);

CREATE INDEX SQFASRT_JNL_ENTRY_IX4 ON SQFASRT_JNL_ENTRY (
DATA_SOURCE ,
PERSIST_DATE
);

CREATE INDEX SQFASRT_JNL_ENTRY_IX5 ON SQFASRT_JNL_ENTRY (
DATA_SOURCE ,
JOURNAL_DATE
);

CREATE UNIQUE INDEX SQFASRT_JNL_ENTRY_UX1 ON SQFASRT_JNL_ENTRY (
DATA_SOURCE ,
DEDUP_ID
);

DROP TABLE IF EXISTS SQFASRT_JNL_ATTR;
CREATE TABLE SQFASRT_JNL_ATTR (
    FASRT_JNL_ATTR_ID SERIAL primary key,
    DATA_SOURCE INT NOT NULL,
    JOURNAL_ENTRY_ID DECIMAL(38,0) NOT NULL,
    JOURNAL_ATTR_NAME VARCHAR(128) NOT NULL,
    JOURNAL_ATTR_VALUE VARCHAR(2048),
    PERSIST_DATE DATE NOT NULL,
    SIGNATURE VARCHAR(256),
    VERSION DECIMAL(38,0)
--    CONSTRAINT SQFASRT_JNL_ATTR_PK PRIMARY KEY (FASRT_JNL_ATTR_ID)
);

CREATE UNIQUE INDEX SQFASRT_JNL_ATTR_UX1 ON SQFASRT_JNL_ATTR (
JOURNAL_ENTRY_ID ,
JOURNAL_ATTR_NAME ,
VERSION 
);


DROP TABLE IF EXISTS SQFASRT_JNL_LINE;
CREATE TABLE SQFASRT_JNL_LINE (
    FASRT_JNL_LINE_ID SERIAL primary key,
    METADATA VARCHAR(2048),
    DATA_SOURCE INT NOT NULL,
    JOURNAL_ENTRY_ID DECIMAL(38,0) NOT NULL,
    FAS_BATCH_ID DECIMAL(38,0),
    ACCOUNT_ID DECIMAL(38,0) NOT NULL,
    ACCOUNT_DEDUP_ID VARCHAR(1024) NOT NULL,
    JOURNAL_ENTRY_DEDUP_ID VARCHAR(1024) NOT NULL,
    INDEX_IN_JOURNAL_ENTRY INT NOT NULL,
    CREDIT_QUANTITY DECIMAL(22,5) NOT NULL,
    CREDIT_UNIT_ID INT NOT NULL,
    DEBIT_QUANTITY DECIMAL(22,5) NOT NULL,
    DEBIT_UNIT_ID INT NOT NULL,
    JOURNAL_TYPE_ID INT NOT NULL,
    JOURNAL_LINE_SEQ_ID DECIMAL(38,0),
    EXTERNAL_TRX_ID VARCHAR(128) NOT NULL,
    EXTERNAL_TRX_TYPE VARCHAR(128) NOT NULL,
    EXTERNAL_REF_ID1 VARCHAR(256),
    EXTERNAL_REF_ID2 VARCHAR(256),
    EXTERNAL_REF_ID3 VARCHAR(256),
    PERSIST_DATE DATE NOT NULL,
    JOURNAL_DATE DATE NOT NULL,
    MEMO VARCHAR(4000),
    SIGNATURE VARCHAR(256),
    POSTING_KEY VARCHAR(32),
    TRANSACTION_DATE DATE,
    POSTING_DATE DATE,
    POSTING_CATEGORY_HINT VARCHAR(256)
--    CONSTRAINT SQFASRT_JNL_LINE_PK PRIMARY KEY (FASRT_JNL_LINE_ID)
);

CREATE INDEX SQFASRT_JNL_LINE_IX1 ON SQFASRT_JNL_LINE (
DATA_SOURCE ,
JOURNAL_ENTRY_DEDUP_ID ,
INDEX_IN_JOURNAL_ENTRY 
)
;

CREATE INDEX SQFASRT_JNL_LINE_IX2 ON SQFASRT_JNL_LINE (
JOURNAL_ENTRY_ID 
)
;

CREATE INDEX SQFASRT_JNL_LINE_IX3 ON SQFASRT_JNL_LINE (
DATA_SOURCE ,
ACCOUNT_ID 
)
;

CREATE INDEX SQFASRT_JNL_LINE_IX4 ON SQFASRT_JNL_LINE (
DATA_SOURCE ,
EXTERNAL_REF_ID1 
)
;

CREATE INDEX SQFASRT_JNL_LINE_IX5 ON SQFASRT_JNL_LINE (
DATA_SOURCE ,
EXTERNAL_REF_ID2 
)
;

CREATE INDEX SQFASRT_JNL_LINE_IX6 ON SQFASRT_JNL_LINE (
DATA_SOURCE ,
PERSIST_DATE 
)
;

CREATE INDEX SQFASRT_JNL_LINE_IX7 ON SQFASRT_JNL_LINE (
DATA_SOURCE ,
JOURNAL_DATE 
)
;


DROP TABLE IF EXISTS SQFASRT_JNL_LINE_ATTR;
CREATE TABLE SQFASRT_JNL_LINE_ATTR (
    FASRT_JNL_LINE_ATTR_ID SERIAL primary key,
    DATA_SOURCE INT NOT NULL,
    JOURNAL_ENTRY_ID DECIMAL(38,0) NOT NULL,
    JOURNAL_LINE_ID DECIMAL(38,0),
    JOURNAL_ATTR_NAME VARCHAR(128) NOT NULL,
    JOURNAL_ATTR_VALUE VARCHAR(2048),
    PERSIST_DATE DATE NOT NULL,
    SIGNATURE VARCHAR(256),
    VERSION DECIMAL(38,0)
--    CONSTRAINT SQFASRT_JNL_LINE_ATTR_PK PRIMARY KEY (FASRT_JNL_LINE_ATTR_ID)
);

CREATE UNIQUE INDEX SQFASRT_JNL_LINE_ATTR_UX1 ON SQFASRT_JNL_LINE_ATTR (
JOURNAL_ENTRY_ID,
JOURNAL_LINE_ID,
JOURNAL_ATTR_NAME,
VERSION 
)
;

