SELECT USER
FROM DUAL;
--==>> HTEST

/*
1. REPORTVIEW (신고내역 + 유형+신고자+처리상태)
2. REPORTVIEW_WCR (1 REPORTVIEW + 산책방댓글신고)
3. REPORTVIEW_BCR (1 REPORTVIEW + 게시글댓글신고)
4. REPORTVIEW_BR (1 REPORTVIEW + 게시글신고)
5. REPORTVIEW_WR (1 REPORTVIEW + 산책방신고)
6. REPORTVIEW_OR (1 REPORTVIEW + 오프라인신고)
*/


--○ 신고내역 (유형, 신고자, 처리상태 JOIN)
CREATE OR REPLACE VIEW REPORTVIEW
AS
SELECT L.REP_LOG_CODE
    , L.REP_TYPE_CODE
    , T.REP_TYPE_CONTENT
    , L.REP_LOG_WRITER
    , SI.SID_CODE
    , L.REP_LOG_DATE
    , L.REP_STATE_CODE
    , S.REP_STATE_CONTENT
    , L.REP_LOG_READ
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
ORDER BY L.REP_LOG_CODE;
--==>> View REPORTVIEW이(가) 생성되었습니다.




--○ REPORTVIEW 와 산책방댓글신고
CREATE OR REPLACE VIEW REPORTVIEW_WCR
AS
SELECT L.REP_LOG_CODE
    , L.REP_TYPE_CODE
    , T.REP_TYPE_CONTENT
    , L.REP_LOG_WRITER
    , SI.SID_CODE
    , L.REP_LOG_DATE
    , L.REP_STATE_CODE
    , S.REP_STATE_CONTENT
    , L.REP_LOG_READ
    , WCR.WALKCOMM_REP_CODE
    , WC.WALK_COMM_WRITER
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
LEFT OUTER JOIN TBL_WALKCOMM_REPORT WCR ON L.REP_LOG_CODE = WCR.REP_LOG_CODE
LEFT OUTER JOIN TBL_WALK_COMMENT WC ON WCR.WALK_COMM_CODE = WC.WALK_COMM_CODE
ORDER BY L.REP_LOG_CODE;

SELECT *
FROM REPORTVIEW_WCR;



--○ REPORTVIEW 와 게시글댓글신고
CREATE OR REPLACE VIEW REPORTVIEW_BCR
AS
SELECT L.REP_LOG_CODE
    , L.REP_TYPE_CODE
    , T.REP_TYPE_CONTENT
    , L.REP_LOG_WRITER
    , SI.SID_CODE
    , L.REP_LOG_DATE
    , L.REP_STATE_CODE
    , S.REP_STATE_CONTENT
    , L.REP_LOG_READ
    , BCR.BOARDCOMM_REP_CODE
    , BC.BOARD_COMM_WRITER
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
LEFT OUTER JOIN TBL_BOARDCOMM_REPORT BCR ON L.REP_LOG_CODE = BCR.REP_LOG_CODE
LEFT OUTER JOIN TBL_BOARD_COMMENT BC ON BCR.BOARD_COMM_CODE = BC.BOARD_COMM_CODE
ORDER BY L.REP_LOG_CODE;




--○ REPORTVIEW 와 게시글신고
CREATE OR REPLACE VIEW REPORTVIEW_BR
AS
SELECT L.REP_LOG_CODE
    , L.REP_TYPE_CODE
    , T.REP_TYPE_CONTENT
    , L.REP_LOG_WRITER
    , SI.SID_CODE
    , L.REP_LOG_DATE
    , L.REP_STATE_CODE
    , S.REP_STATE_CONTENT
    , L.REP_LOG_READ
    , BR.BOARD_REP_CODE
    , B.BOARD_WRITER
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
LEFT OUTER JOIN TBL_BOARD_REPORT BR ON L.REP_LOG_CODE = BR.REP_LOG_CODE
LEFT OUTER JOIN TBL_BOARD B ON BR.BOARD_CODE = B.BOARD_CODE
ORDER BY L.REP_LOG_CODE;



--○ REPORTVIEW 와 산책방신고
CREATE OR REPLACE VIEW REPORTVIEW_WR
AS
SELECT L.REP_LOG_CODE
    , L.REP_TYPE_CODE
    , T.REP_TYPE_CONTENT
    , L.REP_LOG_WRITER
    , SI.SID_CODE
    , L.REP_LOG_DATE
    , L.REP_STATE_CODE
    , S.REP_STATE_CONTENT
    , L.REP_LOG_READ
    , WR.WALKROOM_REP_CODE
    , W.WALKROOM_LEADER
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
LEFT OUTER JOIN TBL_WALKROOM_REPORT WR ON L.REP_LOG_CODE = WR.REP_LOG_CODE
LEFT OUTER JOIN TBL_WALKROOM W ON WR.WALKROOM_CODE = W.WALKROOM_CODE
ORDER BY L.REP_LOG_CODE;



--○ REPORTVIEW 와 오프라인 
CREATE OR REPLACE VIEW REPORTVIEW_OR
AS
SELECT L.REP_LOG_CODE
    , L.REP_TYPE_CODE
    , T.REP_TYPE_CONTENT
    , L.REP_LOG_WRITER
    , SI.SID_CODE
    , L.REP_LOG_DATE
    , L.REP_STATE_CODE
    , S.REP_STATE_CONTENT
    , L.REP_LOG_READ
    , OO.OFF_REP_CODE
    , OO.PARTICIPANTS_CODE
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
LEFT OUTER JOIN TBL_OFF_REPORT OO ON L.REP_LOG_CODE = OO.REP_LOG_CODE
ORDER BY L.REP_LOG_CODE;



------------------------------------> 
------------------------------------> REPORTVIEW 하나로 모든 애들을 묶은 뷰
CREATE OR REPLACE VIEW REPORTVIEW
AS
SELECT L.REP_LOG_CODE AS REP_LOG_CODE
    , L.REP_TYPE_CODE AS REP_TYPE_CODE 
    , T.REP_TYPE_CONTENT AS REP_TYPE_CONTENT
    , L.REP_LOG_WRITER AS REP_LOG_WRITER
    , SI.SID_CODE AS SID_CODE
    , TO_CHAR(L.REP_LOG_DATE, 'YYYY-MM-DD HH24:MI:SS') AS REP_LOG_DATE
    , L.REP_STATE_CODE AS REP_STATE_CODE
    , S.REP_STATE_CONTENT AS REP_STATE_CONTENT 
    , TO_CHAR(L.REP_LOG_READ, 'YYYY-MM-DD') AS REP_LOG_READ
    , WCR.WALKCOMM_REP_CODE AS WALKCOMM_REP_CODE
    , WC.WALK_COMM_WRITER AS WALK_COMM_WRITER
    , BCR.BOARDCOMM_REP_CODE AS BOARDCOMM_REP_CODE
    , BC.BOARD_COMM_WRITER AS BOARD_COMM_WRITER
    , BR.BOARD_REP_CODE AS BOARD_REP_CODE
    , BR.BOARD_CODE AS BOARD_CODE -- 아별 추가
    , B.BOARD_WRITER AS BOARD_WRITER
    , WR.WALKROOM_REP_CODE AS WALKROOM_REP_CODE
    , W.WALKROOM_LEADER AS WALKROOM_LEADER
    , OO.OFF_REP_CODE AS OFF_REP_CODE
    , OO.PARTICIPANTS_CODE AS PARTICIPANTS_CODE
FROM TBL_REPORT_LOG L
LEFT OUTER JOIN TBL_REPORT_TYPE T ON L.REP_TYPE_CODE = T.REP_TYPE_CODE
LEFT OUTER JOIN TBL_SID SI ON L.REP_LOG_WRITER = SI.SID_CODE
LEFT OUTER JOIN TBL_REPORT_STATE S ON L.REP_STATE_CODE = S.REP_STATE_CODE
LEFT OUTER JOIN TBL_WALKCOMM_REPORT WCR ON L.REP_LOG_CODE = WCR.REP_LOG_CODE
LEFT OUTER JOIN TBL_WALK_COMMENT WC ON WCR.WALK_COMM_CODE = WC.WALK_COMM_CODE
LEFT OUTER JOIN TBL_BOARDCOMM_REPORT BCR ON L.REP_LOG_CODE = BCR.REP_LOG_CODE
LEFT OUTER JOIN TBL_BOARD_COMMENT BC ON BCR.BOARD_COMM_CODE = BC.BOARD_COMM_CODE
LEFT OUTER JOIN TBL_BOARD_REPORT BR ON L.REP_LOG_CODE = BR.REP_LOG_CODE
LEFT OUTER JOIN TBL_BOARD B ON BR.BOARD_CODE = B.BOARD_CODE
LEFT OUTER JOIN TBL_WALKROOM_REPORT WR ON L.REP_LOG_CODE = WR.REP_LOG_CODE
LEFT OUTER JOIN TBL_WALKROOM W ON WR.WALKROOM_CODE = W.WALKROOM_CODE
LEFT OUTER JOIN TBL_OFF_REPORT OO ON L.REP_LOG_CODE = OO.REP_LOG_CODE
ORDER BY L.REP_LOG_CODE;

SELECT *
FROM REPORTVIEW;


-------------------------------------> 추가해 할 것 (신고 : 오프라인신고에서 데이터 꼬인 것 수정 및 추가)
SELECT *
FROM TBL_OFF_REPORT;

UPDATE TBL_OFF_REPORT
SET REP_LOG_CODE = 'REP010'
WHERE OFF_REP_CODE = 'OFFREP001';

INSERT INTO TBL_OFF_REPORT(OFF_REP_CODE, REP_LOG_CODE, MATCH_CODE, PARTICIPANTS_CODE)
VALUES('OFFREP002', 'REP011', 'MAT001' ,'PAR004');

------------------------------------->


