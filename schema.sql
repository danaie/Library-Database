-- Antonis

create table book (
	primary key ISBN varchar(13),
    title varchar(40),
    page_number int,
    summary varchar(200),
    lang varchar(15),
    image_path varchar(50),
    key_words varchar(40)
);

create table publisher (
	publisher_id int auto_increment,
    publisher_name varchar(20),
    primary key(publisher_id)
);

create table book_publisher (
	publisher_id int,
    book_id int,
    foreign key (publisher_id) references publisher(publisher_id) on delete cascade on update cascade,
    foreign key (book_id) references book(book_id) on delete cascade on update cascade
);

create table category (
	category_id int not null auto_increment,
    category_name varchar(15),
    primary key(category_id)
);

create table book_category (
	category_id int,
    book_id int,
    foreign key (category_id) references category(category_id) on delete cascade on update cascade,
    foreign key (book_id) references book(book_id) on delete cascade on update cascade
);

create table author (
	author_id int not null auto_increment,
    author_first_name varchar(20),
	author_last_name varchar(20),
    primary key(author_id)
);

create table book_author (
	author_id int,
    book_id int,
    foreign key (author_id) references author(author_id) on delete cascade on update cascade,
    foreign key (book_id) references book(book_id) on delete cascade on update cascade
);

create table review (
	username varchar(15),
    ISBN varchar(13),
    review_text varchar(50),
    rating smallint,
    foreign key (username) references lib_user(username) on delete cascade on update cascade,
    foreign key (ISBN) references book(ISBN) on delete cascade on update cascade
);
