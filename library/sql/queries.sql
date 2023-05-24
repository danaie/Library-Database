SELECT * FROM book;

-- 3.1.1 //in python after the selection
SELECT sch.name AS 'School Name',
       COUNT(*) AS 'Number of Loans' 
FROM school_unit sch
INNER JOIN lib_user u ON u.school_id = sch.school_id
INNER JOIN borrow_log b ON b.user_id = u.user_id
WHERE YEAR(b.borrow_date) = 2016 AND MONTH(b.borrow_date) = 1
GROUP BY sch.name;


-- 3.1.2_1///in python after the selection
SELECT DISTINCT author.author_first_name, author.author_last_name 
FROM author 
JOIN book_author ON author.author_id = book_author.author_id 
JOIN book_category ON book_author.book_id = book_category.book_id 
JOIN category ON book_category.category_id = category.category_id 
WHERE category.category_name = 'Fiction';

-- 3.1.2_2 //in python after the selection
SELECT DISTINCT u.first_name, u.last_name
FROM lib_user u
JOIN borrow_log bl ON u.user_id = bl.user_id
JOIN book b ON bl.book_id = b.book_id
JOIN book_category bc ON b.book_id = bc.book_id
JOIN category c ON bc.category_id = c.category_id
WHERE c.category_name = 'History'
AND u.user_role = 't';

---test
SELECT t.first_name, t.last_name, b.borrow_date, c.category_name
FROM lib_user t
INNER JOIN borrow_log b ON b.user_id=t.user_id
INNER JOIN book_category bc ON bc.book_id = b.book_id
INNER JOIN category c ON c.category_id = bc.category_id
WHERE t.user_role = 't'



--3.1.3_helper
    CREATE VIEW view_3_1_3_help  AS
    SELECT lib_user.first_name, lib_user.last_name, COUNT(*) AS num_borrowed_books
    FROM lib_user
    JOIN borrow_log ON lib_user.user_id = borrow_log.user_id
    WHERE lib_user.user_role = 't' AND TIMESTAMPDIFF(YEAR, lib_user.birth_date, CURDATE()) < 40
    GROUP BY lib_user.user_id
    ORDER BY num_borrowed_books DESC;
--3.1.3
CREATE VIEW view_3_1_3 AS
SELECT v.first_name, v.last_name, v.num_borrowed_books
FROM view_3_1_3_help v
WHERE v.num_borrowed_books = (
    SELECT MAX(num_borrowed_books)
    FROM view_3_1_3_help
)
ORDER BY v.last_name, v.first_name;



--3.1.4
CREATE VIEW view_3_1_4 AS
SELECT DISTINCT author.author_first_name, author.author_last_name
FROM book_author
JOIN author ON book_author.author_id = author.author_id
WHERE NOT EXISTS (
    SELECT *
    FROM borrow_log
    WHERE borrow_log.book_id = book_author.book_id
)
---we use it in 3.1.5
-DROP VIEW tot_loans_year
CREATE VIEW tot_loans_year (school_id, school_name, no_loans, b_year) AS
    SELECT 
        sch.school_id,
        sch.name AS 'School Name',
        COUNT(*) AS 'Number of Loans',
        YEAR(b.borrow_date) AS 'Year'
    FROM
        school_unit sch
            INNER JOIN
        lib_user u ON u.school_id = sch.school_id
            INNER JOIN
        borrow_log b ON b.user_id = u.user_id
    GROUP BY sch.school_id, YEAR(b.borrow_date), sch.name;

---test
SELECT *
FROM tot_loans_year;

--3.1.5
-DROP VIEW view_3_1_5
CREATE VIEW view_3_1_5 AS
SELECT u.first_name, u.last_name, t1.school_name AS school_name1, t1.no_loans AS no_loans1, t2.school_name AS school_name2, t2.no_loans AS no_loans2
FROM tot_loans_year t1
JOIN tot_loans_year t2 ON t1.no_loans = t2.no_loans AND t1.school_name <> t2.school_name AND t1.b_year = t2.b_year
JOIN lib_user u ON u.school_id = t1.school_id AND u.user_role = 'l'
WHERE t1.no_loans > 20
ORDER BY t1.no_loans DESC, t1.school_name, t2.school_name;




---test
SELECT a.author_first_name, a.author_last_name, COUNT(ba.book_id) AS book_count
FROM author a
JOIN book_author ba ON a.author_id = ba.author_id
GROUP BY a.author_id, a.author_first_name, a.author_last_name;



---we will use to in 3_1_7
CREATE VIEW author_book_count AS
SELECT author_id, COUNT(book_id) AS book_count
FROM book_author
GROUP BY author_id;

---test
SELECT MAX(book_count) AS max_book_count
FROM author_book_count;


--3.1.7
-DROP VIEW view_3_1_7
CREATE VIEW view_3_1_7 AS
SELECT a.author_first_name, a.author_last_name
FROM author a
JOIN author_book_count abc ON a.author_id = abc.author_id
WHERE abc.book_count <= (
    SELECT MAX(book_count) - 5
    FROM author_book_count
);
