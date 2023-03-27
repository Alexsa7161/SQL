/*
���������� ��� ����� �� �������� ����� ����� ��������� ����� ������ � ����������� �������������, ������� ���������� �� �������� ����� �� ������� �������, � ������� �������� ����� �� �������� ������� ��� �������� ����� �������.
��������� ������ ��������� 4 �������:
 1) �������� �������� �������, ���������� ����� ����� � ��������� ������� �������� ����� �������� �������; 
2) �������� ������� �������, ���������� ����� ����� � ��������� ������� ���������� ����� ������� �������; 
3) ���������� �������������, ������� ���������� �� �������� ����� �� ������� �������; 
4) ������� �������� �����.

*/
SELECT  CN.TABLE_NAME || '.' || CL.COLUMN_NAME "CUST.FK", CNR.TABLE_NAME || '.' || CLR.COLUMN_NAME "SUPP.PK",  --����� �������� ������� �� �������, ������������ ������� �� ��������
NVL(PRIV.DEL_CNT, 0) "US_DEL_CNT", CN.DELETE_RULE 
FROM USER_CONSTRAINTS CN LEFT JOIN USER_CONS_COLUMNS CL ON CL.CONSTRAINT_NAME = CN.CONSTRAINT_NAME  -- ���������� ���������� �� ������������ ������ �� ��������� �����������  �� ����� ����������� �������� �������
LEFT JOIN USER_CONS_COLUMNS CLR ON CLR.CONSTRAINT_NAME = CN.R_CONSTRAINT_NAME AND CL.POSITION = CLR.POSITION  -- ���������� ��� ������� ������� �� ����� ����������� ������� ������� � ������������ ������� 
LEFT JOIN USER_CONSTRAINTS CNR ON CNR.CONSTRAINT_NAME = CN.R_CONSTRAINT_NAME  -- ���������� ��� ������� ������� �� ����� ����������� ������� �������
LEFT JOIN (SELECT TABLE_NAME, COUNT(TABLE_NAME) DEL_CNT     -- ���������� � �������� ALL_TAB_PRIVS ��� ������ ����� ������������� � ����������� �� �������� ����� ������� ������� �� ������� ����� ������� �������
           FROM ALL_TAB_PRIVS 
           WHERE PRIVILEGE = 'DELETE' AND TYPE = 'TABLE' 
           GROUP BY TABLE_NAME) PRIV ON PRIV.TABLE_NAME = CNR.TABLE_NAME 
WHERE CN.CONSTRAINT_TYPE = 'R';                        -- ����������� �������� �����
