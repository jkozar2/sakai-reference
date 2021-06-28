-- START SAK-45137
UPDATE rbc_rating SET title = '' WHERE title IS NULL;
ALTER TABLE rbc_rating MODIFY title VARCHAR(255) NOT NULL;
ALTER TABLE rbc_rating ALTER title DROP DEFAULT;

UPDATE rbc_rating SET points = 0 WHERE points IS NULL;
ALTER TABLE rbc_rating MODIFY points DOUBLE NOT NULL;
ALTER TABLE rbc_rating ALTER points DROP DEFAULT;
-- END SAK-45137

-- START SAK-45575
CREATE INDEX IDX_FCI_STATUS ON FILE_CONVERSION_QUEUE(STATUS);
-- END SAK-45575

-- START SAK-45580
DROP INDEX IDX_FCI_REF_TYPE ON FILE_CONVERSION_QUEUE;
-- END SAK-45580

