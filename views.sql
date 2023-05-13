CREATE VIEW book_details AS
SELECT 
    b.title, a.author_last_name, b.page_number, b.lang, c.category_name, b.summary, b.image_path, b.key_words
FROM 
    book b 
JOIN 
    book_author ba ON b.book_id = ba.book_id 
JOIN 
    author a ON ba.author_id = a.author_id 
JOIN 
    book_category bc ON b.book_id = bc.book_id 
JOIN 
    category c ON bc.category_id = c.category_id;

CREATE VIEW user_books_view AS
SELECT book.title, author.author_last_name, borrow_log.borrow_date, borrow_log.user_id
FROM book
JOIN book_author ON book.book_id = book_author.book_id
JOIN author ON book_author.author_id = author.author_id
JOIN borrow_log ON book.book_id = borrow_log.book_id;
