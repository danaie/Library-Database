-- -------
-- Queries
-- -------

-- 3.1.1
SELECT * FROM tot_loans WHERE b_month = '04' AND b_year = '2022';

-- Do not execute the following CREATE statement, only used for reference
CREATE VIEW tot_loans (school_name, no_loans, b_month, b_year) AS
    SELECT 
        sch.name AS 'School Name',
        COUNT(*) AS 'Number of Loans',
        MONTH(b.borrow_date) AS 'Month',
        YEAR(b.borrow_date) AS 'Year'
    FROM
        school_unit sch
            INNER JOIN
        lib_user u ON u.school_id = sch.school_id
            INNER JOIN
        borrow_log b
    WHERE
        b.user_id = u.user_id
    GROUP BY MONTH(b.borrow_date), YEAR(b.borrow_date), sch.name;
    
-- 3.1.2a
SELECT author FROM
	(SELECT DISTINCT c.category_name AS category, CONCAT(a.author_first_name, ' ', a.author_last_name) AS author
	FROM author a INNER JOIN book_author ba ON ba.author_id = a.author_id
	INNER JOIN book b ON b.book_id = ba.book_id
	INNER JOIN book_category bc ON bc.book_id = b.book_id
	INNER JOIN category c ON c.category_id = bc.category_id) AS cat_auth
    WHERE cat_auth.category = 'Fiction';
    
-- 3.1.2b

-- 3.1.3
SELECT CONCAT(u.first_name, ' ', u.last_name) AS teacher_name, COUNT(bl.book_id) AS book_nmbr
FROM lib_user u
INNER JOIN borrow_log bl ON u.user_id = bl.user_id
WHERE DATEDIFF(CURDATE(), u.birth_date)/365 < 40 AND u.user_role = 't'
GROUP BY bl.user_id
ORDER BY book_nmbr DESC;

    
-- 3.1.4
select * from author where author_id not in (
select distinct author_id from book_author where book_id in 
(select book_id from borrow_log)
);


-- 3.1.5
SELECT * FROM (
	SELECT lm.username, CONCAT(lm.first_name, ' ', lm.last_name) AS lib_man_name, sch.name, 
	COUNT(bl.user_id) AS loan_nmbr, YEAR(bl.borrow_date) AS loan_year
	FROM school_unit sch
	INNER JOIN lib_user u ON sch.school_id = u.school_id
	INNER JOIN borrow_log bl ON bl.user_id = u.user_id
	INNER JOIN lib_user lm ON lm.school_id = sch.school_id
	WHERE lm.user_role = 'l'
	GROUP BY lm.username, sch.school_id, loan_year) AS lib_loan
WHERE lib_loan.loan_nmbr > 0 AND lib_loan.loan_year = '2020';


-- 3.1.7
CREATE VIEW author_books AS
	SELECT author.author_id, CONCAT(author.author_first_name, ' ', author.author_last_name) AS author, 
        COUNT(book_author.book_id) AS total_books
    FROM author
    LEFT JOIN book_author ON author.author_id = book_author.author_id
    GROUP BY author.author_id, author.author_first_name, author.author_last_name;
    
SELECT author
FROM author_books
WHERE author_books.total_books <= (SELECT MAX(total_books) FROM author_books) - 5;


-- 3.2.1
SELECT book_id, ISBN, title, auth, copies FROM school_book_info WHERE school_id=1;


-- 3.2.2
SELECT * FROM delay_info WHERE school_id = 1
        AND REGEXP_LIKE(first_name,'john') AND REGEXP_LIKE(last_name,'d') 
        AND DATEDIFF(CURDATE(), service_date) > 7;
        
SELECT * FROM delay_info WHERE school_id = 1
        AND REGEXP_LIKE(first_name,'jph') AND REGEXP_LIKE(last_name,'e')
        AND DATEDIFF(CURDATE(), service_date) = 35;
        
-- Do not execute the following CREATE statement, only used for reference
CREATE VIEW delay_info AS
	SELECT u.school_id, u.user_id, u.first_name, u.last_name, 
		s.service_date, datediff(curdate(), service_date)-14 AS delay
    FROM lib_user u 
    INNER JOIN service s
    ON s.user_id = u.user_id
    WHERE service_type = 'b';


-- 3.2.3
SELECT AVG(rating) FROM rating_info WHERE username='john';
SELECT AVG(rating) FROM rating_info WHERE category_id=6;

-- Do not execute the following CREATE statement, only used for reference
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

-- 3.3.1
SELECT ISBN, title, copies FROM school_book_info
WHERE school_id = 1 AND title like "%rose%" AND category like "%bio%" AND auth like '%leo%';


-- 3.3.2
SELECT * FROM log_info WHERE user_id = 1;

-- Do not execute the following CREATE statement, only used for reference
CREATE VIEW log_info AS
	SELECT u.user_id, b.ISBN, b.title, bl.borrow_date
    FROM lib_user u 
    INNER JOIN borrow_log bl
    ON bl.user_id = u.user_id
    INNER JOIN book b
    ON b.book_id = bl.book_id;