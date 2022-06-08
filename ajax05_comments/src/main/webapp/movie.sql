-- movie.sql
drop table comments;
drop table movie;
create table movie
(
	mnum number(5) primary key,
	title varchar2(50),
	content varchar2(100),
	director varchar2(20)
);
create table comments
(
	num number(5) primary key, --댓글번호
	mnum number(5) references movie(mnum), -- 영화번호
	id varchar2(10), --작성자
	comments varchar2(100) --내용
);
drop sequence movie_seq;
drop sequence comments_seq;
create sequence movie_seq;
create sequence comments_seq;

insert into movie values (MOVIE_SEQ.nextval, '닥터스트레인지', '마블영화', '스감독');
insert into movie values (MOVIE_SEQ.nextval, '범죄도시2', '무서운영화', '마동석감동');
insert into movie values (MOVIE_SEQ.nextval, '토르', '천둥영화', '박감독');
insert into comments values (COMMENTS_SEQ.nextval, 1, '길동이', '재미나요!');
insert into comments values (COMMENTS_SEQ.nextval, 1, '말랑이', '좀비영화?');
insert into comments values (COMMENTS_SEQ.nextval, 2, '삼동이', '무서워요..');
insert into comments values (COMMENTS_SEQ.nextval, 3, '차차', '신나요~');
commit;