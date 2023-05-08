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
