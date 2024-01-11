-- SAK-46436 START
CREATE TABLE TASKS_ASSIGNED
(
    ID               NUMBER(19,0)          NOT NULL,
    OBJECT_ID        VARCHAR(99)           NULL,
    ASSIGNATION_TYPE VARCHAR(255)          NOT NULL,
    TASK_ID          NUMBER(19,0)          NOT NULL,
    CONSTRAINT PK_TASKS_ASSIGNED PRIMARY KEY (ID)
);

ALTER TABLE TASKS ADD TASK_OWNER VARCHAR(99) NULL;
CREATE INDEX IDX_TASKS_ASSIGNED ON TASKS_ASSIGNED (TASK_ID);
ALTER TABLE TASKS_ASSIGNED
    ADD CONSTRAINT FK915ilfdtgcwqab3xuyfwn95ao FOREIGN KEY (TASK_ID) REFERENCES TASKS (ID);
CREATE SEQUENCE TASKS_ASSIGNED_S MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20;
-- SAK-46436 END

-- SAK-46986 START
CREATE TABLE TASK_GROUPS
(
    TASK_ID  NUMBER(19)      NOT NULL,
    GROUP_ID VARCHAR(99) NULL
);

CREATE INDEX FK7x7ajup3bwe3hcwq057evmala ON TASK_GROUPS (TASK_ID);
ALTER TABLE TASK_GROUPS
    ADD CONSTRAINT FK7x7ajup3bwe3hcwq057evmala FOREIGN KEY (TASK_ID) REFERENCES TASKS (ID);
-- SAK-46986 END

-- SAK-46178 START
ALTER TABLE rbc_rating ADD order_index INT DEFAULT null NULL;
ALTER TABLE rbc_criterion ADD order_index INT DEFAULT null NULL;
ALTER TABLE rbc_tool_item_rbc_assoc ADD siteId VARCHAR(99) NULL;
ALTER TABLE rbc_tool_item_rbc_assoc ADD CONSTRAINT rbc_item_rubric UNIQUE (itemId, rubric_id);
ALTER TABLE rbc_criterion_ratings DROP CONSTRAINT FK2ecdorwm3nm2ytyg9uvxlik53;
ALTER TABLE rbc_criterion_ratings DROP CONSTRAINT FKd03estm381c26jhsq4wd44vwx;
ALTER TABLE rbc_criterion_ratings DROP CONSTRAINT FK_funjjd0xkrmm5x300r7i4la83;
ALTER TABLE rbc_criterion_ratings DROP CONSTRAINT UK_funjjd0xkrmm5x300r7i4la83;
ALTER TABLE rbc_evaluation DROP CONSTRAINT FKem9md18gcni93xqa5ijykty8e;
ALTER TABLE rbc_rubric_criterions DROP CONSTRAINT FKilhg1u02m1765ltp3253wp7hn;
ALTER TABLE rbc_rubric_criterions DROP CONSTRAINT FKt5dmnek3q7syuqck0uk9rw2hg;

ALTER TABLE rbc_criterion DROP COLUMN created;
ALTER TABLE rbc_rating DROP COLUMN created;
ALTER TABLE rbc_criterion DROP COLUMN creatorId;
ALTER TABLE rbc_rating DROP COLUMN creatorId;
ALTER TABLE rbc_rubric DROP COLUMN description;
ALTER TABLE rbc_criterion DROP COLUMN modified;
ALTER TABLE rbc_rating DROP COLUMN modified;
ALTER TABLE rbc_rating DROP COLUMN ownerId;
ALTER TABLE rbc_criterion DROP COLUMN ownerType;
ALTER TABLE rbc_evaluation DROP COLUMN ownerType;
ALTER TABLE rbc_rating DROP COLUMN ownerType;
ALTER TABLE rbc_rubric DROP COLUMN ownerType;
ALTER TABLE rbc_tool_item_rbc_assoc DROP COLUMN ownerType;
ALTER TABLE rbc_criterion DROP COLUMN shared;
ALTER TABLE rbc_evaluation DROP COLUMN shared;
ALTER TABLE rbc_rating DROP COLUMN shared;
ALTER TABLE rbc_tool_item_rbc_assoc DROP COLUMN shared;
ALTER TABLE rbc_tool_item_rbc_assoc DROP COLUMN ownerId;

ALTER TABLE rbc_criterion_outcome MODIFY pointsAdjusted DEFAULT 0;
ALTER TABLE rbc_returned_criterion_out MODIFY pointsAdjusted DEFAULT 0;
ALTER TABLE rbc_rubric MODIFY shared DEFAULT 0;
ALTER TABLE rbc_criterion MODIFY weight DEFAULT null;
ALTER TABLE rbc_rubric MODIFY weighted DEFAULT 0;
DROP INDEX rbc_tool_item_owner;
CREATE INDEX rbc_tool_item_owner ON rbc_tool_item_rbc_assoc (toolId, itemId, siteId);

-- this migrates the data from the link tables
UPDATE rbc_criterion
    SET rubric_id = (SELECT rrc.rbc_rubric_id FROM rbc_rubric_criterions rrc WHERE rrc.criterions_id = rbc_criterion.id),
        order_index = (SELECT rrc.order_index FROM rbc_rubric_criterions rrc WHERE rrc.criterions_id = rbc_criterion.id)
    WHERE rubric_id is NULL;
UPDATE rbc_rating
    SET criterion_id = (SELECT rcr.rbc_criterion_id FROM rbc_criterion_ratings rcr WHERE rcr.ratings_id = rbc_rating.id),
        order_index = (SELECT rcr.order_index FROM rbc_criterion_ratings rcr WHERE rcr.ratings_id = rbc_rating.id)
    WHERE criterion_id is NULL;
UPDATE RBC_TOOL_ITEM_RBC_ASSOC
    SET siteid = (SELECT rc.ownerId FROM rbc_rubric rc WHERE rc.id = rbc_tool_item_rbc_assoc.rubric_id)
    WHERE siteid is NULL;

ALTER TABLE rbc_criterion_outcome MODIFY pointsAdjusted NUMBER(1) NULL;
ALTER TABLE rbc_criterion_outcome ALTER pointsAdjusted DEFAULT 0;
ALTER TABLE rbc_returned_criterion_out MODIFY pointsAdjusted NUMBER(1) NULL;
ALTER TABLE rbc_returned_criterion_out ALTER pointsAdjusted DEFAULT 0;
ALTER TABLE rbc_rubric MODIFY shared NUMBER(1) NULL;
ALTER TABLE rbc_rubric ALTER shared DEFAULT 0;
ALTER TABLE rbc_criterion ALTER weight DEFAULT null;
ALTER TABLE rbc_rubric MODIFY weighted NUMBER(1) NULL;
ALTER TABLE rbc_rubric ALTER weighted DEFAULT 0;
DROP INDEX rbc_tool_item_owner ON rbc_tool_item_rbc_assoc;
CREATE INDEX rbc_tool_item_owner ON rbc_tool_item_rbc_assoc (toolId, itemId, siteId);

-- this migrates the data from the link tables
UPDATE rbc_criterion rc SET rc.rubric_id = (select rrc.rbc_rubric_id FROM rbc_rubric_criterions rrc WHERE rc.id = rrc.criterions_id and rownum<2) WHERE rc.rubric_id is NULL;
UPDATE rbc_criterion rc SET rc.order_index = (select rrc.order_index FROM rbc_rubric_criterions rrc WHERE rc.id = rrc.criterions_id and rownum<2) WHERE rc.order_index is NULL;
UPDATE rbc_rating rc SET rc.criterion_id = (select rcr.rbc_criterion_id FROM rbc_criterion_ratings rcr WHERE rc.id = rcr.ratings_id and rownum<2) WHERE rc.criterion_id is NULL;
UPDATE rbc_rating rc SET rc.order_index  = (select rcr.order_index FROM rbc_criterion_ratings rcr WHERE rc.id = rcr.ratings_id and rownum<2) WHERE rc.order_index is NULL;
UPDATE rbc_tool_item_rbc_assoc rti SET rti.siteId = (select rc.ownerId FROM rbc_rubric rc WHERE rti.rubric_id = rc.id) WHERE rti.siteId is NULL;

-- once the above conversion is run successfully then the following tables can be dropped
-- DROP TABLE rbc_criterion_ratings;
-- DROP TABLE rbc_rubric_criterions;
-- SAK-46178 END

-- SAK-46257 START
ALTER TABLE CONV_POSTS ADD DEPTH INT DEFAULT null NULL;
ALTER TABLE CONV_TOPIC_STATUS ADD POSTED NUMBER(1) DEFAULT 0 NULL;

ALTER TABLE CONV_TOPICS ADD DUE_DATE TIMESTAMP DEFAULT null NULL;
ALTER TABLE CONV_TOPICS ADD HIDE_DATE TIMESTAMP DEFAULT null NULL;
ALTER TABLE CONV_TOPICS ADD LOCK_DATE TIMESTAMP DEFAULT null NULL;
ALTER TABLE CONV_TOPICS ADD SHOW_DATE TIMESTAMP DEFAULT null NULL;

ALTER TABLE CONV_POSTS ADD HOW_ACTIVE INT DEFAULT null NULL;
ALTER TABLE CONV_COMMENTS ADD TOPIC_ID VARCHAR(36) NOT NULL;
ALTER TABLE CONV_POSTS ADD NUMBER_OF_THREAD_REACTIONS INT DEFAULT null NULL;
ALTER TABLE CONV_POSTS ADD NUMBER_OF_THREAD_REPLIES INT DEFAULT null NULL;
ALTER TABLE CONV_POSTS ADD PARENT_THREAD_ID VARCHAR(36) NULL;
ALTER TABLE CONV_TOPICS ADD MUST_POST_BEFORE_VIEWING NUMBER(1) DEFAULT 0 NULL;

CREATE INDEX conv_topics_site_creator_idx ON CONV_TOPICS (SITE_ID, CREATOR);
CREATE INDEX conv_posts_parent_thread_idx ON CONV_POSTS (PARENT_THREAD_ID);
CREATE INDEX conv_posts_topic_creator_idx ON CONV_POSTS (TOPIC_ID, CREATOR);
CREATE INDEX conv_comments_topic_idx ON CONV_COMMENTS (TOPIC_ID);

ALTER TABLE CONV_COMMENTS DROP CONSTRAINT FK5ivsmxyitqpbm7pmdnu3lnmyi;
ALTER TABLE CONV_POSTS DROP CONSTRAINT FKc21ukywsqsqilxlsdrg4x6qka;
ALTER TABLE CONV_USER_STATISTICS DROP CONSTRAINT FKi9pfkqq0396p0kl718e9mrakk;
ALTER TABLE CONV_POST_REACTION_TOTALS DROP CONSTRAINT FKirwlickqy5sf8o9ejk1qkuit6;
ALTER TABLE CONV_TOPIC_REACTIONS DROP CONSTRAINT FKpwv7vrkag66g9kq6gghtc4uy1;
ALTER TABLE CONV_POSTS DROP CONSTRAINT FKqaspmpv6ull7whideia5i2cnb;
ALTER TABLE CONV_TOPIC_REACTION_TOTALS DROP CONSTRAINT FKqu7eyh63vtkowyqoqa9xy7wmq;
ALTER TABLE CONV_POST_REACTIONS DROP CONSTRAINT FKqv38yghf2km7vq1i717xywih6;
-- SAK-46257 END

-- SAK-47231 START
ALTER TABLE CONV_POST_STATUS MODIFY POST_ID VARCHAR(36);
ALTER TABLE CONV_POST_STATUS MODIFY TOPIC_ID VARCHAR(36);
ALTER TABLE CONV_TOPIC_STATUS MODIFY TOPIC_ID VARCHAR(36);
-- SAK-47231 END


-- SAK-45330 START
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_KEY, FUNCTION_NAME) VALUES(SAKAI_REALM_FUNCTION_SEQ.NEXTVAL, 'rubrics.manager.view');

INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'maintain'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'rubrics.manager.view')
);

INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Instructor'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'rubrics.manager.view')
);

CREATE TABLE PERMISSIONS_SRC_TEMP (ROLE_NAME VARCHAR(99), FUNCTION_NAME VARCHAR(99));

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','rubrics.manager.view');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','rubrics.manager.view');

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

-- SAK-45330 END
