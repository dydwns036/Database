-- 1.
SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "이름", TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 2.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

-- 3.
SELECT PROFESSOR_NAME AS "교수이름", 
       TRUNC(TO_NUMBER(SYSDATE - 
       CASE
        WHEN SUBSTR(PROFESSOR_SSN, 1, 2) <= TO_CHAR(SYSDATE, 'YY') THEN
            TO_DATE(2000 + TO_NUMBER(SUBSTR(PROFESSOR_SSN, 1, 2)) || SUBSTR(PROFESSOR_SSN, 3, 4), 'YYMMDD')
        ELSE 
            TO_DATE(1900 + TO_NUMBER(SUBSTR(PROFESSOR_SSN, 1, 2)) || SUBSTR(PROFESSOR_SSN, 3, 4), 'YYMMDD')
        END) / 365) AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1;


-- 4.
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) AS "이름"
FROM TB_PROFESSOR;

-- 5. X
SELECT STUDENT_NO, STUDENT_NAME, TO_NUMBER(ENTRANCE_DATE - 
       CASE
        WHEN SUBSTR(STUDENT_SSN, 1, 2) <= TO_CHAR(SYSDATE, 'YY') THEN
            TO_DATE(2000 + TO_NUMBER(SUBSTR(STUDENT_SSN, 1, 2)) || SUBSTR(STUDENT_SSN, 3, 4), 'YYMMDD')
        ELSE 
            TO_DATE(1900 + TO_NUMBER(SUBSTR(STUDENT_SSN, 1, 2)) || SUBSTR(STUDENT_SSN, 3, 4), 'YYMMDD')
        END) AS "학생 나이"
FROM TB_STUDENT;

-- 6.
SELECT TO_CHAR(TO_DATE(20201225), 'DAY')
FROM DUAL;

/*
    -- 7.
    TO_DATE('99/10/11', 'YY/MM/DD') -> 2099/10/11
    TO_DATE('49/10/11', 'YY/MM/DD') -> 2049/10/11
    TO_DATE('99/10/11', 'RR/MM/DD') -> RR은 50년 이상값이 들어오면 - 100 -> 1999/10/11
    TO_DATE('49/10/11', 'RR/MM/DD') -> 1949/10/11
*/

-- 8.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9.
SELECT ROUND(AVG(POINT), 1) AS "평점"
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE STUDENT_NO = 'A517178';


-- 10.
SELECT DEPARTMENT_NO AS "학과번호", COUNT(DEPARTMENT_NO) AS "학생수(명)"
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12.
SELECT SUBSTR(TERM_NO, 1, 4) AS "년도", ROUND(AVG(POINT), 1) AS "년도 별 평점"
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 년도;

-- 13. X
SELECT DEPARTMENT_NO AS "학과 코드명", COUNT(DECODE(ABSENCE_YN, 'Y', 1)) AS "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;


-- 14.
SELECT DISTINCT STUDENT_NAME, COUNT(STUDENT_NAME)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) > 1;

-- 15. X
SELECT SUBSTR(TERM_NO, 1, 4) AS "년도", SUBSTR(TERM_NO, 5, 6) AS "학기", POINT AS "평점"
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113'

UNION ALL

SELECT SUBSTR(TERM_NO, 1, 4) AS "년도", ' ' AS "학기", ROUND(AVG(POINT), 1) AS "평점"
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY "년도";