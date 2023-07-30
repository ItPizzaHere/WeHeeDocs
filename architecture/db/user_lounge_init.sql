create database itpizza;
use itpizza;

create table MBTI(
	mbti_id int primary key,
    name varchar(4) not null
);

create table `user`(
	user_id int unsigned primary key auto_increment,
    nickname varchar(10) not null,
    user_mbti_id int not null,
    profile_url varchar(255) default null,
    birth int unsigned not null,
    gender varchar(1) not null,
    last_mbti_modified date default null,
    birth_changed bool not null default false,
    gender_changed bool not null default false,
    provider varchar(10) not null,
    provider_id varchar(255) not null,
    withdrawl bool not null default false,
    foreign key(user_mbti_id) references MBTI(mbti_id)
);

create table post(
	post_id int unsigned primary key auto_increment,
    post_mbti_id int not null,
    title varchar(30) not null,
    content text not null,
    post_user_id int unsigned not null,
    like_count mediumint not null default 0,
    hit int unsigned not null default 0,
    comment_count int unsigned not null default 0,
    upload_time timestamp not null default current_timestamp,
    state int default 0,
    foreign key(post_mbti_id) references MBTI(mbti_id),
    foreign key(post_user_id) references `user`(user_id) on delete cascade
);

create table `like`(
	like_id int unsigned primary key auto_increment,
	like_post_id int unsigned not null,
    like_user_id int unsigned,
    foreign key(like_post_id) references post(post_id) on delete cascade,
    foreign key(like_user_id) references `user`(user_id) on delete set null
);

create table `comment`(
	comment_id int unsigned primary key auto_increment,
    comment_post_id int unsigned not null,
    comment_user_id int unsigned,
    content text not null,
    upload_time timestamp not null default current_timestamp,
    state int not null default 0,
    foreign key(comment_post_id) references post(post_id) on delete cascade,
    foreign key(comment_user_id) references `user`(user_id) on delete set null
);

create table reply(
	reply_id int unsigned primary key auto_increment,
    reply_comment_id int unsigned not null,
    reply_post_id int unsigned not null,
    reply_user_id int unsigned,
    content text not null,
    upload_time timestamp not null default current_timestamp,
    state int not null default 0,
    foreign key(reply_comment_id) references `comment`(comment_id) on delete cascade,
    foreign key(reply_post_id) references post(post_id) on delete cascade,
    foreign key(reply_user_id) references `user`(user_id) on delete set null
);

create table vote(
	vote_id int unsigned primary key auto_increment,
	title varchar(255) not null,
	vote_user_id int unsigned,
    upload_time timestamp not null default current_timestamp,
    select1 varchar(255) not null,
    select2 varchar(255) not null,
    foreign key(vote_user_id) references `user`(user_id) on delete set null
);

create table voter(
	voter_id int unsigned primary key auto_increment,
	voter_vote_id int unsigned not null,
    voter_select_id int unsigned not null,
    voter_user_id int unsigned,
    foreign key(voter_vote_id) references vote(vote_id) on delete cascade,
    foreign key(voter_user_id) references user(user_id) on delete set null
);

create table hot_post(
	hot_post_id int unsigned primary key,
    `rank` int unique,
    foreign key(hot_post_id) references post(post_id) on delete cascade
);

create table notification(
	notification_id int unsigned primary key auto_increment,
    notification_receiver_user_id int unsigned not null,
    notification_sender_user_id int unsigned,
    `comment` text not null,
    upload_time timestamp not null,
    is_post bool not null,
    origin_post_id int unsigned not null,
    browsed bool not null default false,
    foreign key(notification_receiver_user_id) references `user`(user_id) on delete cascade,
    foreign key(notification_sender_user_id) references `user`(user_id) on delete set null
);

create table `declare`(
	declare_id int unsigned primary key auto_increment,
	declare_type int not null,
	declare_post_id int unsigned,
    declare_user_id int unsigned,
    foreign key(declare_user_id) references `user`(user_id) on delete set null
);

create table deleted_post(
	deleted_post_id int unsigned primary key auto_increment,
    post_id int unsigned,
    post_mbti_id int,
    title varchar(30),
    content text,
    post_user_id int unsigned,
    like_count mediumint,
    hit int unsigned,
    comment_count int unsigned,
    upload_time timestamp,
    state int
);

create table deleted_comment(
	deleted_comment_id int unsigned primary key auto_increment,
    comment_id int unsigned,
    comment_post_id int unsigned,
    comment_user_id int unsigned,
    content text,
    upload_time timestamp,
    state int
);

create table deleted_reply(
	deleted_reply_id int unsigned primary key auto_increment,
    reply_id int unsigned,
    reply_comment_id int unsigned,
    reply_post_id int unsigned,
    reply_user_id int unsigned,
    content text,
    upload_time timestamp,
    state int
);

insert into MBTI values (0,'CUTE'), (1,'ENFJ'), (2,'ENFP'), (3,'ENFJ'), (4,'ENFP'),
(5,'ESFJ'), (6,'ESFP'), (7,'ESTJ'), (8,'ESTP'), (9,'INFJ'), (10,'INFP'), (11,'INTJ'),
 (12,'INTP'), (13,'ISFJ'), (14,'ISFP'), (15,'ISTJ'), (16,'ISTP');

insert into `user` (user_id,nickname,user_mbti_id,birth,gender,provider,provider_id)
values(0,'탈퇴한 사용자',0,2023,'X','X','X');
update user set user_id=0 where user_mbti_id=0;

# MBTI 0번은 CUTE
# user 0번은 탈퇴한 사용자
