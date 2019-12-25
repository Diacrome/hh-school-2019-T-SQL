CREATE TABLE resume_archive (
    archive_id serial PRIMARY KEY,
    resume_id integer DEFAULT 0 NOT NULL,
    last_change_time timestamp NOT NULL,
    json_old jsonb,
    json_new jsonb
);

CREATE OR REPLACE FUNCTION archive_resume_as_json() RETURNS TRIGGER AS $resume_update_delete$
    BEGIN
       INSERT INTO resume_archive (resume_id,last_change_time,json_old, json_new)
        VALUES( 
              OLD.resume_id,
              now(),
              to_jsonb(old.*),
              to_jsonb(new.*)
         );
         RETURN NEW;
    END;
$resume_update_delete$ LANGUAGE plpgsql;

CREATE TRIGGER resume_update_delete
    BEFORE UPDATE OR DELETE ON resume_data
    FOR EACH ROW
    EXECUTE PROCEDURE archive_resume_as_json();

----------------------------------------------------------
--изменить данные для проверки
update resume_data 
set title='new test title'
where resume_id=1;
	
--изменить данные еще раз 
update resume_data rd 
set title='another 2nd new'
where rd.resume_id=1;

select	resume_id, last_change_time,
	   "json_old"::json->'title' as "Old title",
	   "json_new"::json->'title' as "New title"
from resume_archive where resume_id=1 order by last_change_time asc;
		 