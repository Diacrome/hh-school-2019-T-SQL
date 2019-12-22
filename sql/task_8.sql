CREATE TABLE resume_archive (
    archive_id serial PRIMARY KEY,
    resume_id integer DEFAULT 0 NOT NULL,
    last_change_time timestamp NOT NULL,
    json jsonb    
);

CREATE OR REPLACE FUNCTION archive_resume_as_json() RETURNS TRIGGER AS $resume_update_delete$
    BEGIN
       INSERT INTO resume_archive (resume_id,last_change_time,json)
        VALUES( 
              OLD.resume_body_id,
              now(),
              (SELECT to_jsonb(rb)
              FROM resume_body rb
              WHERE rb.resume_body_id=OLD.resume_body_id)
         );
         RETURN NEW;
    END;
$resume_update_delete$ LANGUAGE plpgsql;

CREATE TRIGGER resume_update_delete
    BEFORE UPDATE OR DELETE ON resume_data_body
    FOR EACH ROW
    EXECUTE PROCEDURE archive_resume_as_json();