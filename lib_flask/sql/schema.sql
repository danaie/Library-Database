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
    ISBN VARCHAR(13) UNIQUE,
    title VARCHAR(100),
    page_number INT,
    summary VARCHAR(200),
    lang VARCHAR(15),
    image_path VARCHAR(50),
    key_words VARCHAR(100)
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT,
    publisher_name VARCHAR(20),
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
    category_name VARCHAR(15),
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
    author_first_name VARCHAR(20),
    author_last_name VARCHAR(20),
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
    name VARCHAR(20),
    city VARCHAR(20),
    address VARCHAR(20),
    phone_number VARCHAR(10),
    email VARCHAR(50),
    principal VARCHAR(20),
    lib_manager VARCHAR(20)
);

CREATE TABLE lib_user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(15) UNIQUE,
    password VARCHAR(20),
    school_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_date DATE,
    user_role VARCHAR(1),
    age INT,
    active BOOLEAN,
    pending BOOLEAN,
    FOREIGN KEY (school_id)
        REFERENCES school_unit (school_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE review (
    user_id INT,
    book_id INT,
    review_text VARCHAR(200),
    rating TINYINT,
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
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE service (
    user_id INT,
    book_id INT,
    service_type VARCHAR(1),
    service_date DATE,
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
    borrow_date DATE,
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
    SELECT 
        * from book b
        inner join availability a
        on a.book_id = b.book_id
        inner join school_unit sch
        on sch.school_id = a.school_id
        inner join lib_user u
        where u.school_id = sch.school_id
        GROUP BY u.user_id;


CREATE VIEW tot_loans AS
    SELECT
        sch.name AS 'School Name',
        count(*) AS 'Number of Loans', 
        MONTH(b.borrow_date) AS 'Month',
        YEAR(b.borrow_date) AS 'Year'
        FROM school_unit sch
        INNER JOIN lib_user u
        ON u.school_id = sch.school_id
        INNER JOIN borrow_log b
        WHERE b.user_id = u.user_id
        GROUP BY MONTH(b.borrow_date), sch.name;




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


-- ------
-- Events
-- ------

CREATE EVENT reserv_event
ON SCHEDULE EVERY 1 DAY
DO
FOR EACH ROW ON SERVICE
BEGIN
   IF (DATEDIFF(DAY, CURRENT_DATE, THIS.service_date) > 7) THEN
    DELETE ROW;
    END IF;
END;