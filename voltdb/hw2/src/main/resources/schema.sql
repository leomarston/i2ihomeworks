-- DDL for mth3902 table
create table mth3902 (
id bigint not null,
start_date_epoch bigint,
create_user varchar(32),
constraint mth3902_pk primary key(id)
);

-- Partition table
partition table mth3902 on column id;

-- Sample data insertion
insert into mth3902 ( id, start_date_epoch, create_user ) values ( 1, 1698295044, 'MENNAN');
insert into mth3902 ( id, start_date_epoch, create_user ) values ( 2, 1698295088, 'ERKUT');
