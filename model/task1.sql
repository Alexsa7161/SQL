/*
В произвольной символьной строке оставить между словами только по одному 
пробелу. Обеспечьте вывод исходной и измененной строк. Задачу решить средствами 
раздела MODEL.
*/
DEFINE input_str = 'aa   a  a bb     bb   c  ';

SELECT '&input_str' AS input, LTRIM(res_str) AS result
FROM dual
MODEL
DIMENSION BY (0 id)
MEASURES (CAST(' ' AS VARCHAR2(1000)) AS res_str)
RULES ITERATE(999) UNTIL (iteration_number > LENGTH('&input_str')) 
(res_str[0] = CASE WHEN SUBSTR('&input_str', iteration_number + 1, 1) = ' '
        AND res_str[0] LIKE '% ' THEN res_str[0]
    ELSE res_str[0] || SUBSTR('&input_str', iteration_number + 1, 1) END)
    
