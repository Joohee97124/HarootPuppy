SELECT USER
FROM DUAL;
--==>> HAROOTPUPPY


-- MemberDAO.xml

SELECT *
FROM MEMBERVIEW;


-- 회원 수 확인
SELECT COUNT (*) AS COUNT
FROM MEMBERVIEW;
--==>> 8


-- 회원 번호의 최대값
SELECT MAX(TO_NUMBER((SUBSTR(MEM_CODE, 4, 6))))
FROM MEMBERVIEW;
--==>> 10


-- 회원 리스트 확인
SELECT SID_CODE, MEM_CODE, MEM_ID, MEM_PW, MEM_NAME, MEM_BIRTH  -- 6
    , MEM_GENDER, MEM_TEL, MEM_ADDR, MEM_REGDATE, MEM_NICKNAME  -- 5
    , PAUSE_CODE ,PAUSE_START, OUT_CODE, OUT_TYPE_CODE, OUT_DATE -- 5
    , WALK_AGREE_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE, OUT_TYPE_CONTENT
FROM MEMBERVIEW;
--==>> 나옴 

SELECT SID_CODE, MEM_CODE, MEM_ID, MEM_PW, MEM_NAME, MEM_BIRTH  
    	, MEM_GENDER, MEM_TEL, MEM_ADDR, MEM_REGDATE, MEM_NICKNAME  
    	, PAUSE_CODE ,PAUSE_START, OUT_CODE, OUT_TYPE_CODE, OUT_DATE 
    	, WALK_AGREE_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE, OUT_TYPE_CONTENT
		FROM MEMBERVIEW;


-- 회원 데이터 추가
INSERT INTO TBL_MEMBER(MEM_CODE, MEM_ID, MEM_PW, MEM_NAME
, MEM_BIRTH, MEM_GENDER, MEM_TEL
, MEM_ADDR, MEM_REGDATE, MEM_NICKNAME)
VALUES ('#{mem_code}', '#{mem_id}', CRYPTPACK.ENCRYPT('#{mem_pw}', '#{mem_id}'), '#{mem_name}'
, TO_DATE('#{mem_birth}', 'YYYY-MM-DD'), '#{mem_gender}', '#{mem_tel}'
, '#{mem_addr}', TO_DATE('#{mem_gendate}', 'YYYY-MM-DD'), '#{mem_nickname}');


-- 회원 검색(회원번호, 이름, 아이디로 검색 가능)
SELECT SID_CODE, MEM_CODE, MEM_ID, MEM_PW, MEM_NAME, MEM_BIRTH  -- 6
    , MEM_GENDER, MEM_TEL, MEM_ADDR, MEM_REGDATE, MEM_NICKNAME  -- 5
    , PAUSE_CODE ,PAUSE_START, OUT_CODE, OUT_TYPE_CODE, OUT_DATE -- 5
    , WALK_AGREE_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE, OUT_TYPE_CONTENT
FROM MEMBERVIEW
WHERE MEM_CODE = '{#mem_code}';

SELECT SID_CODE, MEM_CODE, MEM_ID, MEM_PW, MEM_NAME, MEM_BIRTH  -- 6
    , MEM_GENDER, MEM_TEL, MEM_ADDR, MEM_REGDATE, MEM_NICKNAME  -- 5
    , PAUSE_CODE ,PAUSE_START, OUT_CODE, OUT_TYPE_CODE, OUT_DATE -- 5
    , WALK_AGREE_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE, OUT_TYPE_CONTENT
FROM MEMBERVIEW
WHERE MEM_CODE = 'MEM001';


--  왜이제야 들리죠~~오오~~~ 우우우~~~~ 서롤 만나기 위해 ~(by 하림)


-------------------- 회원 수정

-- MEM테이블 업데이트 전 동의테이블 INSERT가 먼저 입력되어야함.
-- 입력값이 이전 값과 같을 경우 INSERT 되지 않아야 함.

SELECT *
FROM TBL_WALK_AGREE;


INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
VALUES('{#walk_agree_code}', '{#sid_code}', '{#walkd_agree_check}', '{#walk_agree_date}');


UPDATE TBL_MEMBER
SET MEM_PW = '{#mem_pw}', MEM_TEL = '{#mem_tel}'
, MEM_ADDR = '{#mem_addr}', MEM_NICKNAME = '{#mem_addr}'
WHERE MEM_CODE = '{#mem_code}';
정



-- 회원 삭제(탈퇴)

DELETE
FROM TBL_MEMBER
WHERE MEM_ID = '{#mem_id}';



-- 국진수 회원 수정
SELECT *
FROM TBL_MEMBER
ORDER BY MEM_CODE;

ROLLBACK;

UPDATE TBL_MEMBER
SET MEM_TEL='010-8282-8282'
WHERE MEM_CODE = 'MEM012';



UPDATE TBL_MEMBER
SET MEM_TEL='010-1231-1231'
WHERE MEM_CODE = 'MEM011';

UPDATE TBL_MEMBER
SET MEM_REGDATE = TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')
WHERE MEM_CODE = 'MEM012';


alter session set nls_date_format='YYYY/MM/DD HH24:MI:SS'; 

-- 되는 
SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

commit;

---------------SID 테이블, 산책 동의 테이블 입력(회원가입시 실행되어야 함)--------------------------

SELECT *
FROM TBL_MEMBER 
ORDER BY MEM_CODE;

SELECT * 
FROM TBL_WALK_AGREE
ORDER BY WALK_AGREE_CODE;

SELECT *
FROM TBL_SID;


INSERT INTO TBL_SID(SID_CODE, MEM_CODE)
VALUES('SID011', 'MEM011');
INSERT INTO TBL_SID(SID_CODE, MEM_CODE)
VALUES('SID012', 'MEM012');


INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
VALUES('AGR009', 'SID009', 'Y', TO_DATE('2021-06-23 00:00:00'));

INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
VALUES('AGR010', 'SID010', 'Y', TO_DATE('2021-06-26 00:00:00'));

INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
VALUES('AGR011', 'SID011', 'Y', TO_DATE('2021-07-06 13:12:24'));

INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
VALUES('AGR012', 'SID012', 'Y', TO_DATE('2021-07-07 18:27:12'));


commit;


----------------------------------------------------------------------------------------
MEM_CODE 등... 각종 코드 만들기


SELECT CASE WHEN LENGTH(TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)) = 1
            THEN 'MEM'|| '00' || TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)
            WHEN LENGTH(TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)) = 2
            THEN 'MEM'|| '0' || TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)
            ELSE 'MEM'|| TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)
            END AS MEM_CODE
FROM TBL_MEMBER;


SELECT CASE WHEN LENGTH(TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)) = 1
            THEN 'MEM'|| '00' || TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)
            WHEN LENGTH(TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)) = 2
            THEN 'MEM'|| '0' || TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)
            ELSE 'MEM'|| TO_CHAR(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6)))+1)
            END AS MEM_CODE
FROM TBL_MEMBER;



EXEC PRC_MEMBER_INSERT('milky_bboy', '6969', '백도준', '1999-12-24', 'M', '010-1435-1234', '인천시 연수구 송도동 12', '백설기12', 'Y')

ROLLBACK;

SELECT *
FROM TBL_MEMBER
ORDER BY MEM_CODE;

SELECT *
FROM TBL_SID;

SELECT *
FROM TBL_WALK_AGREE;