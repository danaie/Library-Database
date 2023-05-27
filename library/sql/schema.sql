-- ---------------
-- Create database
------------------
create database library;
use library;

-- -------------
-- Create tables
-- --------------
CREATE TABLE book (
    book_id INT PRIMARY KEY auto_increment,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    page_number INT NOT NULL,
    summary VARCHAR(200) DEFAULT 'No summary available.',
    lang VARCHAR(15) NOT NULL,
    image_path VARCHAR(100) GENERATED ALWAYS AS (CONCAT('https://covers.openlibrary.org/b/isbn/', ISBN, '-L.jpg')),
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
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UNIQUE (publisher_id, book_id)
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
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UNIQUE (category_id, book_id)
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
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT UNIQUE (author_id, book_id)
);

CREATE TABLE school_unit (
    school_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) UNIQUE NOT NULL,
    city VARCHAR(20) NOT NULL,
    address VARCHAR(20) NOT NULL,
    phone_number VARCHAR(10) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    principal VARCHAR(20) NOT NULL,
    lib_manager VARCHAR(20) NOT NULL,
    CHECK (email LIKE '%_@_%._%')
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
    pending BOOLEAN NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES lib_user (user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UNIQUE (user_id, book_id)
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
    CONSTRAINT copies_gr_zero CHECK (copies >= 0),
    CONSTRAINT UNIQUE (school_id, book_id)
);

CREATE TABLE service (
    user_id INT,
    book_id INT,
    service_type VARCHAR(1) NOT NULL,
    waiting BOOLEAN DEFAULT FALSE,
    service_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id)
        REFERENCES lib_user (user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (book_id)
        REFERENCES book (book_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT UNIQUE (user_id, book_id)
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




-- -----
-- Views
-- ------

CREATE VIEW book_info AS
    (SELECT
		b.book_id, b.title, b.ISBN, book_auth.auth, book_cat.cat, book_pub.publisher_name,
        b.page_number, b.summary, b.lang, b.image_path, b.key_words
        FROM
		book b INNER JOIN 
        (SELECT ba.book_id, GROUP_CONCAT(a.author_first_name, ' ', a.author_last_name) AS auth
        FROM book_author ba
        INNER JOIN author a ON a.author_id = ba.author_id 
        GROUP BY ba.book_id) AS book_auth
        ON b.book_id = book_auth.book_id
        
        INNER JOIN 
        (SELECT bc.book_id, GROUP_CONCAT(c.category_name) AS cat
        FROM book_category bc INNER JOIN category c ON c.category_id = bc.category_id
        GROUP BY bc.book_id) AS book_cat
        ON b.book_id = book_cat.book_id
        
        INNER JOIN
        (SELECT bp.book_id, p.publisher_name
        FROM book_publisher bp INNER JOIN publisher p 
        ON p.publisher_id = bp.publisher_id) AS book_pub
        ON b.book_id = book_pub.book_id
    );
    
    
CREATE VIEW school_book_info AS
		SELECT a.school_id, bi.*, a.copies
        FROM book_info bi INNER JOIN availability a
        ON a.book_id = bi.book_id;


CREATE VIEW tot_loans (school_name, no_loans, b_month, b_year) AS
    SELECT 
        sch.name AS 'School Name',
        COUNT(b.user_id) AS 'Number of Loans',
        MONTH(b.borrow_date) AS 'Month',
        YEAR(b.borrow_date) AS 'Year'
    FROM
        school_unit sch
            INNER JOIN
        lib_user u ON u.school_id = sch.school_id
            INNER JOIN
        borrow_log b ON b.user_id = u.user_id
    GROUP BY MONTH(b.borrow_date), YEAR(b.borrow_date), sch.name;


CREATE VIEW loan_app AS
	SELECT u.school_id, u.user_id, u.username, u.first_name, u.last_name, u.user_role, b.title, a.copies, b.book_id
    FROM lib_user u 
    INNER JOIN service s
    ON s.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = s.book_id
    INNER JOIN availability a
    ON a.book_id  = b.book_id AND a.school_id = u.school_id
    WHERE s.service_type = 'r';


CREATE VIEW review_app AS
	SELECT u.school_id, u.user_id, u.username, u.user_role, b.title, r.rating, r.review_text, b.book_id
    FROM review r
    INNER JOIN lib_user u
    ON u.user_id = r.user_id
    INNER JOIN book b
    ON b.book_id = r.book_id
    WHERE r.pending = 1;

CREATE VIEW user_info AS
	SELECT u.user_id, u.username, u.first_name, u.last_name, u.user_role, sch.name, u.birth_date
    FROM lib_user u
    INNER JOIN school_unit sch
    ON sch.school_id = u.school_id
    ORDER BY u.user_id;
    
CREATE VIEW service_info AS
	SELECT u.school_id, u.user_id, b.book_id, b.ISBN, b.title, s.service_type, s.service_date
    FROM lib_user u 
    INNER JOIN service s
    ON s.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = s.book_id;


CREATE VIEW delay_info AS
	SELECT u.school_id, u.user_id, u.first_name, u.last_name, s.service_date, datediff(curdate(), service_date)-14 AS delay
    FROM lib_user u 
    INNER JOIN service s
    ON s.user_id = u.user_id
    WHERE service_type = 'b';

CREATE VIEW rating_info AS
	SELECT u.school_id, u.username, c.category_id, c.category_name, r.rating
    FROM lib_user u
    INNER JOIN review r
    ON r.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = r.book_id
    INNER JOIN book_category bc
    ON bc.book_id = b.book_id
    INNER JOIN category c
    ON c.category_id = bc.category_id;

CREATE VIEW log_info AS
	SELECT u.user_id, b.ISBN, b.title, bl.borrow_date
    FROM lib_user u 
    INNER JOIN borrow_log bl
    ON bl.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = bl.book_id;
    
CREATE VIEW review_info AS
	SELECT b.book_id, u.username, sch.name, r.rating, r.review_text
    FROM lib_user u
    INNER JOIN school_unit sch
    ON sch.school_id = u.school_id
    INNER JOIN review r
    ON r.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = r.book_id
    WHERE r.pending = 0;

CREATE VIEW lib_app AS
	SELECT sch.school_id, u.user_id, sch.name, u.username, u.first_name, u.last_name, u.birth_date, u.user_role
    FROM lib_user u
    INNER JOIN school_unit sch
    ON sch.school_id = u.school_id
    WHERE u.active = FALSE AND u.pending = TRUE AND u.user_role = 'l';
    
CREATE VIEW author_books AS
	SELECT author.author_id, CONCAT(author.author_first_name, ' ', author.author_last_name) AS author, 
        COUNT(book_author.book_id) AS total_books
    FROM author
    LEFT JOIN book_author ON author.author_id = book_author.author_id
    GROUP BY author.author_id, author.author_first_name, author.author_last_name;
        
        

-- -------
-- Indexes
----------
CREATE INDEX title_idx ON book (title);

CREATE UNIQUE INDEX author_idx ON author (author_last_name, author_first_name);

CREATE INDEX borrow_log_idx ON borrow_log (user_id);

-- --------
-- Triggers
-- --------

delimiter $$
CREATE TRIGGER trans_to_log BEFORE DELETE ON service
FOR EACH ROW
BEGIN
IF (OLD.service_type = 'b') THEN
	INSERT INTO borrow_log
	VALUES (OLD.user_id, OLD.book_id, OLD.service_date);
END IF;
END; $$
delimiter ;

delimiter $$
CREATE PROCEDURE no_more_wait(IN sch_id INT)
BEGIN
IF (NEW.copies = OLD.copies+1) THEN
	UPDATE service SET wait=FALSE WHERE school_id=sch_id AND 
END IF;
END; $$
delimiter ;

-- ------
-- Events
-- ------
CREATE EVENT reserv_event
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM service WHERE DATEDIFF(CURRENT_DATE, service_date) > 7 AND service_type='r';
