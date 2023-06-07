/**
  데이터 베이스 생성 스크립트 입력
 */
create table sample
(
    id        Long identity,
    USER_NAME varchar(20),
    RMK       varchar(100),
    INST_DATE datetime
);

create table user
(
    id       varchar(20) primary key,
    PASSWORD varchar(200) not null,
    NAME     varchar(5)   not null,
    BIRTH    date,
    GENDER   varchar(1),
    EMAIL    varchar(20),
    PHONE    varchar(20)  not null,
    DELETED  boolean,
);

create table article
(
    id         Long primary key identity,
    WRITER     varchar(20) not null,
    TITLE      varchar(20) not null,
    CONTENT    text        not null,
    VIEW_CNT   Long,
    DELETED    boolean,
    CREATED_AT timestamp default current_timestamp,
    UPDATED_AT timestamp default current_timestamp on update current_timestamp,
    foreign key (WRITER) references user (id)
);

create table comment
(
    id         int primary key identity,
    WRITER     varchar(20) not null,
    ARTICLE_ID Long        not null,
    CONTENT    text        not null,
    CREATED_AT timestamp default current_timestamp,
    DELETED    boolean,
    PARENT_ID  Long,
    LEVEL      int,
    foreign key (WRITER) references user (id),
    foreign key (ARTICLE_ID) references article (id),
    foreign key (PARENT_ID) references comment (id)
);