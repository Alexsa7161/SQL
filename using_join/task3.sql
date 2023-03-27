/*
Ќапишите запрос дл€ вывода фамилий, названи€ отдела, идентификатора местоположени€ отдела и города,
в котором он находитс€, дл€ всех служащих, зарабатывающих комиссионные.
*/
SELECT LAST_NAME, DEPARTMENT_NAME, D.LOCATION_ID, L.CITY
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID left JOIN LOCATIONS L ON D.LOCATION_ID=L.LOCATION_ID
WHERE COMMISSION_PCT IS NOT NULL;


