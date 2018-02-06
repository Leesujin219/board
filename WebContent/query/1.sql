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

/*	������ ���� ����	*/
create sequence Boardser
start with 1
increment by 1
nomaxvalue;

/*
 * 		rownum. �����Ϳ� ���� ���������� ���ڸ� �Ű���
 * 		
 * 		select*from emp where rownum>3
 * 				>>�۵����� ����. rownum 1 �����. 3���� ũ�� �ʱ� ������ 
 * 				�����͸� ������ ���� ����. rownum�� ��� 1�� ����
 * 				(�� rownum���� �̸� database�� �����Ϳ� �Բ� ����Ǿ� �ִ� ���� �ƴ϶� ����� �� �ٴ� ��)
 * 		select*from emp where rownum<3
 * 				>>1,2 ����. rownum 1 ����� > ������ �����ϱ� ������ data�� ������. 
 * 						�����͸� ������ ���� rownum�� 2�� ����Ŵ. > data ������
 * 						rownum 3 ������̸� ������ �������� �ʱ� ������ �����͸� ���̻� �������� ����. 
 * 
 * */

select * from board;


/*��� �̻��ϰ� ����(rownum���� �ȸ���)*/
select rownum, a.* from board a
where boardid= 1 order by ref desc , re_step;


select rownum rum, b.* from (
select a.* from board a
where boardid= 1 order by ref desc , re_step) b;
/* from �޺κ� ��ȣ �ȿ� ���κ� �ڵ� ��. ref,re_step ���� 
 * ordered�� �����͸� ������� �����͸� �������鼭 rownum�� ���� */

select * from(
select rownum rum, b.* from (
select a.* from board a
where boardid= 1 order by ref desc , re_step) b)
where rum between 3 and 5;
/*
 * 	�̹������ rum�� ������ ������ ������ ���(rum����)
 * */










