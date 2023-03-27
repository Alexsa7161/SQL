/*
�������� ������������� SALARY_VU, ���������� ������� ���������,
�������� ������, ����� � ��������� ������ ��� ���� ��������.
*/
CREATE VIEW SALARY_VU AS
SELECT LAST_NAME, DEPARTMENT_NAME, SALARY, GRADE_LEVEL
FROM EMPLOYEES LEFT JOIN DEPARTMENTS USING(DEPARTMENT_ID)
LEFT JOIN JOB_GRADES ON SALARY BETWEEN LOWEST_SAL AND HIGHEST_SAL;

