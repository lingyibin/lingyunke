drop table if exists lyk_article;

drop table if exists lyk_bug;

drop table if exists lyk_category;

drop table if exists lyk_collect;

drop table if exists lyk_greeting;

drop table if exists lyk_index_menu;

drop table if exists lyk_manager;

drop table if exists lyk_review;

drop table if exists lyk_tag;

drop table if exists lyk_tag_record;

drop table if exists lyk_visit;

/*==============================================================*/
/* Table: lyk_article                                           */
/*==============================================================*/
create table lyk_article
(
   a_id                 int not null auto_increment,
   c_id                 int,
   tr_id                int,
   a_title              varchar(100) not null,
   a_content            text not null,
   a_post_time          datetime not null,
   a_last_modify_time   datetime not null,
   a_category_id2       int comment '外链到lyk_category表',
   a_view_count         int not null,
   a_category_id3       int,
   primary key (a_id)
);

/*==============================================================*/
/* Table: lyk_bug                                               */
/*==============================================================*/
create table lyk_bug
(
   b_id                 int not null auto_increment,
   b_title              varchar(100) not null,
   b_content            text not null,
   b_post_time          datetime not null,
   b_state              tinyint not null comment '0新，1接受处理，2解决，3拒绝，4挂起',
   b_result             text,
   b_ip                 varchar(20),
   b_avatar_url         varchar(100) not null,
   b_from               varchar(20),
   b_user_name          varchar(20) not null,
   b_media_user_id      varchar(20) comment '如qq',
   primary key (b_id)
);

/*==============================================================*/
/* Table: lyk_category                                          */
/*==============================================================*/
create table lyk_category
(
   c_id                 int not null auto_increment,
   c_name               varchar(20) not null,
   primary key (c_id)
);

/*==============================================================*/
/* Table: lyk_collect                                           */
/*==============================================================*/
create table lyk_collect
(
   co_id                int not null auto_increment,
   c_id                 int,
   co_src_url           varchar(200) not null,
   co_title             varchar(100) not null,
   co_content           text not null,
   co_post_time         datetime not null,
   co_view_count        int not null,
   co_category2_id      int,
   co_category3_id      int,
   primary key (co_id)
);

/*==============================================================*/
/* Table: lyk_greeting                                          */
/*==============================================================*/
create table lyk_greeting
(
   g_id                 int not null auto_increment,
   g_content            varchar(1024) not null comment '限制在140字',
   g_ip                 varchar(20),
   g_avatar_url         varchar(100) not null,
   g_post_time          datetime not null,
   g_from               varchar(20),
   g_user_name          varchar(20) not null,
   g_media_user_id      varchar(20),
   g_denglu_id          int,
   g_state              tinyint not null,
   primary key (g_id)
);

/*==============================================================*/
/* Table: lyk_index_menu                                        */
/*==============================================================*/
create table lyk_index_menu
(
   m_id                 int not null auto_increment,
   m_index              tinyint not null,
   m_name               varchar(20) not null,
   m_url                varchar(100) not null,
   m_parent_id          int not null,
   primary key (m_id)
);

alter table lyk_index_menu comment '菜单表';

/*==============================================================*/
/* Table: lyk_manager                                           */
/*==============================================================*/
create table lyk_manager
(
   ma_id                int not null auto_increment,
   ma_name              varchar(20) not null,
   ma_login_name        varchar(20) not null,
   ma_password          varchar(32) not null,
   ma_avatar_url        varchar(100) not null,
   ma_ip                varchar(50),
   ma_media_user_id     varchar(20) comment '如qq',
   primary key (ma_id)
);

/*==============================================================*/
/* Table: lyk_review                                            */
/*==============================================================*/
create table lyk_review
(
   r_id                 int not null auto_increment,
   a_id                 int,
   r_ip                 varchar(20),
   r_content            varchar(1024) not null comment '少于140字',
   r_from               varchar(20),
   r_avatar_url         varchar(100) not null,
   r_user_name          varchar(20) not null,
   r_post_time          datetime not null,
   r_media_user_id      varchar(20) comment '如qq',
   r_denglu_id          int,
   r_state              tinyint not null comment '0正常评论，1待审，2垃圾评论，3删除',
   primary key (r_id)
);

/*==============================================================*/
/* Table: lyk_tag                                               */
/*==============================================================*/
create table lyk_tag
(
   t_id                 int not null auto_increment,
   t_name               varchar(20) not null,
   primary key (t_id)
);

/*==============================================================*/
/* Table: lyk_tag_record                                        */
/*==============================================================*/
create table lyk_tag_record
(
   tr_id                int not null auto_increment,
   tr_tag1_id           int not null comment '指向lyk_tag',
   tr_tag2_id           int comment '指向lyk_tag',
   tr_tag3_id           int comment '指向lyk_tag',
   tr_tag4_id           int comment '指向lyk_tag',
   tr_tag5_id           int comment '指向lyk_tag',
   tr_pre_tag_id        int not null comment '指向本表',
   primary key (tr_id)
);

alter table lyk_tag_record comment '至少有一个tag才能成为一条记录';

/*==============================================================*/
/* Table: lyk_visit                                             */
/*==============================================================*/
create table lyk_visit
(
   v_id                 int not null auto_increment,
   v_login_time         datetime not null,
   v_ip                 varchar(20),
   v_avatar_url         varchar(100) not null,
   v_from               varchar(20),
   v_user_name          varchar(20) not null,
   v_media_user_id      varchar(20) comment '如qq',
   primary key (v_id)
);

alter table lyk_article add constraint FK_artical_category foreign key (c_id)
      references lyk_category (c_id) on delete restrict on update restrict;

alter table lyk_article add constraint FK_article_tag foreign key (tr_id)
      references lyk_tag_record (tr_id) on delete restrict on update restrict;

alter table lyk_collect add constraint FK_collect_artical_category foreign key (c_id)
      references lyk_category (c_id) on delete restrict on update restrict;

alter table lyk_review add constraint FK_review_article foreign key (a_id)
      references lyk_article (a_id) on delete restrict on update restrict;
