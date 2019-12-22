WITH vac AS ( 
      SELECT EXTRACT(month FROM vacancy.creation_time) AS month,
        COUNT(vacancy_id) AS vacancy_amount
      FROM vacancy
      GROUP BY MONTH
    ),
    res AS (
      SELECT EXTRACT(month FROM resume_data.creation_time) AS month,
        COUNT(resume_id) AS resume_amount
      FROM resume_data
      GROUP BY MONTH
    )
  SELECT vac.month AS "max_vacancy_month",
         res.month AS "max_resume_month"         
  FROM vac, res
  WHERE resume_amount = (SELECT MAX(resume_amount) FROM res)
    AND vacancy_amount = (SELECT MAX(vacancy_amount) FROM vac)