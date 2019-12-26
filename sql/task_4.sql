SELECT v.MONTH as "Month with max amount of vacations" , r.MONTH as "Month with max amount of resumes" FROM
(SELECT EXTRACT(month FROM vacancy.creation_time) AS month,
        COUNT(vacancy_id) AS vacancy_amount
      FROM vacancy
      GROUP BY MONTH
      ORDER BY vacancy_amount DESC
      LIMIT 1) AS v ,      
(SELECT EXTRACT(month FROM resume_data.creation_time) AS month,
      COUNT(resume_id) AS resume_amount
      FROM resume_data
      GROUP BY MONTH
      ORDER BY resume_amount DESC
      LIMIT 1) AS r 