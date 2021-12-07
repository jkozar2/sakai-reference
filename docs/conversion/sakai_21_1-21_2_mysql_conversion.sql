-- SAK-45435
ALTER TABLE lti_tools ADD     lti13_platform_public_old MEDIUMTEXT NULL;
ALTER TABLE lti_tools ADD     lti13_platform_public_old_at DATETIME NULL;
-- End SAK-45435

-- SAK-43510
ALTER TABLE SAKAI_PERSON_T ADD PRONOUNS varchar(255);
-- End SAK-43510

-- SAK-45491
ALTER TABLE lti_tools ADD lti13_platform_public_next MEDIUMTEXT;
ALTER TABLE lti_tools ADD lti13_platform_public_next_at DATETIME NULL;
ALTER TABLE lti_tools ADD lti13_platform_private_next MEDIUMTEXT
-- End SAK-45491

-- Start SAK-45692
ALTER TABLE FILE_CONVERSION_QUEUE ADD CONSTRAINT UK_j0t1gd58buw5b0cwxayincy09 UNIQUE (`REFERENCE`);
-- End SAK-45692

