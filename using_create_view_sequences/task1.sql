/*
�������� ������������� DEPT50, ���������� ����� ��������� � ����� ������ ��� ���� �������� ������ 50.
��������� �������� �������� ��������� � ������ ����� ����� �������������.
*/
CREATE VIEW DEPT50 AS
SELECT EMPLOYEE_ID EMPNO,LAST_NAME EMPLOYEE, DEPARTMENT_ID DEPTNO
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
WITH CHECK OPTION;
