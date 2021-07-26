--○ PRC_MEMBER_INSERT
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_MEM_ID              IN TBL_MEMBER.MEM_ID%TYPE
, V_MEM_PW              IN TBL_MEMBER.MEM_PW%TYPE
, V_MEM_NAME            IN TBL_MEMBER.MEM_NAME%TYPE
, V_MEM_BIRTH           IN TBL_MEMBER.MEM_BIRTH%TYPE
, V_MEM_GENDER          IN TBL_MEMBER.MEM_GENDER%TYPE
, V_MEM_TEL             IN TBL_MEMBER.MEM_TEL%TYPE
, V_MEM_ADDR            IN TBL_MEMBER.MEM_ADDR%TYPE
, V_MEM_NICKNAME        IN TBL_MEMBER.MEM_NICKNAME%TYPE
, V_WALK_AGREE_CHECK    IN TBL_WALK_AGREE.WALK_AGREE_CHECK%TYPE
)
IS
    V_MEM_CODE            TBL_MEMBER.MEM_CODE%TYPE;
    V_SID_CODE            TBL_SID.SID_CODE%TYPE;
    V_WALK_AGREE_CODE     TBL_WALK_AGREE.WALK_AGREE_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- MEM_CODE 자동입력
    SELECT CONCAT('MEM', NVL(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6))), 0) + 1) INTO V_MEM_CODE
    FROM TBL_MEMBER;
    
    -- INSERT MEMBER 쿼리문
    INSERT INTO TBL_MEMBER(MEM_CODE, MEM_ID, MEM_PW, MEM_NAME
    , MEM_BIRTH, MEM_GENDER, MEM_TEL
    , MEM_ADDR, MEM_REGDATE, MEM_NICKNAME)
    VALUES (V_MEM_CODE, V_MEM_ID, CRYPTPACK.ENCRYPT(V_MEM_PW, V_MEM_ID), V_MEM_NAME
    , TO_DATE(V_MEM_BIRTH, 'YYYY-MM-DD'),  V_MEM_GENDER
    , (SUBSTR(V_MEM_TEL, 1, 3) || '-' || SUBSTR(V_MEM_TEL, 5, 8) || SUBSTR(V_MEM_TEL, 10, 13))
    , V_MEM_ADDR
    , TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')
    , V_MEM_NICKNAME);
    
    
    -- SID_CODE 자동입력
    SELECT CONCAT('SID', NVL(MAX(TO_NUMBER(SUBSTR(SID_CODE, 4))),0) + 1) INTO V_SID_CODE
    FROM TBL_SID;   
    
    -- INSERT SID 쿼리문
    INSERT INTO TBL_SID(SID_CODE, MEM_CODE)
    VALUES(V_SID_CODE, V_MEM_CODE);
    
    
     -- WALK_AGREE_CODE 자동입력
    SELECT CONCAT('AGR', NVL(MAX(TO_NUMBER(SUBSTR(WALK_AGREE_CODE, 4))), 0) + 1) INTO V_WALK_AGREE_CODE
    FROM TBL_WALK_AGREE;   
    
    -- INSERT WALK_AGREE 쿼리문
    INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
    VALUES(V_WALK_AGREE_CODE, V_SID_CODE, V_WALK_AGREE_CHECK
    , TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS'));
        
    
END;

   SELECT CONCAT('MEM', NVL(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4))), 0) + 1) 
    FROM TBL_MEMBER;


--------------------------------------------------------------------------------

EXEC PRC_DIARY_MEAL_INSERT('김치밥01', '오리젠', 50, '1', '빨리먹음', 'C:\', 'SID001', 'PET003', TO_DATE('2021-07-09 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-07-09 20:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
EXEC PRC_DIARY_MEAL_INSERT(NULL, '오리젠', 100, '1', '조금 남김', 'C:\', 'SID001', 'PET003', TO_DATE('2021-07-09 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-07-09 22:00:00', 'YYYY-MM-DD HH24:MI:SS')); 

EXEC PRC_DIARY_MEAL_INSERT2('캐닌', 100, '1', '양이적은가?', 'C:', 'SID001', 'PET003', TO_DATE('2021-07-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-07-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));


SELECT *
FROM TBL_FAVORITE;

SELECT *
FROM TBL_COMMON;

ROLLBACK;

--------------------------------------------------------------------------------

--○ PRC_DIARY_MEAL_INSERT
-- 다이어리 : 식사 입력
CREATE OR REPLACE PROCEDURE PRC_DIARY_MEAL_INSERT
( V_FAVORITE_NAME       IN TBL_FAVORITE.FAVORITE_NAME%TYPE
, V_MEAL_NAME           IN TBL_MEAL_INFO.MEAL_NAME%TYPE
, V_MEAL_AMOUNT         IN TBL_MEAL_INFO.MEAL_AMOUNT%TYPE
, V_MEAL_TYPE           IN TBL_MEAL_INFO.MEAL_TYPE%TYPE
, V_COMMON_MEMO         IN TBL_COMMON.COMMON_MEMO%TYPE
, V_COMMON_PHOTO        IN TBL_COMMON.COMMON_PHOTO%TYPE
, V_SID_CODE            IN TBL_SID.SID_CODE%TYPE
, V_PET_CODE            IN TBL_PET.PET_CODE%TYPE
, V_COMMON_START        IN TBL_COMMON.COMMON_START%TYPE
, V_COMMON_END          IN TBL_COMMON.COMMON_END%TYPE
)
IS
    V_DAILY_CODE        TBL_DAILY.DAILY_CODE%TYPE;
    V_RELATION_CODE     TBL_RELATION.RELATION_CODE%TYPE;
    V_FAVORITE_CODE     TBL_FAVORITE.FAVORITE_CODE%TYPE;
    V_COMMON_CODE       TBL_COMMON.COMMON_CODE%TYPE;
    V_MEAL_INFO_CODE    TBL_MEAL_INFO.MEAL_INFO_CODE%TYPE;
    V_MEAL_CODE         TBL_MEAL.MEAL_CODE%TYPE;

BEGIN
    -- 일일관리 (TBL_DAILY) INSERT
    -- DAILY_CODE 자동입력
    SELECT CONCAT('DAILY', NVL(MAX(TO_NUMBER(SUBSTR(DAILY_CODE, 6))), 0) + 1) INTO V_DAILY_CODE
    FROM TBL_DAILY;

    -- RELATION_CODE 찾아오기
    SELECT RELATION_CODE INTO V_RELATION_CODE
    FROM TBL_RELATION
    WHERE PET_CODE = V_PET_CODE
    AND SID_CODE = V_SID_CODE;
    
   -- TBL_DAILY에 INSERT (일일코드가 없어야 생성O)
    INSERT INTO TBL_DAILY(DAILY_CODE, RELATION_CODE)
    VALUES(V_DAILY_CODE
    , (SELECT RELATION_CODE FROM TBL_RELATION WHERE PET_CODE=V_PET_CODE AND SID_CODE= V_SID_CODE)
    );
    
    
    
    --● FAVORITE (즐겨찾기) INSERT
    --  FAV_CODE 자동입력
    IF V_FAVORITE_NAME != NULL THEN
       SELECT CONCAT('FAV', NVL(MAX(TO_NUMBER(SUBSTR(FAVORITE_CODE, 9))), 0) + 1) INTO V_FAVORITE_CODE
       FROM TBL_FAVORITE;
    END IF;
    
    -- TBL_FAVORITE(즐겨찾기) 테이블에도 내용 저장
    IF V_FAVORITE_NAME != NULL THEN
        INSERT INTO TBL_FAVORITE(FAVORITE_CODE, RELATION_CODE, FAVORITE_NAME)
        VALUES(V_FAVORITE_CODE, V_RELATION_CODE , V_FAVORITE_NAME);
   END IF;
    
    --● TBL_COMMON (공통항목) INSERT
    -- COMMON_CODE 자동입력
    SELECT CONCAT('COM', NVL(MAX(TO_NUMBER(SUBSTR(COMMON_CODE, 4))), 0) + 1) INTO V_COMMON_CODE
    FROM TBL_COMMON;
    
    -- TBL_COMMON (공통항목) 테이블에도 내용 저장
    INSERT INTO TBL_COMMON(COMMON_CODE, COMMON_START, COMMON_END, COMMON_MEMO, COMMON_PHOTO, DAILY_CODE)
    VALUES(V_COMMON_CODE, V_COMMON_START, V_COMMON_END, V_COMMON_MEMO, V_COMMON_PHOTO, V_DAILY_CODE);
    
    
    --● TBL_MEAL_INFO (사료) INSERT
    -- MEAL_CODE 자동입력
    SELECT CONCAT('MEA', NVL(MAX(TO_NUMBER(SUBSTR(MEAL_INFO_CODE, 4))), 0) + 1) INTO V_MEAL_INFO_CODE
    FROM TBL_MEAL_INFO;
    
    -- TBL_MEAL (사료) 테이블에도 내용 저장
    INSERT INTO TBL_MEAL_INFO(MEAL_INFO_CODE, FAVORITE_CODE, MEAL_NAME, MEAL_TYPE, MEAL_AMOUNT, UNIT_CODE)
    VALUES(V_MEAL_INFO_CODE, V_FAVORITE_CODE, V_MEAL_NAME, V_MEAL_TYPE, V_MEAL_AMOUNT, 1);
    
    
    --● TBL_MEAL (사료입력) INSERT
    SELECT CONCAT('MEC', NVL(MAX(TO_NUMBER(SUBSTR(MEAL_CODE, 4))), 0) + 1) INTO V_MEAL_CODE
    FROM TBL_MEAL;
    
    -- TBL_MEAL(사료입력) 테이블에도 내용 저장
    INSERT INTO TBL_MEAL(MEAL_CODE, MEAL_INFO_CODE, COMMON_CODE)
    VALUES(V_MEAL_CODE, V_MEAL_INFO_CODE, V_COMMON_CODE);
    
END;


--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PRC_DIARY_MEAL_INSERT2
( V_MEAL_NAME           IN TBL_MEAL_INFO.MEAL_NAME%TYPE
, V_MEAL_AMOUNT         IN TBL_MEAL_INFO.MEAL_AMOUNT%TYPE
, V_MEAL_TYPE           IN TBL_MEAL_INFO.MEAL_TYPE%TYPE
, V_COMMON_MEMO         IN TBL_COMMON.COMMON_MEMO%TYPE
, V_COMMON_PHOTO        IN TBL_COMMON.COMMON_PHOTO%TYPE
, V_SID_CODE            IN TBL_SID.SID_CODE%TYPE
, V_PET_CODE            IN TBL_PET.PET_CODE%TYPE
, V_COMMON_START        IN TBL_COMMON.COMMON_START%TYPE
, V_COMMON_END          IN TBL_COMMON.COMMON_END%TYPE
)
IS
    V_DAILY_CODE        TBL_DAILY.DAILY_CODE%TYPE;
    V_RELATION_CODE     TBL_RELATION.RELATION_CODE%TYPE;
    V_COMMON_CODE       TBL_COMMON.COMMON_CODE%TYPE;
    V_MEAL_INFO_CODE    TBL_MEAL_INFO.MEAL_INFO_CODE%TYPE;
    V_MEAL_CODE         TBL_MEAL.MEAL_CODE%TYPE;

BEGIN
    -- 일일관리 (TBL_DAILY) INSERT
    -- DAILY_CODE 자동입력
    SELECT CONCAT('DAILY', NVL(MAX(TO_NUMBER(SUBSTR(DAILY_CODE, 6))), 0) + 1) INTO V_DAILY_CODE
    FROM TBL_DAILY;

    -- RELATION_CODE 찾아오기
    SELECT RELATION_CODE INTO V_RELATION_CODE
    FROM TBL_RELATION
    WHERE PET_CODE = V_PET_CODE
    AND SID_CODE = V_SID_CODE;
    
   -- TBL_DAILY에 INSERT (일일코드가 없어야 생성O)
    INSERT INTO TBL_DAILY(DAILY_CODE, RELATION_CODE)
    VALUES(V_DAILY_CODE
    , (SELECT RELATION_CODE FROM TBL_RELATION WHERE PET_CODE=V_PET_CODE AND SID_CODE= V_SID_CODE)
    );
    
    
    --● TBL_COMMON (공통항목) INSERT
    -- COMMON_CODE 자동입력
    SELECT CONCAT('COM', NVL(MAX(TO_NUMBER(SUBSTR(COMMON_CODE, 4))), 0) + 1) INTO V_COMMON_CODE
    FROM TBL_COMMON;
    
    -- TBL_COMMON (공통항목) 테이블에도 내용 저장
    INSERT INTO TBL_COMMON(COMMON_CODE, COMMON_START, COMMON_END, COMMON_MEMO, COMMON_PHOTO, DAILY_CODE)
    VALUES(V_COMMON_CODE, V_COMMON_START, V_COMMON_END, V_COMMON_MEMO, V_COMMON_PHOTO, V_DAILY_CODE);
    
    
    --● TBL_MEAL_INFO (사료) INSERT
    -- MEAL_CODE 자동입력
    SELECT CONCAT('MEA', NVL(MAX(TO_NUMBER(SUBSTR(MEAL_INFO_CODE, 4))), 0) + 1) INTO V_MEAL_INFO_CODE
    FROM TBL_MEAL_INFO;
    
    -- TBL_MEAL (사료) 테이블에도 내용 저장
    INSERT INTO TBL_MEAL_INFO(MEAL_INFO_CODE, MEAL_NAME, MEAL_TYPE, MEAL_AMOUNT, UNIT_CODE)
    VALUES(V_MEAL_INFO_CODE, V_MEAL_NAME, V_MEAL_TYPE, V_MEAL_AMOUNT, 1);
    
    
    --● TBL_MEAL (사료입력) INSERT
    SELECT CONCAT('MEC', NVL(MAX(TO_NUMBER(SUBSTR(MEAL_CODE, 4))), 0) + 1) INTO V_MEAL_CODE
    FROM TBL_MEAL;
    
    -- TBL_MEAL(사료입력) 테이블에도 내용 저장
    INSERT INTO TBL_MEAL(MEAL_CODE, MEAL_INFO_CODE, COMMON_CODE)
    VALUES(V_MEAL_CODE, V_MEAL_INFO_CODE, V_COMMON_CODE);
    
END;

/*
WHERE B.BOARD_CODE NOT IN (SELECT BR.BOARD_CODE 
                           FROM TBL_REPORT_LOG L, TBL_BOARD_REPORT BR
                           WHERE L.REP_LOG_CODE = BR.REP_LOG_CODE
                           AND L.REP_STATE_CODE NOT IN 2
                           GROUP BY BR.BOARD_CODE);
                           
                           
MERGE INTO TBL_DAILY
USING DUAL
ON (DAILY_DATE = TO_DATE(SYSDATE, 'YYYYMMDD')
    AND RELATION_CODE = (SELECT RELATION_CODE FROM TBL_RELATION WHERE PET_CODE='PET003' AND SID_CODE= 'SID001')
    )
WHEN NOT MATCHED THEN
INSERT INTO (DAILY_CODE, RELATION_CODE)
VALUES(CONCAT('DAILY', NVL(MAX(TO_NUMBER(SUBSTR(DAILY_CODE, 6))), 0) + 1)
    , (SELECT RELATION_CODE FROM TBL_RELATION WHERE PET_CODE='PET003' AND SID_CODE= 'SID001')
    );
 

SELECT *
FROM TBL_DAILY;

INSERT INTO TBL_DAILY(DAILY_CODE, RELATION_CODE)
VALUES(CONCAT('DAILY', NVL(MAX(TO_NUMBER(SUBSTR(DAILY_CODE, 6))), 0) + 1)
    , (SELECT RELATION_CODE FROM TBL_RELATION WHERE PET_CODE='PET003' AND SID_CODE= 'SID001')
    );
*/ 

SELECT *
FROM TBL_MEAL_INFO;

SELECT *
FROM TBL_COMMON;

EXEC PRC_DIARY_MEAL_INSERT2('캐닌', 100, '1', '양이적은가?', 'C:', 'SID001', 'PET003', TO_DATE('2021-07-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-07-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));



SELECT *
FROM TBL_MEAL;

DESC TBL_MEAL_INFO;
DESC TBL_MEAL;
DESC TBL_COMMON;



SELECT PET_CODE, PET_TYPE_NAME, BITE_CONTENT, DESEX_CONTENT
        , PET_SEX, PET_BIRTH, PET_FAV_PLACE, PET_SOCIAL
        , PET_CHAR1_CONTENT, PET_CHAR2_CONTENT, PET_CHAR3_CONTENT
        , PET_CHAR4_CONTENT, PET_SIZE, PET_NAME, PET_PHOTO
        , PET_ADDR, PET_REGNUM
        , RELATION_CODE, SID_CODE
		FROM FORPETNAME_VIEW
		WHERE PET_CODE = 'PET003';
        
        
        
INSERT INTO TBL_DAILY(DAILY_CODE, RELATION_CODE, DAILY_DATE)
VALUES(
( CONCAT('DAILY', NVL(MAX(TO_NUMBER(SUBSTR(DAILY_CODE, 6))), 0) + 1) )
, 
(SELECT RELATION_CODE
FROM TBL_RELATION
WHERE PET_CODE='PET003'
)
,
SYSDATE
);
        

 
