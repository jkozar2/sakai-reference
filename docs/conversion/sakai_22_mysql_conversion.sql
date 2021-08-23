-- SAK-40427
UPDATE SAKAI_SITE_TOOL SET TITLE = 'Discussions' WHERE REGISTRATION = 'sakai.forums' AND TITLE = 'Forums';
UPDATE SAKAI_SITE_PAGE SET TITLE = 'Discussions' WHERE TITLE = 'Forums';
-- End SAK-40427

-- SAK-44305
create table MFR_DRAFT_RECIPIENT_T
(ID bigint not null auto_increment,
 TYPE int not null,
 RECIPIENT_ID varchar(255) not null,
 DRAFT_MSG_ID bigint not null,
 BCC bit not null,
 primary key (ID));

create index MFR_DRAFT_REC_MSG_ID_I on MFR_DRAFT_RECIPIENT_T(DRAFT_MSG_ID);
-- End SAK-44305

-- SAK-45565
ALTER TABLE lesson_builder_groups CHANGE COLUMN `groups` item_groups LONGTEXT NULL DEFAULT NULL;
ALTER TABLE lesson_builder_items CHANGE COLUMN `groups` item_groups LONGTEXT NULL DEFAULT NULL;
ALTER TABLE tasks CHANGE COLUMN `SYSTEM` SYSTEM_TASK BIT(1) NOT NULL;
-- SAK-45565

-- SAK-44967
ALTER TABLE GB_GRADEBOOK_T ADD COLUMN ALLOW_COMPARE_GRADES BIT(1) DEFAULT FALSE NOT NULL;
ALTER TABLE GB_GRADEBOOK_T ADD COLUMN COMPARING_DISPLAY_FIRSTNAMES BIT(1) DEFAULT FALSE NOT NULL;
ALTER TABLE GB_GRADEBOOK_T ADD COLUMN COMPARING_DISPLAY_SURNAMES BIT(1) DEFAULT FALSE NOT NULL;
ALTER TABLE GB_GRADEBOOK_T ADD COLUMN COMPARING_DISPLAY_COMMENTS BIT(1) DEFAULT FALSE NOT NULL;
ALTER TABLE GB_GRADEBOOK_T ADD COLUMN COMPARING_DISPLAY_ALLITEMS BIT(1) DEFAULT FALSE NOT NULL;
ALTER TABLE GB_GRADEBOOK_T ADD COLUMN COMPARING_RANDOMIZEDATA BIT(1) DEFAULT FALSE NOT NULL;
-- End SAK-44967

-- SAK-46022
ALTER TABLE COMMONS_POST ADD COLUMN PRIORITY BIT(1) DEFAULT FALSE NOT NULL;
-- End SAK-46022
