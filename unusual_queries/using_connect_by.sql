/*
��������� ������� ������ � ������� ��������������.
������� ����������� ����������� � ������� � ���� �����1.���1->�����2.���2->������1.���1, ������� � ������� �� �������� �����.
*/
WITH TAB AS( 
        SELECT '1' NUM, '�������' NAME, '2' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '2' NUM, '����' NAME, '3' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '3' NUM, '�����' NAME, '4' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '4' NUM, '����' NAME, '2' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '5' NUM, '��������' NAME, '3' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '6' NUM, '������' NAME, '5' MNG 
        FROM DUAL
        UNION ALL 
        SELECT '7' NUM, '����' NAME, '8' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '8' NUM, '�����' NAME, '9' MNG 
        FROM DUAL 
        UNION ALL 
        SELECT '9' NUM, '����' NAME, '7' MNG 
        FROM DUAL 
        ), 
     RES AS (
        SELECT LTRIM(SYS_CONNECT_BY_PATH(NUM||'.'||NAME, '->')||'->'||connect_by_root(NUM||'.'||name),'->') A, SYS_CONNECT_BY_PATH(NUM,'.') B
        FROM TAB 
        WHERE connect_by_root(num) = mng 
        CONNECT BY NOCYCLE PRIOR mng = num 
        ORDER BY connect_by_root(NAME)
        ), 
     ORD AS (
        SELECT A, REGEXP_REPLACE(B,B) || (SELECT REGEXP_REPLACE(B,B) || LISTAGG(N,'.') WITHIN GROUP (ORDER BY N) 
                   FROM (SELECT REGEXP_SUBSTR(B,'\\d+',1,LEVEL) N, LEVEL LV 
                         FROM DUAL 
                         CONNECT BY REGEXP_SUBSTR(B,'\\d+',1,LEVEL) IS NOT NULL)) B, ROWNUM RNN 
        FROM RES
     ),
     GR AS (
        SELECT ROW_NUMBER() OVER (PARTITION BY B ORDER BY RNN) RN, A, B
        FROM ORD
     )
SELECT A RESULT 
FROM GR 
WHERE RN = 1;