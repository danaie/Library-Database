-- ---------------
-- Create database
------------------
create database library;
use library;


-- -------------
-- Create tables
----------------
CREATE TABLE book (
    book_id INT PRIMARY KEY auto_increment,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    page_number INT NOT NULL,
    summary VARCHAR(200) DEFAULT 'No summary available.',
    lang VARCHAR(15) NOT NULL,
    image_path VARCHAR(50) DEFAULT 'https://bit.ly/3HFDatg',
    key_words VARCHAR(100)
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT,
    publisher_name VARCHAR(20) UNIQUE NOT NULL,
    PRIMARY KEY (publisher_id)
);

CREATE TABLE book_publisher (
    publisher_id INT,
    book_id INT,
    FOREIGN KEY (publisher_id)
        REFERENCES publisher (publisher_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE category (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(15) UNIQUE NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE book_category (
    category_id INT,
    book_id INT,
    FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE author (
    author_id INT NOT NULL AUTO_INCREMENT,
    author_first_name VARCHAR(20) NOT NULL,
    author_last_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (author_id)
);

CREATE TABLE book_author (
    author_id INT,
    book_id INT,
    FOREIGN KEY (author_id)
        REFERENCES author (author_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE school_unit (
    school_id INT PRIMARY KEY,
    name VARCHAR(20) UNIQUE NOT NULL,
    city VARCHAR(20) NOT NULL,
    address VARCHAR(20) NOT NULL,
    phone_number VARCHAR(10) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    principal VARCHAR(20) NOT NULL,
    lib_manager VARCHAR(20) NOT NULL
);

CREATE TABLE lib_user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(20) NOT NULL,
    school_id INT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    user_role VARCHAR(1) NOT NULL,
    active BOOLEAN DEFAULT 0,
    pending BOOLEAN DEFAULT 1,
    FOREIGN KEY (school_id)
        REFERENCES school_unit (school_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE review (
    user_id INT,
    book_id INT,
    review_text VARCHAR(200),
    rating TINYINT NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES lib_user (user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE availability (
    school_id INT,
    book_id INT,
    copies INT,
    FOREIGN KEY (school_id)
        REFERENCES school_unit (school_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT copies_gr_zero CHECK (copies > 0)
);

CREATE TABLE service (
    user_id INT,
    book_id INT,
    service_type VARCHAR(1) NOT NULL,
    service_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id)
        REFERENCES lib_user (user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE borrow_log (
    user_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES lib_user (user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- -------
-- Indexes
----------
CREATE UNIQUE INDEX title_idx ON book (title);

CREATE UNIQUE INDEX publisher_idx ON publisher (publisher_name);

CREATE UNIQUE INDEX author_idx ON author (author_last_name);

CREATE UNIQUE INDEX borrow_log_idx ON borrow_log (user_id);

CREATE UNIQUE INDEX category_idx ON category (category_name);


-- -----
-- Views
-- ------

CREATE VIEW school_books AS
    (SELECT 
        b.title, CONCAT(auth.author_first_name, ' ', auth.author_last_name), pub.publisher_name, sch.name, a.copies 
		from book b
        inner join availability a
        on b.book_id = a.book_id
        inner join school_unit sch
        on sch.school_id = a.school_id
        inner join book_publisher bp
        on b.book_id = bp.book_id
        inner join publisher pub
        on pub.publisher_id = bp.publisher_id
        inner join book_author ba
        on ba.book_id = b.book_id
        inner join author auth
        on auth.author_id = ba.author_id
	);

-- --------
-- Triggers
-- --------

delimiter $$
CREATE TRIGGER trans_to_log BEFORE DELETE ON service
FOR EACH ROW
BEGIN
INSERT INTO borrow_log
VALUES (OLD.user_id, OLD.book_id, OLD.service_date);
END; $$
delimiter ;
