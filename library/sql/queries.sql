-- 3.1.1
SELECT (
    sch.name AS 'School Name',
    count(*) AS 'Number of Loans', 
    MONTH(b.borrow_date) AS 'Month',
    YEAR(b.borrow_date) AS 'Year'
    FROM school_unit sch
    INNER JOIN lib_user u
    ON u.school_id = sch.school_id
    INNER JOIN borrow_log b
    WHERE b.user_id = u.user_id
    GROUP BY MONTH(b.borrow_date), sch.name
);

-- 3.1.4
SELECT (
    author_first_name, author_last_name
    FROM author a,
    INNER JOIN book_author ba
    ON ba.author_id = a.author_id
    INNER JOIN book b
    ON b.book_id = ba.book_id
    INNER JOIN borrow_log bl
    ON bl.book_id = b.book_id
    WHERE (count(b) = 0);
);

-- 3.3.1
SELECT ISBN, title, copies FROM school_book_info WHERE school_id = 1;

-- 3.3.2
SELECT * FROM log_info WHERE user_id = 1;
CREATE VIEW log_info AS
	SELECT u.user_id, b.ISBN, b.title, bl.borrow_date
    FROM lib_user u 
    INNER JOIN borrow_log bl
    ON bl.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = bl.book_id;