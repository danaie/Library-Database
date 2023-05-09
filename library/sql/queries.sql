-- 3.1.1
SELECT sch.name AS 'School Name',
       count(*) AS 'Number of Loans', 
       strftime('%m', b.borrow_date) AS 'Month',
       strftime('%Y', b.borrow_date) AS 'Year'
FROM school_unit sch
INNER JOIN lib_user u ON u.school_id = sch.school_id
INNER JOIN borrow_log b ON b.user_id = u.user_id
WHERE strftime('%Y', b.borrow_date) = '2016' AND strftime('%m', b.borrow_date) = '01'
GROUP BY sch.name


-- 3.1.2_1
SELECT DISTINCT author.author_first_name, author.author_last_name 
FROM author 
JOIN book_author ON author.author_id = book_author.author_id 
JOIN book_category ON book_author.book_id = book_category.book_id 
JOIN category ON book_category.category_id = category.category_id 
WHERE category.category_name = 'Biography'

-- 3.1.2_2
SELECT DISTINCT u.first_name, u.last_name
FROM lib_user u
JOIN borrow_log bl ON u.user_id = bl.user_id
JOIN book b ON bl.book_id = b.book_id
JOIN book_category bc ON b.book_id = bc.book_id
JOIN category c ON bc.category_id = c.category_id
WHERE c.category_name = 'History'
AND bl.borrow_date >= DATE('now', '-1 year')
AND u.user_role = 't'

--3.1.3
SELECT lib_user.first_name, lib_user.last_name, COUNT(*) AS num_borrowed_books
FROM lib_user
JOIN borrow_log ON lib_user.user_id = borrow_log.user_id
JOIN book ON borrow_log.book_id = book.book_id
JOIN book_category ON book.book_id = book_category.book_id
WHERE lib_user.user_role = 't' AND lib_user.age < 40
GROUP BY lib_user.user_id
ORDER BY num_borrowed_books DESC;

--3.1.4
SELECT DISTINCT author.author_first_name, author.author_last_name
FROM book_author
JOIN author ON book_author.author_id = author.author_id
WHERE NOT EXISTS (
    SELECT *
    FROM borrow_log
    WHERE borrow_log.book_id = book_author.book_id
)

--3.1.5
SELECT bl1.user_id, COUNT(DISTINCT bl1.book_id) AS num_books_borrowed
FROM borrow_log bl1
WHERE bl1.borrow_date >= DATE('now', '-1 year')
GROUP BY bl1.user_id
HAVING COUNT(DISTINCT bl1.book_id) > 20
INTERSECT
SELECT bl2.user_id, COUNT(DISTINCT bl2.book_id) AS num_books_borrowed
FROM borrow_log bl2
WHERE bl2.borrow_date >= DATE('now', '-1 year')
GROUP BY bl2.user_id
HAVING COUNT(DISTINCT bl2.book_id) > 20;








