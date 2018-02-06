create table board(
    num int not null primary key,
    boardid varchar(1) default '1',
    writer varchar(10) not null,
    email varchar(30),
    subject varchar(50) not null,
    passwd varchar(12) not null,
    reg_date date not null,
    readcount int default 0,
    ref int not null,
    re_step int not null,
    re_level int not null,
    content varchar(3000) not null,
    ip varchar(20) not null,
    filename varchar(30),
    filesize int
);

/*	시퀀스 생성 쿼리	*/
create sequence Boardser
start with 1
increment by 1
nomaxvalue;

/*
 * 		rownum. 데이터에 대해 순차적으로 숫자를 매겨줌
 * 		
 * 		select*from emp where rownum>3
 * 				>>작동되지 않음. rownum 1 대기중. 3보다 크지 않기 때문에 
 * 				데이터를 가지고 오지 않음. rownum은 계속 1인 상태
 * 				(즉 rownum값은 미리 database에 데이터와 함께 저장되어 있는 것이 아니라 출력할 때 붙는 값)
 * 		select*from emp where rownum<3
 * 				>>1,2 찍힘. rownum 1 대기중 > 조건을 만족하기 때문에 data를 가져옴. 
 * 						데이터를 가지고 오면 rownum은 2를 대기시킴. > data 가져옴
 * 						rownum 3 대기중이면 조건을 만족하지 않기 때문에 데이터를 더이상 가져오지 않음. 
 * 
 * */

select * from board;


/*결과 이상하게 나옴(rownum순서 안맞음)*/
select rownum, a.* from board a
where boardid= 1 order by ref desc , re_step;


select rownum rum, b.* from (
select a.* from board a
where boardid= 1 order by ref desc , re_step) b;
/* from 뒷부분 괄호 안에 윗부분 코드 들어감. ref,re_step 으로 
 * ordered된 데이터를 대상으로 데이터를 가져오면서 rownum을 붙임 */

select * from(
select rownum rum, b.* from (
select a.* from board a
where boardid= 1 order by ref desc , re_step) b)
where rum between 3 and 5;
/*
 * 	이미출력한 rum의 범위를 지정해 데이터 출력(rum포함)
 * */










