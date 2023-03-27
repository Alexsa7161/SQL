/*
Отобразить все связи по внешнему ключу между таблицами схемы наряду с количеством пользователей, имеющих привилегии на удаление строк из главной таблицы, и правило удаления строк из дочерней таблицы при удалении строк главной.
Результат должен содержать 4 столбца:
 1) название дочерней таблицы, соединённое через точку с названием столбца внешнего ключа дочерней таблицы; 
2) название главной таблицы, соединённое через точку с названием столбца первичного ключа главной таблицы; 
3) количество пользователей, имеющих привилегии на удаление строк из главной таблицы; 
4) правило удаления строк.

*/
SELECT  CN.TABLE_NAME || '.' || CL.COLUMN_NAME "CUST.FK", CNR.TABLE_NAME || '.' || CLR.COLUMN_NAME "SUPP.PK",  --вывод дочерней таблицы со стобцом, родительской таблицы со столбцом
NVL(PRIV.DEL_CNT, 0) "US_DEL_CNT", CN.DELETE_RULE 
FROM USER_CONSTRAINTS CN LEFT JOIN USER_CONS_COLUMNS CL ON CL.CONSTRAINT_NAME = CN.CONSTRAINT_NAME  -- соединение информации об ограничениях таблиц со столбцами ограничений  по имени ограничения дочерней таблицы
LEFT JOIN USER_CONS_COLUMNS CLR ON CLR.CONSTRAINT_NAME = CN.R_CONSTRAINT_NAME AND CL.POSITION = CLR.POSITION  -- соединение для главной таблицы по имени ограничения главной таблицы и соответствия позиции 
LEFT JOIN USER_CONSTRAINTS CNR ON CNR.CONSTRAINT_NAME = CN.R_CONSTRAINT_NAME  -- соединение для главной таблицы по имени ограничения главной таблицы
LEFT JOIN (SELECT TABLE_NAME, COUNT(TABLE_NAME) DEL_CNT     -- соединение с таблицей ALL_TAB_PRIVS для вывода числа пользователей с привилегией на удаление строк главной таблицы по столбцу имени главной таблицы
           FROM ALL_TAB_PRIVS 
           WHERE PRIVILEGE = 'DELETE' AND TYPE = 'TABLE' 
           GROUP BY TABLE_NAME) PRIV ON PRIV.TABLE_NAME = CNR.TABLE_NAME 
WHERE CN.CONSTRAINT_TYPE = 'R';                        -- ограничения внешнего ключа
