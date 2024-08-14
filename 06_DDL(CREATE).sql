/*
    * ������ ���� ���(DDL)
    ����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DELETE)�ϴ� ���
    ��, ���� ������ ���� �ƴ� ��Ģ ��ü�� �����ϴ� ���
    
    ����Ŭ���� ��ü(����) : ���̺�, ��, ������, 
                         �ε���, ��Ű��, Ʈ����, 
                         ���ν���, �Լ�, ���Ǿ�, �����
                         
    <CREATE>
    ��ü�� ���� �����ϴ� ����
*/

/*
    1. ���̺� ����
    - ���̺� : ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
              ��� �����͵��� ���̺��� ���ؼ� �����
              (DBMS��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
              
    [ǥ����]
    CREATE TABLE ���̺��(
        Į����, �ڷ���(ũ��),
        Į����, �ڷ���(ũ��),
        Į����, �ڷ���,
        ...
    )
    
    * �ڷ���
    - ����(CHAR(����Ʈ ũ��) | VARCHAR2(����Ʈ ũ��)) -> �ݵ�� ũ�� ������ ����� ��
        - CHAR : �ִ� 2000����Ʈ���� �������� / ��������(������ ���ڼ��� �����ʹ�� ���)
        - VARCHAR2 : �ִ� 4000����Ʈ���� �������� / ��������(�� ������ �����Ͱ� ������ �𸣴� ���)
    - ����(NUMBER) 
    - ��¥(DATE) 
*/

-- ȸ���� ���� �����͸� ������� ���̺� MEMBER ����
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),    -- user01, dydwns036
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),         -- ��, ��
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;
---------------------------------------------------------------------------------------------------------------
/*
    2. �÷��� �ּ��ޱ�(�÷��� ���� ������ ����)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    -> �߸� �ۼ��� ���� �����ϸ� �ȴ�.
*/

COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN member.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

-- ���̺��� �����ϰ��� �� �� : DROP TABLE ���̺��;
DROP TABLE MEMBER;

-- INSERT INTO ���̺�� VALUES(��, ��, ��...);
INSERT INTO MEMBER
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAA@GMAIL.COM', '24/08/12');

INSERT INTO MEMBER
VALUES(1, 'USER1', 'PASS1', NULL, NULL, '010-2222-3333', 'AAA2@GMAIL.COM', NULL);

---------------------------------------------------------------------------------------------------------------
/*
    <��������>
    - ���ϴ� ������ ��(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    
    ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FORIGN KEY
*/

/*
    * NOT NULL
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, ���� NULL�� ������ �ȵǴ� ���)
    ����/���� ��, NULL ���� ������� �ʵ��� ����
    
    ���������� �ο��ϴ� ����� ũ�� 2������ �ִ�. (�÷��������, ���̺������)
    NOT NULL ���������� ������ �÷�����������θ� ����
*/

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

INSERT INTO MEM_NOTNULL
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'ONE@NAVER.COM', '24/08/12');

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(2, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);

INSERT INTO MEM_NOTNULL
VALUES(3, NULL, 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);
-- �ǵ��ߴ���� ������ �߻��Ѵ�.(NOT NULL �������� ����);

INSERT INTO MEM_NOTNULL
VALUES(3, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);
-- ���̵� �ߺ��Ǿ������� �ұ��ϰ� �� �߰��� �ȴ�.

---------------------------------------------------------------------------------------------------------------
/*
    * UNIQUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �ȵ� ��� ����Ѵ�.
    �÷� ���� �ߺ� ���� �����ϴ� ���������̴�.
    ����/������ ������ �ִ� ������ �� �� �ߺ� ���� ���� ��� ������ �߻���Ų��.
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
    -- UNIQUE(MEM_ID) ���̺������
);

INSERT INTO MEM_UNIQUE
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

INSERT INTO MEM_UNIQUE
VALUES(1, 'USER1', 'PASS2', 'ȫ���', '��', '010-1111-3333', 'BBB@NAVER.COM', '24/01/02');
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����
--> ���� ������ �������Ǹ����� �˷��ش�.
--> ���� �ľ��ϱ� ��ƴ�.
--> ���� ���� �ο��� �������Ǹ��� ������ �� �ִ�.(�������� ������ �ý��ۿ��� �ڵ����� �ο���)

---------------------------------------------------------------------------------------------------------------

/*
    * ���� ���� �ο��� �������Ǹ���� �ο��ϴ� ���
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� (CONSTRAINT �������Ǹ�) ��������
    }
    
    > ���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���
        (CONSTRAINT �������Ǹ�) ��������(�÷���)
    }
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL, -- �÷��������
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE,
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) --���̺������
);

INSERT INTO MEM_UNIQUE
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

INSERT INTO MEM_UNIQUE
VALUES(2, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE
VALUES(3, 'USER3', 'PASS3', 'ȫ���', NULL, NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE
VALUES(4, 'USER4', 'PASS4', NULL, NULL, NULL, NULL, NULL);

---------------------------------------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�)
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� �ִ�.
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
    -- CHECK(GENDER IN ('��', '��'))
);

INSERT INTO MEM_CHECK
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

INSERT INTO MEM_CHECK
VALUES(1, 'USER2', 'PASS2', 'ȫ���', NULL, NULL, NULL, NULL);

INSERT INTO MEM_CHECK
VALUES(1, 'USER3', 'PASS3', 'ȫ���', '��', NULL, NULL, NULL);
--> CHECK �������� ������ ���ܰ� �߻��Ѵ�.
--> GENDER �÷����� CHECK ���������� �����ϴ� ���� �־���Ѵ�.
--> �� NULL�� ���� ���ٴ� ���̱� ������ �����ϴ�.

---------------------------------------------------------------------------------------------------------------

/*
    PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ��(ROW)�� �ĺ��ϱ����� ���� �÷��� �ο��ϴ� ��������(�ĺ��� ����)
    
    EX) ȸ����ȣ, �й�, ����, �μ��ڵ�, �����ڵ�, �ֹι�ȣ, �ֹ���ȣ, �ù������ȣ, �����ȣ....
    PRIMARY KEY -> NOT NULL + UNIQUE
    
    �� ���̺� ���� �� ���� ���� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

INSERT INTO MEM_PRI
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

INSERT INTO MEM_PRI
VALUES(1, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL, NULL);
--> �⺻Ű�� �ߺ� ���� �������� �� ��(UNIQUE �������� ����)

INSERT INTO MEM_PRI
VALUES(NULL, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL, NULL);
--> �⺻Ű�� NULL�� �������� �� ��(NOT NULL �������� ����)

INSERT INTO MEM_PRI
VALUES(2, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL, NULL);

---------------------------------------------------------------------------------------------------------------
CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20), -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE,
    PRIMARY KEY(MEM_NO, MEM_ID)
);
-- ����Ű : �ΰ��� �÷��� ���ÿ� �ϳ��� PRIMARY KEY�� �����ϴ� ��

INSERT INTO MEM_PRI2
VALUES(1, 'USER1', 'PASS1', 'ȫ�浿', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

INSERT INTO MEM_PRI2
VALUES(1, 'USER2', 'PASS2', 'ȫ���', '��', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(2, 'USER3', 'PASS3', 'ȫ���', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

INSERT INTO MEM_PRI2
VALUES(2, 'USER3', 'PASS3', 'ȫ���', '��', '010-1111-2222', 'AAAA@NAVER.COM', '24/01/01');

-- ����Ű ��� ����(� ȸ���� � ��ǰ�� ���ߴ����� ���� �����͸� �����ϴ� ���̺�)
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

-- ȸ���� 2��(1��, 2��) ����
-- ��ǰ�� 2��(A24, I14PRO)

INSERT INTO TB_LIKE VALUES(1,'A24', SYSDATE);
SELECT * FROM TB_LIKE;
INSERT INTO TB_LIKE VALUES(1,'I14PRO', SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'I14PRO', SYSDATE);

---------------------------------------------------------------------------------------------------------------
-- ȸ�� ��޿� ���� �����͸� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03', '�ֿ���', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04', '���ؿ�', '��', NULL, NULL, 30);

INSERT INTO MEM VALUES(5, 'USER5', 'PASS05', '����', '��', NULL, NULL, 40);

SELECT * FROM MEM;
-- ��ȿ���� ���� ȸ����޹�ȣ�� ���������� INSERT�ǰ� �ִ�.

---------------------------------------------------------------------------------------------------------------
/*
    FOREIGN KEY(�ܷ�Ű) ��������
    �ٸ� ���̺� �����ϴ� ���� ���;ߵǴ� Ư�� �÷��� �ο��ϴ� ��������
    -> �ٸ� ���̺��� �����Ѵٰ� ǥ��
    -> �ַ� FOREIGN KEY ������������ ���� ���̺� ���谡 �����ȴ�.
    
    > Į���������
    Į���� �ڷ��� REFERENCES ������ ���̺��[������ �÷���]
    
    > ���̺������
    FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[������ �÷���]
    
    -> ������ �÷��� ���� ��, ������ ���̺��� PRIMARY KEY�� ������ Į���� ��Ī�ȴ�.
*/
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, -- REFERENCES MEM_GRADE(GRADE_CODE)
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03', '�ֿ���', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04', '���ؿ�', '��', NULL, NULL, 30);

INSERT INTO MEM VALUES(5, 'USER5', 'PASS05', '����', '��', NULL, NULL, 40);
--PARENT KEY�� ã�� �� ���ٴ� ���� �߻�

SELECT * FROM MEM;
-- MEM_GRADE(�θ����̺�) -| ------------ <- MEM(�ڽ����̺�)
-- 1 : N���� 1���� �θ����̺�, N�� �ڽ����̺�

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- MEM ���̺��� 10�̶�� ���� ����ϰ� �ֱ� ������ ������ �ȵ�

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
-- MEM ���̺��� 30�̶�� ���� ����ϰ� ���� �ʱ� ������ ������ �ȴ�.

-- �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ���
-- �θ����̺�κ��� ������ ������ �ȵǴ� "��������" �ɼ��� �ɷ��ִ�.

---------------------------------------------------------------------------------------------------------------
/*
    �ڽ����̺� ���� ��, �ܷ�Ű �������� �ο��� �� �����ɼ� ��������
    * �����ɼ� : �θ����̺��� ������ ���� ��, �� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ��� �� ���ΰ�?
    
    - ON DELETE RESTRICTED(�⺻��) : �������ѿɼ�, �ڽĵ����ͷκ��� ���̴� �θ����ʹ� ������ �ƿ� �ȵ�
    - ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ������� ���� NULL�� ����
    - ON DELETE CASCADE : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ���� �����ض�
*/

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, -- REFERENCES MEM_GRADE(GRADE_CODE)
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03', '�ֿ���', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04', '���ؿ�', '��', NULL, NULL, 30);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, -- REFERENCES MEM_GRADE(GRADE_CODE)
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01', 'ȫ�浿', '��', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02', 'ȫ���', '��', NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03', '�ֿ���', '��', NULL, NULL, 20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04', '���ؿ�', '��', NULL, NULL, 30);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

---------------------------------------------------------------------------------------------------------------
/*
    <DEFAULT �⺻��> * ���������� �ƴϴ�.
    �÷��� �������� �ʰ� INSERT�� NULL�� �ƴ� �⺻���� INSERT�ϰ��� �Ѵ�.
    �̶� ������ �� �� �ִ� ��
    
    �÷��� �ڷ��� DEFAULT �⺻��
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- INSERT INTO ���̺�� VALUES(��1, ��2,...)
INSERT INTO MEMBER VALUES(1, '������', 20, '�', '20/01/01');
INSERT INTO MEMBER VALUES(2, '����', 20, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '�ֿ���', 20, DEFAULT, DEFAULT);

-- INSERT INTO ���̺�� (�÷�1, �÷�2...) VALUES(�÷�1 ��, �÷�2 ��)
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '�̰���');
--> ���õ��� ���� �÷����� �⺻������ NULL�� ��
--> ��, �ش� �÷��� DEFAULT ���� �ο��Ǿ� ���� ��� NULL�� �ƴ� DEFAULT ���� ��

---------------------------------------------------------------------------------------------------------------
-- ���̺��� ������ �� �ִ�. ���⼭���� KH���� �̿�
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * FROM EMPLOYEE);

DROP TABLE EMPLOYEE_COPY;
---------------------------------------------------------------------------------------------------------------
/*
    ���̺��� �� ������ �Ŀ� �ڴʰ� ���������� �߰��ϴ� ���
    ALTER TABLE ���̺�� ������ ����
    
    -- PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    -- FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[�÷���];
    -- UNIQUE : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    -- CHECK : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    -- NOT NULL : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
*/

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);
--ALTER TABLE EMPLOYEE MODIFY EMP_NO NOT NULL;