/*
�������� ������ ��� ������ ������� � ������� ���� ��������,
���������� � ����� ������ � ����� ��������, ������� �������� �������� ����� �u�.
*/
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN( (SELECT DEPARTMENT_ID
                         FROM EMPLOYEES
                         WHERE LOWER(LAST_NAME) LIKE('%u%')))
