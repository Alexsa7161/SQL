/*
Создать запрос для вывода списка дат и дней недели, начиная с заданной даты до конца месяца.
Заданная дата может быть любой допустимой в СУБД датой.
*/
DEFINE sday = '19.05.1998' ;	
SELECT TO_CHAR(TO_DATE('&&sday', 'DD.MM.SYYYY') - 1 + LEVEL, 'DD.MM.SYYYY') "DATE",
TO_CHAR(TO_DATE('&sday', 'DD.MM.SYYYY') - 1 + LEVEL, 'DAY') "DAY OF WEEK"
FROM DUAL
CONNECT BY LEVEL <= LAST_DAY(TO_DATE('&sday', 'DD.MM.SYYYY')) - TO_DATE('&sday', 'DD.MM.SYYYY') + 1;

