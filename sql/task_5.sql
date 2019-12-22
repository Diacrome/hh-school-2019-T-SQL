SELECT * FROM (
SELECT vb.name FROM vacancy_body vb
WHERE
     (
      SELECT COUNT (v.vacancy_id) AS vac_count
      FROM vacancy v INNER JOIN vacancy_response r
      ON v.vacancy_id=r.vacancy_id
      AND r.response_date<=v.creation_time + INTERVAL '7' day
      AND v.vacancy_id=vb.vacancy_body_id
      GROUP BY v.vacancy_id
     )<5
UNION ALL    
SELECT vb.name FROM vacancy_body vb
WHERE (SELECT COUNT(r.resume_id) 
       FROM vacancy_response r 
       WHERE r.vacancy_id=vb.vacancy_body_id)=0
) as names
ORDER BY name ASC