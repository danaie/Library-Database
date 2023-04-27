create database library;
use library;

CREATE TABLE book (
    ISBN VARCHAR(13) PRIMARY KEY,
    title VARCHAR(40),
    page_number INT,
    summary VARCHAR(200),
    lang VARCHAR(15),
    image_path VARCHAR(50),
    key_words VARCHAR(40),
    INDEX title_idx (title)
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT,
    publisher_name VARCHAR(20),
    PRIMARY KEY (publisher_id),
    INDEX publisher_idx (publisher_name)
);

CREATE TABLE book_publisher (
    publisher_id INT,
    ISBN VARCHAR(13),
    FOREIGN KEY (publisher_id)
        REFERENCES publisher (publisher_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE category (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(15),
    PRIMARY KEY (category_id),
    INDEX category_idx (category_name)
);

CREATE TABLE book_category (
    category_id INT,
    ISBN INT,
    FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE author (
    author_id INT NOT NULL AUTO_INCREMENT,
    author_first_name VARCHAR(20),
    author_last_name VARCHAR(20),
    PRIMARY KEY (author_id),
    INDEX author_idx (author_last_name)
);

CREATE TABLE book_author (
    author_id INT,
    ISBN VARCHAR(13),
    FOREIGN KEY (author_id)
        REFERENCES author (author_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE review (
    username VARCHAR(15),
    ISBN VARCHAR(13),
    review_text VARCHAR(50),
    rating TINYINT,
    FOREIGN KEY (username)
        REFERENCES lib_user (username)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE school_unit (
    school_id INT PRIMARY KEY,
    name VARCHAR(20),
    city VARCHAR(20),
    address VARCHAR(20),
    phone_number VARCHAR(10),
    email VARCHAR(20),
    principal VARCHAR(20),
    handler VARCHAR(20)
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

SELECT 
    DATEDIFF(yy, birth_date, GETDATE()) - CASE
        WHEN
            DATEADD(yy,
                    DATEDIFF(yy, birth_date, GETDATE()),
                    birth_date) > GETDATE()
        THEN
            1
        ELSE 0
    END
FROM
    lib_user;

CREATE TABLE availability (
    school_id INT,
    ISBN VARCHAR(13),
    copies INT,
    FOREIGN KEY (school_id)
        REFERENCES school_unit (school_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE service (
    username VARCHAR(15),
    ISBN VARCHAR(13),
    service_type VARCHAR(1),
    service_date DATE,
    FOREIGN KEY (username)
        REFERENCES lib_user (username)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE borrow_log (
    username VARCHAR(15),
    ISBN VARCHAR(13),
    borrow_date DATE,
    FOREIGN KEY (username)
        REFERENCES lib_user (username)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ISBN)
        REFERENCES book (ISBN)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
