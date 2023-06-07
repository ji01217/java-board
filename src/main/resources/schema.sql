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
    password varchar(200) not null,
    name     varchar(5)   not null,
    birth    date,
    gender   varchar(1),
    email    varchar(20),
    phone    varchar(20)  not null,
    deleted  boolean,
);

create table article
(
    id        Long primary key identity,
    writer    varchar(20) not null,
    title     varchar(20) not null,
    content   text        not null,
    viewCnt   Long,
    deleted   boolean,
    createdAt timestamp default current_timestamp,
    updatedAt timestamp default current_timestamp on update current_timestamp,
    foreign key (writer) references user (id)
);

create table comment
(
    id        Long primary key identity,
    writer    varchar(20) not null,
    articleId Long        not null,
    content   text        not null,
    createdAt timestamp default current_timestamp,
    deleted   boolean,
    parentId  Long,
    level     int,
    foreign key (writer) references user (id),
    foreign key (articleId) references article (id),
    foreign key (parentId) references comment (id)
);

create table file
(
    id               Long primary key identity,
    articleId        Long         not null,
    originalFileName varchar(200) not null,
    storedFileName   varchar(200) not null,
    contentType      varchar(200) not null,
    fileSize         Long,
    deleted          boolean,
    createdAt        timestamp default current_timestamp,
    foreign key (articleId) references article (id)
)