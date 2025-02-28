-- S2U-21 --
CREATE TABLE SAM_SEBVALIDATION_T (
  ID NUMBER(19,0) NOT NULL,
  PUBLISHEDASSESSMENTID NUMBER(19,0) NOT NULL,
  AGENTID VARCHAR2(99) NOT NULL,
  URL VARCHAR2(1000) NOT NULL,
  CONFIGKEYHASH VARCHAR2(64) DEFAULT NULL,
  EXAMKEYHASH VARCHAR2(64) DEFAULT NULL,
  EXPIRED NUMBER(1, 0) NOT NULL,
  CONSTRAINT PK_SAM_SEBVALIDATION_T PRIMARY KEY (ID)
);

CREATE INDEX SAM_SEB_INDEX ON SAM_SEBVALIDATION_T (PUBLISHEDASSESSMENTID, AGENTID);
-- END S2U-21 --
