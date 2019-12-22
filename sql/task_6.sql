SELECT rds.resume_data_specialization_id AS "ID Резюме",
       array_agg(rds.specialization_id) AS "Массив специализаций",
       mode() WITHIN GROUP (order by vbs.specialization_id desc) AS "Самая частая профессия вакансий"
FROM resume_data_specialization rds JOIN 
  (
      vacancy_response vc JOIN vacancy_body_specialization vbs
      ON vbs.vacancy_body_specialization_id=vc.vacancy_id

  )           
ON  resume_id=resume_data_specialization_id
GROUP BY rds.resume_data_specialization_id
