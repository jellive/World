select count(*) from city;
select * from city;
select * from country;
select * from countrylanguage;

select city.name, country.indepyear, country.population from city inner join country on city.countrycode = country.code where city.countrycode = 'kor';


-- 텍스트를 처리하기 위한 자료형
-- char(10)            255max
-- varchar(10)         255max
-- longvarchar(1000)   oracle->long, mysql->text, mediuntext. 4기가까지 가능. 좀 더 긴 텍스트처리.
-- clob                oracle->clob, mysql->longtext. 더 큰 텍스트 처리. 하지만 속도면에서는 좀 떨어진다.
-- (Character Large OBject)

-- 수 처리
-- numeric(10,2) 2진수
-- decimal(10,2) 10진수

-- Timestamp (날짜, 시간) - oracle-> date, mysql -> datetime
-- Date (날짜)
-- Time (시간)

-- blob - oracle -> blob, mysql -> blob,mediumblob, longblob
-- (Binary Large OBject)


DROP TABLE DEPT;
CREATE TABLE DEPT (
    DEPTNO NUMERIC(2) NOT NULL,
	DNAME VARCHAR(14) ,
	LOC VARCHAR(13),
	CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
	-- PK_DEPT라는 이름으로, DEPTNO를 PRIMARY KEY로 만드는 규칙을 실행한다.
	-- CTRL+SHIFT+X는 대문자로, CTRL+SHIFT+Y는 소문자로 바꿔주는 핫키.
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

select * from emp;
drop table emp;
create table emp (
	empno numeric(4) not null,
	ename varchar(10),
	job varchar(9),
	mgr numeric(4),
	hiredate datetime,
	sal numeric(7,2),
	comm numeric(7,2),
	deptno numeric(2),
	constraint pk_emp primary key(empno),
	constraint fk_deptno foreign key (deptno) references dept(deptno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 




-- bonus
DROP TABLE BONUS;
CREATE TABLE BONUS (
	ENAME VARCHAR(10)	,
	JOB VARCHAR(9)  ,
	SAL NUMERIC,
	COMM NUMERIC
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- salgrade
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE (
	GRADE NUMERIC,
	LOSAL NUMERIC,
	HISAL NUMERIC
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- dummy
 insert into emp
 (
 	empno,
 	ename,
 	job
 )
 values
 (
 	1000,
 	'hong',
 	'test'
 );
 
 -- totalItem
 select count(*) from city;  
 
 -- limit start, count ==> start 0, count 10
 -- 1 page 1,2,3,...10
 -- 2 page 11,12,13,...20
 -- DB의 pagenation과 jsp의 pagenation은 다르다. jsp는 1부터, db는 0부터.
 select *
   from city Limit 0,10;
 
 -- ? start ==> firstItem - 1
 -- ? count ==> lastItem - firstItem + 1
   
-- 테이블을 만들 때, date는 datetime으로.
create table filelist(
	fname varchar(50) primary key,
	flength numeric(10),
	flast_modified datetime,
	image longblob
)    


/*
 *     Member Table 생성
 * 		채본 테이블..?
 * 		email xxx@xxx.com 점과 골뱅이가 하나 이상은 있어야 한다!
 * 		password 영문 and 숫자 and 6자리 이상이어야한다!
 * 					그리고 암호화(encryption)이 되어야함.
 * 					대표적으로 MD5, SHA256이 있따!
 * 
 */
 
drop table member;

/*
 * auto_increment는 numeric과 못씀. integer와 써야함.
 */
 create table member(
 	id			int not null auto_increment,
 	email		varchar(64) not null,
 	password 	varchar(64) not null,
 	name 		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member_pk primary key (id, email),
 	constraint member_id_uq unique (id),
 	constraint member_email_uq unique (email)
 );
 
 -- 1000번부터 시작하기.
 alter table member auto_increment=1000;
 
 insert into member
 (email,password,name)
 values
 ('xxx','yyyy','zzz', '2015/08/11');
 -- 시간을 안넣으면 현재 시간으로 그냥 들어감...오라클은 안주면 안들어감!
 
 -- 얘는 cmd안에서만 됨. 이클립스에서는 안됨.
 select last_insert_id();
 
 select * from member;
 
 /*
 * id generator
 */
 
 select * from ID_GENERATOR;
 drop table id_generator;
 create table id_generator(
 	name varchar(20) not null primary key,
 	nextval numeric(10) not null,
 	incval numeric(5) not null
 );
 
-- nextval은 시작값, incval은 증가값...
insert into id_generator
(name, nextval, incval)
values
('memberId', 10000, 100)

select * from member2;

drop table member2;
create table member2(
 	id			int not null,
 	email		varchar(64) not null,
 	password 	varchar(64) not null,
 	name 		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member2_pk primary key (id, email),
 	constraint member2_id_uq unique (id),
 	constraint member2_email_uq unique (email)
 );
 
 /*
  * Pagination
  */
select * 
from city 
where countrycode = "KOR"
order by name
limit 0,10

/*
 * District 분석
 */
select distinct district 
  from city
 where countrycode = 'KOR';
 
 select code,name
		from country

		select * from city where district='seoul'