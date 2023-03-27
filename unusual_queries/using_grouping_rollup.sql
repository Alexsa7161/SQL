/*
�������� � ����� ������ ��� ������� ������: ���
�����, ������������, ���������� ���������� �����������,
������� ����� ������ �� ���������� ������� �� �������
���������� � �������, ����� � ���������.
*/
SELECT 
    DECODE(GROUPING(employee_id), 1, TO_CHAR(department_id), ' ') "����� ������", 
    DECODE(GROUPING(employee_id), 1, department_name, ' ') "�������� ������", 
    DECODE(GROUPING(employee_id), 1, TO_CHAR(COUNT(employee_id)), ' ') "���-�� �����������", 
    DECODE(GROUPING(employee_id), 1, NVL(TO_CHAR(ROUND(AVG(salary), 2)), ' '), ' ') "������� �����",
    NVL(last_name, ' ') "�������",
    DECODE(GROUPING(employee_id), 0, NVL(TO_CHAR(salary), '0'), ' ') "�����",
    NVL(job_title, ' ') "���������"
FROM departments
LEFT JOIN employees USING(department_id)
LEFT JOIN jobs USING(job_id)
GROUP BY ROLLUP (
    (department_id, department_name), 
    (employee_id, last_name, salary, job_title) 
)
HAVING GROUPING(department_id) = 0 AND NOT (GROUPING(employee_id) = 0 AND COUNT(employee_id) = 0) 
ORDER BY department_id, employee_id DESC;
