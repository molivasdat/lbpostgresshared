CREATE TRIGGER film_fulltext_trigger BEFORE INSERT OR UPDATE ON   film FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description')