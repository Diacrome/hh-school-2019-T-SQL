SELECT area_id, 
       AVG(CASE WHEN compensation_gross THEN compensation_from
                                        ELSE f_tax()*compensation_from END
          )AS "Средняя минимальая зарплата",
       AVG(CASE WHEN compensation_gross THEN compensation_to
                                        ELSE f_tax()*compensation_to END
          )AS  "Средняя максимальная зарплата", 
       AVG(CASE WHEN compensation_gross THEN (compensation_to+compensation_from)/2
                                        ELSE f_tax()*(compensation_to+compensation_from)/2 END
          )AS  "Средняя зарплата" 
   FROM vacancy_body WHERE compensation_from IS NOT null
   GROUP BY area_id