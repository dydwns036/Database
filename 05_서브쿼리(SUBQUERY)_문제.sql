--1. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                      FROM EMPLOYEE); 

--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
SELECT EMP_ID, EMP_NAME, 
        EXTRACT(YEAR FROM SYSDATE) - 
        CASE
            WHEN SUBSTR(EMP_NO, 1, 2) <= TO_CHAR(SYSDATE, 'YY') THEN 
                2000 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
            ELSE 
                1900 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
            END + 1 AS "나이",
        DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - 
        CASE
            WHEN SUBSTR(EMP_NO, 1, 2) <= TO_CHAR(SYSDATE, 'YY') THEN 
                2000 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
            ELSE 
                1900 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
            END = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - 
                                CASE
                                WHEN SUBSTR(EMP_NO, 1, 2) <= TO_CHAR(SYSDATE, 'YY') THEN 
                                    2000 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
                                ELSE 
                                    1900 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
                                END)
                    FROM EMPLOYEE);