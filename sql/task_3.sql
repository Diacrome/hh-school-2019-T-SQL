SELECT area_id, 
       AVG(CASE WHEN compensation_from notnull then f_tax(compensation_gross)*compensation_from 
       									   else 0 
       end) AS "—редн€€ минимальна€ зарплата",
       AVG(CASE WHEN compensation_to notnull then f_tax(compensation_gross)*compensation_to 
       									   else 0 
       end) AS "—редн€€ максимальна€ зарплата",
	   AVG(CASE WHEN compensation_to notnull and compensation_from notnull then	f_tax(compensation_gross)*(compensation_to+compensation_from)/2
	   																	   else 0
	   end) as "—редн€€ зарплата"																	              
FROM vacancy_body 
GROUP BY area_id