/*
Создайте запрос для вывода фамилий и дат найма всех служащих, нанятых после Davies.
*/
SELECT EMP1.LAST_NAME, EMP1.HIRE_DATE
FROM EMPLOYEES EMP1 JOIN EMPLOYEES EMP2 ON EMP1.HIRE_DATE > EMP2.HIRE_DATE
WHERE EMP2.LAST_NAME LIKE('Davies');
