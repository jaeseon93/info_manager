
/* Drop Tables */

DROP TABLE ADDRESS CASCADE CONSTRAINTS;
DROP TABLE NOTE CASCADE CONSTRAINTS;
DROP TABLE PASSWORDS CASCADE CONSTRAINTS;
DROP TABLE RECEIPT CASCADE CONSTRAINTS;
DROP TABLE Member CASCADE CONSTRAINTS;




/* Create Tables */

-- 주소록
CREATE TABLE ADDRESS
(
	-- 일련번호
	ADDNO number NOT NULL,
	-- 회원번호
	MEMBERNO number NOT NULL,
	-- 이름
	ANAME varchar2(100) NOT NULL,
	-- 성별
	AGENDER varchar2(10),
	-- 생년월일
	ABIRTH date,
	-- 주소
	ADDRESS varchar2(210),
	-- 연락처
	APHONE varchar2(20),
	-- 이메일
	AEMAILE varchar2(50),
	-- 회사
	ACOMPANY varchar2(100),
	-- 직급
	GRADE varchar2(10),
	-- 날짜
	ADATE date,
	-- 메모
	AMEMO varchar2(3000),
	PRIMARY KEY (ADDNO)
);


-- 회원가입
CREATE TABLE Member
(
	-- 회원번호
	MEMBERNO number NOT NULL,
	-- 이메일
	EMAIL varchar2(50) NOT NULL,
	-- 비밀번호
	PASSWORD varchar2(64) NOT NULL,
	-- 비밀번호키
	SALT varchar2(16) NOT NULL,
	-- 핸드폰번호
	PHONE varchar2(20),
	-- 구글API
	GOOGLEAUTH varchar2(30),
	PRIMARY KEY (MEMBERNO)
);


-- 메모장
CREATE TABLE NOTE
(
	-- 일련번호
	MEMBERCODE number NOT NULL,
	-- 회원번호
	MEMBERNO number NOT NULL,
	-- 제목
	TITLE varchar2(100) NOT NULL,
	-- 날짜
	NDATE date,
	-- 내용
	NCONTENT varchar2(3000) NOT NULL,
	PRIMARY KEY (MEMBERCODE)
);


-- 패스워드
CREATE TABLE PASSWORDS
(
	-- 일련번호
	IDXNO number NOT NULL,
	-- 회원번호
	MEMBERNO number NOT NULL,
	-- URL
	URL varchar2(200) NOT NULL,
	-- 사이트명
	SITENAME varchar2(50) NOT NULL,
	-- 사이트아이디
	SITEID varchar2(80),
	-- 사이트비밀번호
	SITEPW varchar2(30),
	-- 날짜
	PDATE date,
	-- 메모
	NOTE varchar2(3000),
	PRIMARY KEY (IDXNO)
);


-- 영수증
CREATE TABLE RECEIPT
(
	-- 일련번호
	MEMBERCODE number NOT NULL,
	-- 회원번호
	MEMBERNO number NOT NULL,
	-- 제목
	TITLE varchar2(100) NOT NULL,
	-- 상호명
	PLACE varchar2(70) NOT NULL,
	-- 품명
	STUFF varchar2(100),
	-- 총 금액
	TOTAL varchar2(50) NOT NULL,
	-- 메모
	NOTE varchar2(3000),
	-- 파일
	FILE varchar2(1000) NOT NULL,
	-- 영수증날짜
	RCTDATE date,
	-- 등록날짜
	UPLOADDATE date,
	PRIMARY KEY (MEMBERCODE)
);



/* Create Foreign Keys */

ALTER TABLE ADDRESS
	ADD FOREIGN KEY (MEMBERNO)
	REFERENCES Member (MEMBERNO)
;


ALTER TABLE NOTE
	ADD FOREIGN KEY (MEMBERNO)
	REFERENCES Member (MEMBERNO)
;


ALTER TABLE PASSWORDS
	ADD FOREIGN KEY (MEMBERNO)
	REFERENCES Member (MEMBERNO)
;


ALTER TABLE RECEIPT
	ADD FOREIGN KEY (MEMBERNO)
	REFERENCES Member (MEMBERNO)
;



/* Comments */

COMMENT ON TABLE ADDRESS IS '주소록';
COMMENT ON COLUMN ADDRESS.ADDNO IS '일련번호';
COMMENT ON COLUMN ADDRESS.MEMBERNO IS '회원번호';
COMMENT ON COLUMN ADDRESS.ANAME IS '이름';
COMMENT ON COLUMN ADDRESS.AGENDER IS '성별';
COMMENT ON COLUMN ADDRESS.ABIRTH IS '생년월일';
COMMENT ON COLUMN ADDRESS.ADDRESS IS '주소';
COMMENT ON COLUMN ADDRESS.APHONE IS '연락처';
COMMENT ON COLUMN ADDRESS.AEMAILE IS '이메일';
COMMENT ON COLUMN ADDRESS.ACOMPANY IS '회사';
COMMENT ON COLUMN ADDRESS.GRADE IS '직급';
COMMENT ON COLUMN ADDRESS.ADATE IS '날짜';
COMMENT ON COLUMN ADDRESS.AMEMO IS '메모';
COMMENT ON TABLE Member IS '회원가입';
COMMENT ON COLUMN Member.MEMBERNO IS '회원번호';
COMMENT ON COLUMN Member.EMAIL IS '이메일';
COMMENT ON COLUMN Member.PASSWORD IS '비밀번호';
COMMENT ON COLUMN Member.SALT IS '비밀번호키';
COMMENT ON COLUMN Member.PHONE IS '핸드폰번호';
COMMENT ON COLUMN Member.GOOGLEAUTH IS '구글API';
COMMENT ON TABLE NOTE IS '메모장';
COMMENT ON COLUMN NOTE.MEMBERCODE IS '일련번호';
COMMENT ON COLUMN NOTE.MEMBERNO IS '회원번호';
COMMENT ON COLUMN NOTE.TITLE IS '제목';
COMMENT ON COLUMN NOTE.NDATE IS '날짜';
COMMENT ON COLUMN NOTE.NCONTENT IS '내용';
COMMENT ON TABLE PASSWORDS IS '패스워드';
COMMENT ON COLUMN PASSWORDS.IDXNO IS '일련번호';
COMMENT ON COLUMN PASSWORDS.MEMBERNO IS '회원번호';
COMMENT ON COLUMN PASSWORDS.URL IS 'URL';
COMMENT ON COLUMN PASSWORDS.SITENAME IS '사이트명';
COMMENT ON COLUMN PASSWORDS.SITEID IS '사이트아이디';
COMMENT ON COLUMN PASSWORDS.SITEPW IS '사이트비밀번호';
COMMENT ON COLUMN PASSWORDS.PDATE IS '날짜';
COMMENT ON COLUMN PASSWORDS.NOTE IS '메모';
COMMENT ON TABLE RECEIPT IS '영수증';
COMMENT ON COLUMN RECEIPT.MEMBERCODE IS '일련번호';
COMMENT ON COLUMN RECEIPT.MEMBERNO IS '회원번호';
COMMENT ON COLUMN RECEIPT.TITLE IS '제목';
COMMENT ON COLUMN RECEIPT.PLACE IS '상호명';
COMMENT ON COLUMN RECEIPT.STUFF IS '품명';
COMMENT ON COLUMN RECEIPT.TOTAL IS '총 금액';
COMMENT ON COLUMN RECEIPT.NOTE IS '메모';
COMMENT ON COLUMN RECEIPT.FILE IS '파일';
COMMENT ON COLUMN RECEIPT.RCTDATE IS '영수증날짜';
COMMENT ON COLUMN RECEIPT.UPLOADDATE IS '등록날짜';



