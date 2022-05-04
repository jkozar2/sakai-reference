-- SAK-40427
UPDATE SAKAI_SITE_TOOL SET TITLE = 'Discussions' WHERE REGISTRATION = 'sakai.forums' AND TITLE = 'Forums';
UPDATE SAKAI_SITE_PAGE SET TITLE = 'Discussions' WHERE TITLE = 'Forums';
-- End SAK-40427

-- SAK-44305
create table MFR_DRAFT_RECIPIENT_T
(ID NUMBER(19,0) NOT NULL,
 TYPE NUMBER(10,0) NOT NULL,
 RECIPIENT_ID VARCHAR2(255) NOT NULL,
 DRAFT_ID NUMBER(19,0) NOT NULL,
 BCC NUMBER(1,0) NOT NULL,
 PRIMARY KEY (ID));

create index MFR_DRAFT_REC_MSG_ID_I on MFR_DRAFT_RECIPIENT_T(DRAFT_ID);

create sequence MFR_DRAFT_RECIPIENT_S;
-- End SAK-44305

-- SAK-45565
ALTER TABLE lesson_builder_groups RENAME COLUMN groups TO item_groups;
ALTER TABLE lesson_builder_items RENAME COLUMN groups TO item_groups;
ALTER TABLE tasks RENAME COLUMN SYSTEM TO SYSTEM_TASK;
-- SAK-45565

-- SAK-44967
ALTER TABLE gb_gradebook_t ADD allow_compare_grades NUMBER(1,0) DEFAULT 0 NOT NULL ;
ALTER TABLE gb_gradebook_t ADD comparing_display_firstnames NUMBER(1,0) DEFAULT 0 NOT NULL;
ALTER TABLE gb_gradebook_t ADD comparing_display_surnames NUMBER(1,0) DEFAULT 0 NOT NULL;
ALTER TABLE gb_gradebook_t ADD comparing_display_comments NUMBER(1,0) DEFAULT 0 NOT NULL;
ALTER TABLE gb_gradebook_t ADD comparing_display_allitems NUMBER(1,0) DEFAULT 0 NOT NULL;
ALTER TABLE gb_gradebook_t ADD comparing_randomizedata NUMBER(1,0) DEFAULT 0 NOT NULL;
-- End SAK-44967

-- SAK-46030

-- Create functions
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'dropbox.write.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'dropbox.write.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'dropbox.delete.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'dropbox.delete.any');

-- Conversations
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.anonymous.view');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.comment.create');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.comment.delete.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.comment.delete.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.comment.update.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.comment.update.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.moderate');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.create');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.delete.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.delete.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.react');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.update.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.update.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.post.upvote');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.roletype.instructor');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.statistics.view');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.tag.create');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.create');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.delete.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.delete.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.pin');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.tag');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.update.any');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.update.own');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'conversations.topic.view.groups');

-- Project sites - maintainers get .any permissions, accessors get .own permissions
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'maintain'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.write.any')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'maintain'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.delete.any')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'access'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.write.own')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'access'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.delete.own')
);
-- Give instructor the '.any' permissions in !site.template.course
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Instructor'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.write.any')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Instructor'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.delete.any')
);
-- Give student and TA the '.own' permissions in !site.template.course
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Student'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.write.own')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Student'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.delete.own')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Teaching Assistant'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.write.own')
);
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Teaching Assistant'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'dropbox.delete.own')
);

-- --------------------------------------------------------------------------------------------------------------------------------------
-- backfill new permission into existing realms
-- --------------------------------------------------------------------------------------------------------------------------------------

-- for each realm that has a role matching something in this table, we will add to that role the function from this table
CREATE TABLE PERMISSIONS_SRC_TEMP (ROLE_NAME VARCHAR(99), FUNCTION_NAME VARCHAR(99));

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','dropbox.write.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','dropbox.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','dropbox.write.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','dropbox.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','dropbox.write.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','dropbox.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','dropbox.write.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','dropbox.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Teaching Assistant','dropbox.write.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Teaching Assistant','dropbox.delete.own');

-- Conversations

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.roletype.instructor');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.moderate');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.update.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.tag');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.pin');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.tag.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.topic.view.groups');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.update.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.verify');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.react');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.post.comment');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.comment.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.comment.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.comment.update.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.comment.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.comment.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.statistics.view');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','conversations.anonymous.view');

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.roletype.instructor');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.moderate');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.update.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.tag');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.pin');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.tag.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.topic.view.groups');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.update.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.verify');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.react');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.post.comment');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.comment.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.comment.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.comment.update.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.comment.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.comment.delete.any');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.statistics.view');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','conversations.anonymous.view');

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.topic.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.topic.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.topic.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.topic.tag');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.post.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.post.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.post.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.post.react');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.post.comment');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.comment.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.comment.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Student','conversations.comment.delete.own');

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.topic.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.topic.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.topic.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.topic.tag');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.post.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.post.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.post.delete.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.post.react');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.post.comment');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.comment.create');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.comment.update.own');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('access','conversations.comment.delete.own');

-- lookup the role and function number
CREATE TABLE PERMISSIONS_TEMP (ROLE_KEY INTEGER, FUNCTION_KEY INTEGER);
INSERT INTO PERMISSIONS_TEMP (ROLE_KEY, FUNCTION_KEY)
SELECT SRR.ROLE_KEY, SRF.FUNCTION_KEY
FROM PERMISSIONS_SRC_TEMP TMPSRC
JOIN SAKAI_REALM_ROLE SRR ON (TMPSRC.ROLE_NAME = SRR.ROLE_NAME)
JOIN SAKAI_REALM_FUNCTION SRF ON (TMPSRC.FUNCTION_NAME = SRF.FUNCTION_NAME);

-- insert the new function into the roles of any existing realm that has the role (don't convert the "!site.helper")
INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY)
SELECT
    SRRFD.REALM_KEY, SRRFD.ROLE_KEY, TMP.FUNCTION_KEY
FROM
    (SELECT DISTINCT SRRF.REALM_KEY, SRRF.ROLE_KEY FROM SAKAI_REALM_RL_FN SRRF) SRRFD
    JOIN PERMISSIONS_TEMP TMP ON (SRRFD.ROLE_KEY = TMP.ROLE_KEY)
    JOIN SAKAI_REALM SR ON (SRRFD.REALM_KEY = SR.REALM_KEY)
    WHERE SR.REALM_ID != '!site.helper'
    AND NOT EXISTS (
        SELECT 1
            FROM SAKAI_REALM_RL_FN SRRFI
            WHERE SRRFI.REALM_KEY=SRRFD.REALM_KEY AND SRRFI.ROLE_KEY=SRRFD.ROLE_KEY AND SRRFI.FUNCTION_KEY=TMP.FUNCTION_KEY
    );

-- clean up the temp tables
DROP TABLE PERMISSIONS_TEMP;
DROP TABLE PERMISSIONS_SRC_TEMP;

-- End SAK-46030

-- SAK-46022
ALTER TABLE COMMONS_POST ADD PRIORITY NUMBER(1) DEFAULT 0 NOT NULL;
-- End SAK-46022

-- SAK-46685
ALTER TABLE ASN_ASSIGNMENT ADD ESTIMATE_REQUIRED CHAR(1) DEFAULT '0' NOT NULL;
ALTER TABLE ASN_ASSIGNMENT ADD ESTIMATE VARCHAR2(255) NULL;
ALTER TABLE ASN_SUBMISSION_SUBMITTER ADD TIME_SPENT VARCHAR2(255) NULL;
ALTER TABLE ASN_ASSIGNMENT ADD CONSTRAINT CHECK_IS_ESTIMATE_REQUIRED CHECK (ESTIMATE_REQUIRED IN ('0', '1'));

CREATE TABLE TIMESHEET_ENTRY (
ID number(22) NOT NULL,
REFERENCE VARCHAR2(255) NOT NULL,
USER_ID VARCHAR2(99),
START_TIME TIMESTAMP(6) NOT NULL,
DURATION VARCHAR2(255) NOT NULL,
TEXT_COMMENT VARCHAR2(4000) NULL,
PRIMARY KEY (ID)
);

CREATE INDEX IDX_TIMESHEETENTRY_REF_USER ON TIMESHEET_ENTRY(REFERENCE, USER_ID);
CREATE SEQUENCE TIMESHEET_S;
-- End SAK-46685

-- SAK-46021
CREATE TABLE COMMONS_LIKE (
USER_ID VARCHAR2(99) NOT NULL,
POST_ID VARCHAR2(36) NOT NULL,
VOTE NUMBER(1) DEFAULT 0 NOT NULL,
MODIFIED_DATE TIMESTAMP(6),
CONSTRAINT commons_like_pk PRIMARY KEY (USER_ID, POST_ID)
);
--End SAK-46021

-- SAK-46137
ALTER TABLE SAKAI_PERSON_T ADD PRINCIPAL_NAME_PRIOR varchar2(255) DEFAULT NULL;
ALTER TABLE SAKAI_PERSON_T ADD SCOPED_AFFILIATION varchar2(255) DEFAULT NULL;
ALTER TABLE SAKAI_PERSON_T ADD TARGETED_ID varchar2(255) DEFAULT NULL;
ALTER TABLE SAKAI_PERSON_T ADD ASSURANCE varchar2(255) DEFAULT NULL;
ALTER TABLE SAKAI_PERSON_T ADD UNIQUE_ID varchar2(255) DEFAULT NULL;
ALTER TABLE SAKAI_PERSON_T ADD ORCID varchar2(255) DEFAULT NULL;
-- End SAK-46137 

-- SAK-46085
ALTER TABLE PROFILE_SOCIAL_INFO_T ADD INSTAGRAM_URL VARCHAR2(255) NULL;
--End SAK-46085

-- SAK-46848 - assign defaults to numeric columns to prevent NPEs.
UPDATE CONTENTREVIEW_ITEM SET VERION = 0 WHERE VERSION IS NULL;
UPDATE CONTENTREVIEW_ITEM SET PROVIDERID = -1 WHERE PROVIDERID IS NULL;
ALTER TABLE CONTENTREVIEW_ITEM MODIFY VERSION INTEGER default 0 NOT NULL;
ALTER TABLE CONTENTREVIEW_ITEM MODIFY PROVIDERID INTEGER default -1 NOT NULL;
UPDATE SAM_ITEM_T SET ISEXTRACREDIT = 0 WHERE ISEXTRACREDIT IS NULL;
UPDATE SAM_PUBLISHEDITEM_T SET ISEXTRACREDIT = 0 WHERE ISEXTRACREDIT IS NULL;
ALTER TABLE SAM_ITEM_T MODIFY ISEXTRACREDIT NUMBER(1) DEFAULT 0 NOT NULL;
ALTER TABLE SAM_PUBLISHEDITEM_T MODIFY ISEXTRACREDIT NUMBER(1) DEFAULT 0 NOT NULL;

-- SAK-46686
ALTER TABLE GB_GRADE_RECORD_T ADD ENTERED_POINTS FLOAT DEFAULT NULL;
--End SAK-46686

-- SAK-46920
ALTER TABLE RBC_EVALUATION ADD STATUS NUMBER(1,0) DEFAULT 1 NOT NULL;
-- End SAK-46920

-- SAK-45987
CREATE TABLE RBC_RETURNED_CRITERION_OUT (
  ID NUMBER(19) NOT NULL,
  COMMENTS CLOB DEFAULT NULL,
  CRITERION_ID NUMBER(19) DEFAULT NULL,
  POINTS FLOAT DEFAULT NULL,
  POINTSADJUSTED NUMBER(1,0) NOT NULL,
  SELECTED_RATING_ID NUMBER(19) DEFAULT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT FK_RBC_RETURNED_CRITERION_ID FOREIGN KEY (CRITERION_ID) REFERENCES RBC_CRITERION (ID)
);

CREATE SEQUENCE RBC_RET_CRIT_OUT_SEQ;

CREATE TABLE RBC_RETURNED_EVALUATION (
  ID NUMBER(19) NOT NULL,
  ORIGINAL_EVALUATION_ID NUMBER(19) NOT NULL,
  OVERALLCOMMENT VARCHAR2(255) DEFAULT NULL,
  PRIMARY KEY (ID)
);

CREATE SEQUENCE RBC_RET_EVAL_SEQ;

CREATE INDEX RBC_RET_ORIG_ID ON  RBC_RETURNED_EVALUATION(ORIGINAL_EVALUATION_ID);

CREATE TABLE RBC_RETURNED_CRITERION_OUTS (
  RBC_RETURNED_EVALUATION_ID NUMBER(19) NOT NULL,
  RBC_RETURNED_CRITERION_OUT_ID NUMBER(19) NOT NULL UNIQUE,
  CONSTRAINT RETURNED_CRITERION_OUT_ID_FK FOREIGN KEY (RBC_RETURNED_CRITERION_OUT_ID) REFERENCES RBC_RETURNED_CRITERION_OUT (ID),
  CONSTRAINT RETURNED_EVALUTION_ID_FK FOREIGN KEY (RBC_RETURNED_EVALUATION_ID) REFERENCES RBC_RETURNED_EVALUATION (ID)
);

CREATE INDEX RETURNED_EVALUATION_ID_KEY ON RBC_RETURNED_CRITERION_OUTS(RBC_RETURNED_EVALUATION_ID);
-- End SAK-45987

-- Start SAK-41604
ALTER TABLE RBC_EVALUATION ADD EVALUATED_ITEM_OWNER_TYPE NUMBER(1,0);
-- End SAK-41604

-- Start /SAK-46977
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'sitestats.all');
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'sitestats.own');
INSERT INTO SAKAI_REALM_RL_FN VALUES (
    (SELECT REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template'),
    (SELECT ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'access'),
    (SELECT FUNCTION_KEY  from SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'sitestats.own')
);
INSERT INTO SAKAI_REALM_RL_FN VALUES (
    (SELECT REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Student'),
    (SELECT FUNCTION_KEY  from SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'sitestats.own')
);
INSERT INTO SAKAI_REALM_RL_FN VALUES (
    (SELECT REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template'),
    (SELECT ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'maintain'),
    (SELECT FUNCTION_KEY  from SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'sitestats.all')
);
INSERT INTO SAKAI_REALM_RL_FN VALUES (
    (SELECT REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Instructor'),
    (SELECT FUNCTION_KEY  from SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'sitestats.all')
);
-- End /SAK-46977
