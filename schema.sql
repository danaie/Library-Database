create table book (
	ISBN varchar(13) primary key,
	title varchar(40) not null,
	page_number int not null,
	summary varchar(200) not null,
	lang varchar(15) not null,
	image_path varchar(50),
	key_words varchar(40)
);

create table publisher (
	publisher_id int auto_increment,
	publisher_name varchar(20) not null,
	primary key(publisher_id)
);

create table book_publisher (
	publisher_id int,
	ISBN int,
	foreign key (publisher_id) references publisher(publisher_id) on delete cascade on update cascade,
	foreign key (ISBN) references book(ISBN) on delete cascade on update cascade
);

create table category (
	category_id int not null auto_increment,
	category_name varchar(15),
	primary key(category_id)
);

create table book_category (
	category_id int,
	ISBN int,
	foreign key (category_id) references category(category_id) on delete cascade on update cascade,
	foreign key (ISBN) references book(ISBN) on delete cascade on update cascade
);

create table author (
	author_id int not null auto_increment,
 	author_first_name varchar(20),
	author_last_name varchar(20),
 	primary key(author_id)
);

create table book_author (
	author_id int,
	ISBN int,
	foreign key (author_id) references author(author_id) on delete cascade on update cascade,
	foreign key (ISBN) references book(ISBN) on delete cascade on update cascade
);

create table review (
	username varchar(15),
	ISBN varchar(13),
	review_text varchar(50),
	rating tinyint,
	foreign key (username) references lib_user(username) on delete cascade on update cascade,
	foreign key (ISBN) references book(ISBN) on delete cascade on update cascade
);

create table school_unit (
	school_id int primary key,
	name varchar(20),
	city varchar(20),
	address varchar(20),
	phone_number varchar(10),
	email varchar(20),
	principle varchar(20),
	handler varchar(20)
);

create table lib_user (
	username varchar(15) primary key,
	password varchar(20),
	school_id int,
	first_name varchar(20),
	last_name varchar(20),
	birth_date date,
	user_role varchar(1),
	age int,
	pending boolean,
	active boolean,
	foreign key(school_id) references school_unit(school_id) on delete cascade on update cascade
);

select datediff(yy,birth_date,getdate())-
	case
		when dateadd(yy,datediff(yy,birth_date,getdate()),birth_date) > getdate() then 1
        else 0
	end
from lib_user;

create table availability (
	school_id int,
	ISBN varchar(13),
	copies int check(copies>=0),
	foreign key(school_id) references school_unit(school_id) on delete cascade on update cascade,
	foreign key(ISBN) references book(ISBN) on delete cascade on update cascade
);

create table service (
	username varchar(15),
 	ISBN varchar(13),
	service_type boolean, -- 0 <-> reserved, 1 <-> borrowed
	service_date date,
	foreign key(username) references lib_user(username) on delete cascade on update cascade,
	foreign key(ISBN) references book(ISBN) on delete cascade on update cascade
);

create table borrow_log (
	username varchar(15),
 	ISBN varchar(13),
	borrow_date date,
	foreign key(username) references lib_user(username) on delete cascade on update cascade,
	foreign key(ISBN) references book(ISBN) on delete cascade on update cascade
);
