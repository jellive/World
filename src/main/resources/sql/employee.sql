mvn install:install-file -Dfile=ojdbc6.jar -DartifactId=ojdbc6 -DgroupId=com.oracle -Dversion=11.2.0 -Dpackaging=jar
-- 메이븐에 오라클 깔긔...

select * from dept;
select * from emp;
select * from bonus;
select * from salgrade;


-- 이너 조인!
select dept.deptno, dept.dname, emp.ename, emp.hiredate
  from dept inner join emp
    on dept.deptno = emp.deptno
 order by dept.deptno asc;
 -- 요놈을 기준으로 정렬
    
-- 다른 방법으로 이너 조인!        
select d.deptno, d.dname, e.ename, e.hiredate
  from dept d, emp e
 where d.deptno = e.deptno
 order by d.deptno desc;
 
-- 아우터 조인! left는 왼쪽에 있는 테이블꺼는 다 나오게..
select d.deptno, d.dname, e.ename, e.hiredate
  from dept d left outer join emp e
    on d.deptno = e.deptno;

-- right는 반대로 오른쪽에 있는 건 다 나오게..
select d.deptno, d.dname, e.ename, e.hiredate
  from dept d right outer join emp e
    on d.deptno = e.deptno;
    
-- 1. emp에 직원을 추가하시오.
-- 직원 번호는 8000, 직원 이름은 홍길동, 
-- 직업은 developer. 부서번호는 80번. 부서 이름은 총무부. 
-- 부서 위치는 서울.

insert into dept (deptno,dname,loc)
values (80,'총무부','서울');
    
insert into EMP (empno,ename,job,empno) 
values (8000,'홍길동','developer',80);
    
select * from emp;

update emp 
   set deptno=80 
 where empno = 8000;

    
-- 2. 부서정보를 수정하시오.
-- 부서 번호가 20인 항목을 개발부로 수정하고, 위치는 부산으로.

update dept 
   set dname='개발부', loc='부산' 
 where deptno=20;

 
select * from dept;
    
-- 3. 직원을 퇴사 시키시오.
-- 대상은 직원 번호가 7300번 이상, 7600 이하인 사람.

delete from emp 
 where empno>7300 
   and empno<7600;

select * from emp;

    
-- 4. 부서별 직원정보를 출력하시오. (단, 모든 부서를 출력하시오.)

select * 
  from dept 
  left outer join emp 
    on dept.deptno = emp.deptno
 order by dept.deptno asc;


-- ex) 부서별 직원 급여 평균을 출력하라.
 
select d.dname, AVG(e.SAL), MAX(e.SAL), MIN(e.SAL)
  from emp e left outer join dept d
  on e.deptno = d.deptno
 group by e.deptno
 order by d.deptno asc;
 
 
-- 기초
 insert into emp
 (
 	empno,
 	ename,
 	job,
 	mgr,
 	hiredate,
 	sal,
 	deptno
 )
 values
 (
 	1000,
 	'홍길동2',
 	'asdf''xxx''', -- 만약 작은 따옴표를 쓰고 싶으면, ''를 쓴다.
 	7000,
 	'2015/09/10',
 	300.2,
 	10
 );
 
 select * from emp;
 commit
 rollback
 
 
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
 
 
-- MySQL에 있는 City를 오라클로 바꾸긔

 drop table City;
 
 CREATE TABLE CITY (
  	ID 			NUMERIC(11) NOT NULL,
  	NAME 		CHAR(35) 	DEFAULT '',
  	COUNTRYCODE CHAR(7) 	DEFAULT '', -- 3
  	DISTRICT 	CHAR(20) 	DEFAULT '',
  	POPULATION 	NUMERIC(11) DEFAULT 0,
  	CONSTRAINT 	PK_CITY PRIMARY KEY (ID),
  	CONSTRAINT	FK_COUNTRY FOREIGN KEY (COUNTRYCODE) references COUNTRY(CODE)
);


-- MySQL에 있는 Country를 오라클로 바꾸긔
DROP TABLE Country;

create table country (
	code 			char(3)  default '',
	name 			char(52)  		default '',
	continent 		char(20) 		default 'asia',
	region 			char(26) 		default '',
	surfacearea 	numeric(10,2) 	default '0.00',
	indepyear 		numeric(6) 		default null,
	population 		numeric(11)  	default 0,
	lifeexpectancy 	numeric(3,1) 	default null,
	gnp 			numeric(10,2) 	default null,
	gnpold 			numeric(10,2) 	default null,
	localname 		char(50) 		default '', -- 원래는 45.
	governmentform 	char(45)  		default '',
	headofstate 	char(60) 		default null,
	capital 		numeric(11) 	default null,
	code2 			char(2) 		default '',
	constraint ck_continent check (continent in ('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')) , 
	constraint pk_country primary key (code)
);

-- CountryCode

drop table countrylanguage;
create table countrylanguage (
  	countrycode 	char(3)			default '',
  	language 		char(30) 		default '',
  	isofficial 	char(1)			default 'f',
  	percentage 	numeric(4,1)	default '0.0',
  	constraint ck_isofficial check(isofficial in('t','f')),
  	constraint pk_countrylanguage primary key (countrycode,language)
);

select * from country;
select * from city;

create table filelist(
	fname varchar(50) primary key,
	flength numeric(10),
	flast_modified date,
	image blob
)

select * from filelist
select count(*) from filelist

delete from dept where deptno = 70;

update dept
   set dname = 'xxxx',
       loc = 'yyyy'
 where deptno = 80;
     
     
/*
 *     Member Table 생성
 * 		채본 테이블..?
 */
 
 drop table member;
 create table member(
 	id			int not null,
 	email		varchar(64) not null,
 	password 	varchar(64) not null,
 	name 		varchar(12) not null,
 	regdate		timestamp not null,
 	constraint member_pk primary key (id, email),
 	constraint member_id_uq unique (id),
 	constraint member_email_uq unique (email)
 );
 
 
 
 
 /*
  * sequence는 memberid등을 자동으로 만들어주는거임....
  * auto increment와 같은 것. 이를 채번, 발번이라 함.
  * 문제는, 에러가 나도 증가한다는 것.
  */
 create sequence member_id_seq;
 
 
 -- 1000번부터 시작해라!
 create sequence member_id_seq
 start with 1000;
 
 drop sequence member_id_seq;
 
 -- 부를 때마다 1씩 올라간 값을 반환함...
 select member_id_seq.nextval from dual;
 select member_id_seq.currval from dual;
 -- curr은 꼭 next를 한번 하고 불러야 함. 세션에서 들어가는 거기 때문에.
 
 -- 시퀀스 사용
insert into member
 (id,email,password,name)
 values
 (member_id_seq.nextval,'xxx','yyyy','zz''z');
 
insert into member
 (id,email,password,name,regdate)
 values
 (1004,'asdfa','asdfgad','zzz','2015/08/12'); 
 
 select * from member;
 
 update member set name = '홍순이' where id = 1001;
 
 
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
 
 update id_generator set nextval=10100 where name='memberId';
 --한개가 commit이 안되면, 다른 쪽이 lock이 걸려서 안된다...
 --하지만 이렇게 되면 둘 다 10100을 받게 된다.
 -- 이럴 때 쓰는게 for update..
 select * from id_generator where name='memberId' for update;
 
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
 * pagination
 */
 
select * from city; 

-- select할 때 rownum은 원래의 값(sort하기 전의 값)을 불러오는 역할이다. 괄호 안은 sort를 위한 임시 테이블. 여기서는 inner라는 이름으로 지정하고 불러온다.

select outer.id,
	   outer.email,
	   outer.password,
	   outer.name,
	   outer.regdate
  from (select rownum rn, inner.*
	      from (select m.* 
			      from member m
			  	 order by m.id asc
		   	   ) inner 
	   ) outer
where outer.rn >= 11
  and outer.rn <= 20
desc

where rownum >= 5
and rownum <= 10

select rownum, e.*
from emp e
order by e.ename