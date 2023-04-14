/*
Используя таблицы REGIONS, COUNTRIES, LOCATIONS, DEPARTMENTS, построить (показать) иерархию
объектов "Регион – Страна – Местоположение – Подразделение" для региона name = 'Americas'.
В результате вывести: 
- номер уровня, на котором находится в иерархии данный объект (LEVEL), 
- имя объекта, дополненное слева (LEVEL -1)*3 пробелами.
*/
WITH ENTR AS (
SELECT TO_CHAR(REGION_ID) ID, TO_CHAR(NULL) PAREN, REGION_NAME NAME
FROM REGIONS
UNION ALL
SELECT TO_CHAR(COUNTRY_ID), TO_CHAR(REGION_ID), COUNTRY_NAME
FROM COUNTRIES
UNION ALL
SELECT TO_CHAR(LOCATION_ID), TO_CHAR(COUNTRY_ID), CITY
FROM LOCATIONS
UNION ALL
SELECT TO_CHAR(DEPARTMENT_ID), TO_CHAR(LOCATION_ID), DEPARTMENT_NAME
FROM DEPARTMENTS)

SELECT LEVEL  "Уровень", LPAD(NAME, LENGTH(NAME)+(LEVEL-1)*3,' ') "Единица"
FROM ENTR
START WITH PAREN IS NULL
CONNECT BY PRIOR ID=PAREN
ORDER SIBLINGS BY NAME; 
