CREATE TABLE vacancy (
    vacancy_id serial PRIMARY KEY,
    creation_time timestamp NOT NULL,
    expire_time timestamp NOT NULL,
    employer_id integer DEFAULT 0 NOT NULL,    
    disabled boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    area_id integer
);

CREATE TABLE vacancy_body (
    vacancy_body_id serial PRIMARY KEY,
    company_name varchar(150) DEFAULT ''::varchar NOT NULL,
    name varchar(220) DEFAULT ''::varchar NOT NULL,
    text text,
    area_id integer,
    address_id integer,
    work_experience integer DEFAULT 0 NOT NULL,
    compensation_from bigint DEFAULT 0,
    compensation_to bigint DEFAULT 0,
    test_solution_required boolean DEFAULT false NOT NULL,
    work_schedule_type integer DEFAULT 0 NOT NULL,
    employment_type integer DEFAULT 0 NOT NULL,
    compensation_gross boolean,
    driver_license_types varchar(5)[],
    CONSTRAINT fk_vacancy_body_id FOREIGN KEY (vacancy_body_id)  REFERENCES vacancy  (vacancy_id),
    CONSTRAINT vacancy_body_work_employment_type_validate CHECK ((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
    CONSTRAINT vacancy_body_work_schedule_type_validate CHECK ((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);
CREATE TABLE vacancy_body_specialization (
    vacancy_body_specialization_id integer NOT NULL,
    CONSTRAINT fk_vacancy_body_specialization_id FOREIGN KEY (vacancy_body_specialization_id)  REFERENCES vacancy (vacancy_id),
    specialization_id integer DEFAULT 0 NOT NULL
);

CREATE TABLE resume_data (
    resume_id serial PRIMARY KEY,
    creation_time timestamp NOT NULL,
    expire_time timestamp NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,    
    disabled boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    area_id integer
);
CREATE TABLE resume_data_body (
    resume_body_id serial PRIMARY KEY,
    CONSTRAINT fk_resume_body_id FOREIGN KEY (resume_body_id)  REFERENCES resume_data (resume_id),
    fio varchar(150) DEFAULT ''::varchar NOT NULL,
    gender boolean DEFAULT false NOT NULL,
    birth_date timestamp NOT NULL,
    phone varchar(30),
    email varchar(50),
    update_date timestamp,
    text text
);

CREATE TABLE vacancy_response(
    id serial PRIMARY KEY,
    resume_id integer  ,
    vacancy_id integer  ,
    response_date timestamp NOT NULL,
    CONSTRAINT fk_vacancy_response_resume_id FOREIGN KEY (resume_id)  REFERENCES resume_data (resume_id),
    CONSTRAINT fk_vacancy_response_vacancy_id FOREIGN KEY (vacancy_id)  REFERENCES vacancy (vacancy_id)
);

CREATE TABLE specialization (
  specialization_id serial PRIMARY KEY,
  name varchar(220) DEFAULT ''::varchar NOT NULL,
  text text
);
CREATE TABLE resume_data_specialization (        
    resume_data_specialization_id integer DEFAULT 0 NOT NULL,
    CONSTRAINT fk_resume_body_specialization_id FOREIGN KEY (resume_data_specialization_id)  REFERENCES resume_data (resume_id),   
    specialization_id integer DEFAULT 0 NOT NULL
);
--constant tax (1-0.13=0.87)
CREATE OR REPLACE FUNCTION f_tax()
  RETURNS Float AS
$$SELECT Float '0.87'$$ LANGUAGE sql IMMUTABLE;