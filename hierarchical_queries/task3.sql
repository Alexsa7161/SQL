/*
Создать запрос для вывода только правильно написанных выражений со скобками (количество открывающих и закрывающих скобок должно быть одинаково,
каждой открывающей скобке должна соответствовать закрывающая, первая скобка в выражении не должна быть закрывающей).
Примеры неправильных выражений:
        ((((a)g)q)
          z)(s)(
     (((f)e)w))(h(g(w))
*/
DEFINE str='(((f)e)w))(h(g(w))'; 
WITH D_ROWS AS 
(SELECT SUBSTR('&str',LEVEL,1) AS RW, ROWNUM RN 
FROM DUAL 
CONNECT BY LEVEL <= LENGTH('&str')),
D_BRAKETS AS 
(SELECT RW, ROWNUM NUM1 
FROM D_ROWS 
WHERE RW IN ('(',')') 
ORDER BY RN), 
NUMBERS AS 
(SELECT TO_NUMBER(CASE RW WHEN '(' THEN 1 ELSE -1 END) AS RW, NUM1 
FROM D_BRAKETS), 
SUMMAR AS
(SELECT RW, NUM1 , (SELECT SUM(RW) FROM NUMBERS WHERE NUM1<=EXT.NUM1) AS RESULT 
FROM NUMBERS EXT
START WITH NUM1 = 1 
CONNECT BY PRIOR NUM1 = NUM1-1), 
FAILD_RIGHT AS 
(SELECT DISTINCT 1 
FROM SUMMAR 
WHERE RESULT <0), 
FAILD_LEFT AS 
(SELECT DISTINCT 1 
FROM SUMMAR 
WHERE (SELECT SUM(RW) FROM SUMMAR)>0) 
SELECT '&&str' "Строка", CASE WHEN (SELECT * FROM FAILD_LEFT)=1 OR (SELECT * FROM FAILD_RIGHT)=1 THEN 'Неверно' ELSE
'Верно' END AS "Результат"
FROM DUAL; 
