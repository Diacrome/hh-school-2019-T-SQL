SELECT
	vb.name
FROM
	vacancy v
INNER JOIN vacancy_body vb ON
	vb.vacancy_body_id = v.vacancy_body_id
LEFT JOIN vacancy_response r ON
	v.vacancy_id = r.vacancy_id
	AND r.response_date <= v.creation_time + INTERVAL '7' DAY
GROUP BY
	v.vacancy_id,
	vb.name
HAVING
	COUNT (r.vacancy_id) < 5