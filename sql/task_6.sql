select  rd.resume_id , array_agg(distinct s.name||'|')  ,
MODE() WITHIN GROUP (ORDER BY s2.name) as most_popular_specialization
 from resume_data_specialization  rs 
 INNER JOIN specialization s ON rs.specialization_id = s.specialization_id
 inner join resume_data rd on rd.resume_data_body_id = rs.resume_body_id
 inner join vacancy_response vr on vr.resume_id = rd.resume_id
 inner join vacancy vac on vac.vacancy_id = vr.vacancy_id
 inner join vacancy_body_specialization vbs on  vbs.vacancy_body_id = vac.vacancy_body_id
 INNER JOIN specialization s2 ON s2.specialization_id = vbs.specialization_id		
GROUP BY rd.resume_id 