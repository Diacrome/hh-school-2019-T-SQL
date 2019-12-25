INSERT INTO vacancy_body(
    company_name, name, text, area_id, address_id, work_experience, 
    compensation_from, test_solution_required,
    work_schedule_type, employment_type, compensation_gross,driver_license_types
)
SELECT 
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 149 + i % 10)::integer)) AS company_name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 24 + i % 10)::integer)) AS name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 49 + i % 10)::integer)) AS text,

    (random() * 1000)::int AS area_id,
    (random() * 50000)::int AS address_id,
    (random() * 30)::int AS work_experience,
    25000 + (random() * 150000)::int AS compensation_from,
    (random() > 0.5) AS test_solution_required,
    floor(random() * 4)::int AS work_schedule_type,
    floor(random() * 4)::int AS employment_type,
    (random() > 0.5) AS compensation_gross,
    (SELECT ARRAY[ string_agg(
      substr(
          'ABCDE',
          ((random() * 4 + i % 2)::int)::integer, 1
        ),
      '')]
   FROM generate_series(1, 1) AS h(i))::varchar[] AS driver_license_types
FROM generate_series(1, 10000) AS g(i);

UPDATE vacancy_body
  SET compensation_to= compensation_from+random()*1000;

INSERT INTO vacancy (creation_time, expire_time, employer_id, disabled, visible, vacancy_body_id, area_id)
SELECT
    -- random in last 5 years
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS creation_time,
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS expire_time,
    (random() * 1000000)::int AS employer_id,
    (random() > 0.5) AS disabled,
    (random() > 0.5) AS visible,
    (SELECT vacancy_body_id FROM vacancy_body WHERE vacancy_body_id = i) AS vacancy_body_id,
    (random() * 1000)::int AS area_id
FROM generate_series(1, 10000) AS g(i);

INSERT INTO specialization(name,text)
SELECT 
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 24 + i % 10)::integer)) AS name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS text 
FROM generate_series(1, 50) AS g(i);

---insert resume
INSERT INTO resume_data_body (fio, gender, birth_date, phone, email,text)
SELECT 
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 40 + i % 10)::integer)) AS fio,
    
    (random() > 0.5) AS gender,
    now()-(random() * 365 * 24 * 3600 * 40) * '1 second'::interval AS birth_date,
    (SELECT string_agg(
        substr(
            '0123456789', 
            (random() * 10)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 10 + i % 10)::integer)) AS phone,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 40 + i % 10)::integer)) AS email,


    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS text

FROM generate_series(1, 100000) AS g(i);

INSERT INTO resume_data (resume_data_body_id, title, creation_time, expire_time, user_id, disabled, visible, area_id)
select
    (SELECT resume_body_id FROM resume_data_body WHERE resume_body_id = i) AS resume_body_id,
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 40 + i % 10)::integer)) AS title,
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS creation_time,
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS expire_time,
    (random() * 1000000)::int AS employer_id,
    (random() > 0.5) AS disabled,
    (random() > 0.5) AS visible,    
    (random() * 1000)::int AS area_id
FROM generate_series(1, 100000) AS g(i);


INSERT INTO vacancy_response(resume_id, vacancy_id, response_date )
SELECT
	random_resume_data_id as resume_id, 
	random_vacancy_id as vacancy_id,
	(
		SELECT	vacancy.creation_time + random()*'3 months'::interval 
		FROM	vacancy 
		WHERE	vacancy.vacancy_id = random_vacancy_id
	) AS response_time
FROM 
	(SELECT
		(random() * (998) + 1 + i%2) :: integer AS random_resume_data_id,
		(random() * (9998) + 1 + i%2) :: integer AS random_vacancy_id
	FROM generate_series(1, 50000) as i) AS randomize;


INSERT INTO resume_data_specialization(resume_body_id, specialization_id)
SELECT
  (SELECT resume_body_id FROM resume_data_body WHERE resume_body_id = i) AS resume_body_id,
  (SELECT ((random() * 48)::int  + i % 2 + 1)::integer) AS specialization_id
FROM generate_series(1, (SELECT count(resume_body_id) FROM resume_data_body)) AS g(i);


INSERT INTO vacancy_body_specialization (vacancy_body_id, specialization_id)
SELECT
  (SELECT vacancy_id FROM vacancy WHERE vacancy_id = i) AS vacancy_body_id,
  (SELECT ((random() * 48)::int  + i % 2+1)::integer) AS specialization_id
  FROM generate_series(1, (SELECT count(vacancy_body_id) FROM vacancy_body)) AS g(i);