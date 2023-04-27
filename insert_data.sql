INSERT INTO book (ISBN, title, page_number, summary, lang, image_path, key_words)
VALUES (
    ('9781788399081', 'Learning PHP 7', 320, 'Learn PHP 7 with this practical and easy-to-follow guide.', 'English', '/images/php.jpg', 'PHP, web development'),
    ('9780132350884', 'Clean Code', 464, 'A handbook of agile software craftsmanship.', 'English', '/images/cleancode.jpg', 'Software development, programming'),
    ('9781593275990', 'Eloquent JavaScript', 472, 'A modern introduction to programming with JavaScript.', 'English', '/images/javascript.jpg', 'JavaScript, web development'),
    ('9781492040408', 'Python for Data Analysis', 544, 'A practical guide to processing, analyzing, and visualizing data using Python.', 'English', '/images/python.jpg', 'Python, data analysis'),
    ('9780132350884', 'Head First Design Patterns', 676, 'A brain-friendly guide to understanding design patterns in software development.', 'English', '/images/designpatterns.jpg', 'Software development, programming'),
    ('9780262033848', 'Introduction to Algorithms', 1312, 'A comprehensive introduction to algorithms and their analysis.', 'English', '/images/algorithms.jpg', 'Algorithms, computer science'),
    ('9780132350884', 'Refactoring', 448, 'Improving the design of existing code.', 'English', '/images/refactoring.jpg', 'Software development, programming'),
    ('9780321933883', 'Effective Java', 416, 'A guide to writing high-quality, robust Java code.', 'English', '/images/effectivejava.jpg', 'Java, programming'),
    ('9781449343033', 'Learning Python', 384, 'Powerful Object-Oriented Programming', 'English', '/images/learningpython.jpg', 'Python, programming'),
    ('9780262033848', 'The C Programming Language', 272, 'A classic introduction to C programming.', 'English', '/images/c.jpg', 'C programming, computer science'),
    ('9780321205681', 'Agile Software Development', 624, 'The Cooperative Game', 'English', '/images/agile.jpg', 'Agile software development, project management'),
    ('9781789349868', 'Deep Learning with TensorFlow 2 and Keras', 596, 'Beginner\'s Guide to Artificial Intelligence and Machine Learning', 'English', '/images/deeplearning.jpg', 'Deep learning, artificial intelligence'),
    ('9781491989388', 'Hands-On Machine Learning with Scikit-Learn and TensorFlow', 596, 'Concepts, Tools, and Techniques to Build Intelligent Systems', 'English', '/images/hands-on-ml.jpg', 'Machine learning, artificial intelligence'),
    ('9781839213470', 'Java 17 Quick Start Guide', 266, 'Get up to speed with Java programming in a quick and effective way', 'English', '/images/java17.jpg', 'Java, programming'),
    ('9781838559333', 'Hands-On Microservices with Spring Boot and Spring Cloud', 374, 'Discover the world of microservices with Spring Boot and Spring Cloud', 'English', '/images/microservices.jpg', 'Microservices, Spring Boot, Spring Cloud'),
    ('9781492078722', 'Hands-On Rust', 444, 'Effective learning through practical projects, recipes, and examples', 'English', '/images/rust.jpg', 'Rust programming, programming'),
    ('9780262033848', 'Introduction to Algorithms', 1312, 'A comprehensive introduction to algorithms and their analysis.', 'English', '/images/algorithms.jpg', 'Algorithms, computer science'),
    ('9781617294136', 'Deep Learning with PyTorch', 520, 'A practical approach to building neural network models with PyTorch.', 'English', '/images/pytorch.jpg', 'Deep learning, artificial intelligence'),
    ('9780134706054', 'Java Concurrency in Practice', 432, 'A guide to developing safe and scalable concurrent applications in Java.', 'English', '/images/javaconcurrency.jpg', 'Java, concurrency'),
	('9781617295492', 'Grokking Deep Learning', 536, 'A beginner-friendly introduction to deep learning with TensorFlow and Keras.', 'English', '/images/grokkingdl.jpg', 'Deep learning, artificial intelligence'),
    ('9781491978917', 'Kubernetes: Up and Running', 202, 'A guide to deploying, scaling, and managing containerized applications with Kubernetes.', 'English', '/images/kubernetes.jpg', 'Kubernetes, containerization'),
    ('9781838987641', 'Mastering TypeScript 4', 638, 'A comprehensive guide to TypeScript, including advanced concepts like decorators and generics.', 'English', '/images/typescript.jpg', 'TypeScript, programming'),
	('9780141182801', 'To Kill a Mockingbird', 281, 'A classic novel set in the American South during the 1930s.', 'English', 'path/to/image1.jpg', 'racism, justice'),
	('9780679745587', 'One Hundred Years of Solitude', 417, 'A landmark novel in the magical realism genre.', 'Spanish', 'path/to/image2.jpg', 'family, history'),
	('9780385472579', 'The Alchemist', 163, 'A spiritual tale about a shepherd boy on a journey to find treasure.', 'Portuguese', 'path/to/image3.jpg', 'adventure, self-discovery'),
	('9780061120084', 'The Name of the Wind', 662, 'The story of a legendary wizard, told in his own words.', 'English', 'path/to/image4.jpg', 'fantasy, adventure'),
	('9780765311788', 'Old Man\'s War', 368, 'A science fiction novel about elderly people joining a military force to defend Earth.', 'English', 'path/to/image5.jpg', 'space, aliens'),
	('9780143038412', 'The God of Small Things', 333, 'A novel about a family in India and the tragic events that befall them.', 'English', 'path/to/image6.jpg', 'family, tragedy'),
	('9780671027360', 'Angels and Demons', 736, 'A thriller about a conspiracy to destroy the Vatican.', 'English', 'path/to/image7.jpg', 'suspense, mystery'),
	('9780553588484', 'A Game of Thrones', 694, 'The first book in the popular A Song of Ice and Fire series, a fantasy epic about warring kingdoms.', 'English', 'path/to/image8.jpg', 'fantasy, politics'),
	('9780545162074', 'Harry Potter and the Deathly Hallows', 784, 'The final book in the Harry Potter series, in which Harry confronts Voldemort.', 'English', 'path/to/image9.jpg', 'magic, adventure'),
	('9780441013593', 'Altered Carbon', 526, 'A science fiction novel about a future in which human consciousness can be stored and transferred between bodies.', 'English', 'path/to/image10.jpg', 'cyberpunk, noir'),
	('9780575085153', 'The Graveyard Book', 312, 'A children\'s fantasy novel about a boy who grows up in a graveyard.', 'English', 'path/to/image11.jpg', 'fantasy, coming-of-age'),
	('9780553801477', 'The Road', 287, 'A post-apocalyptic novel about a father and son journeying through a desolate landscape.', 'English', 'path/to/image12.jpg', 'dystopia, survival'),
	('9780060929879', 'The Color Purple', 288, 'A Pulitzer Prize-winning novel about a young Black woman\'s struggle for self-acceptance and empowerment.', 'English', 'path/to/image13.jpg', 'race, gender'),
	('9780452284240', 'The Kite Runner', 371, 'A novel about the friendship between two boys in Afghanistan, and the betrayal that tears them apart.', 'English', 'path/to/image14.jpg', 'friendship, redemption'),
	('9789602406187', 'Το χρονικό μιας προετοιμασίας', 279, 'Ένα μυθιστόρημα που αναφέρεται στον πόλεμο και τις επιπτώσεις του στους ανθρώπους.', 'Greek', 'path/to/image15.jpg', 'πόλεμος, ανθρώπινες σχέσεις'),
	('9786185147194', 'Το κουρέλι του Θεού', 223, 'Ένα μυθιστόρημα για έναν άντρα που ξεκινά ένα ταξίδι στο παρελθόν του.', 'Greek', 'path/to/image16.jpg', 'αναζήτηση ταυτότητας, μνήμη'),
	('9789601409767', 'Ο ξένος', 189, 'Ένα μυθιστόρημα για έναν άντρα που ξεκινά ένα ταξίδι στην Αλγερία.', 'Greek', 'path/to/image17.jpg', 'εξωτερικότητα, ταυτότητα'),
	('9789600352103', 'Αγάπη στο χρόνο της χολέρας', 352, 'Ένα μυθιστόρημα για μια αγάπη που επιβίωσε μέσα από την επιδημία της χολέρας.', 'Greek', 'path/to/image18.jpg', 'αγάπη, επιβίωση'),
	('9789603066033', 'Το πορτραίτο του Ντόριαν Γκρέι', 231, 'Ένα μυθιστόρημα για έναν άντρα που διατηρεί τη νεότητά του ενώ ένας πίνακας με το πορτραίτο του γερνάει.', 'Greek', 'path/to/image19.jpg', 'αιώνια νεότητα, διαφθορά'),
	('9783426285321', 'Der Name der Rose', 592, 'Ein historischer Roman, der im 14. Jahrhundert spielt und in einem Kloster voller Geheimnisse und Intrigen verstrickt ist.', 'German', 'path/to/image31.jpg', 'Mittelalter, Klosterleben, Kriminalfall'),
	('9783550206015', 'Die unendliche Geschichte', 448, 'Ein phantastischer Roman über ein Kind, das ein Buch liest und dadurch in eine magische Welt eintaucht.', 'German', 'path/to/image32.jpg', 'Fantasy, Abenteuer, Kindheit'),
	('9783462043336', 'Das Parfum', 304, 'Ein Roman über einen Mann, der eine besondere Begabung für Düfte hat und dafür sogar Menschenleben riskiert.', 'German', 'path/to/image33.jpg', 'Sinne, Mord, Obsession'),
	('9783446207795', 'Der kleine Prinz', 96, 'Ein philosophisches Märchen über einen kleinen Prinzen, der auf seiner Reise durch das Universum wichtige Erkenntnisse gewinnt.', 'German', 'path/to/image34.jpg', 'Philosophie, Kinderbuch, Erkenntnis'),
	('9783596905756', 'Die Verwandlung', 96, 'Eine Erzählung über einen Mann, der sich plötzlich in ein Insekt verwandelt und mit der Ablehnung seiner Familie und seiner Arbeit konfrontiert wird.', 'German', 'path/to/image35.jpg', 'Verwandlung, Isolation, Familienbeziehungen'),
	('9783423261404', 'Im Westen nichts Neues', 256, 'Ein Antikriegsroman, der den Ersten Weltkrieg aus der Perspektive eines jungen Soldaten schildert.', 'German', 'path/to/image36.jpg', 'Krieg, Soldatenleben, Antikrieg'),
	('9783458328334', 'Der Steppenwolf', 320, 'Ein Roman über einen Mann, der sich zwischen seinem bürgerlichen Leben und seiner Sehnsucht nach Freiheit und Individualität zerrissen fühlt.', 'German', 'path/to/image37.jpg', 'Existenzialismus, Individualität, Selbstfindung'),
	('9783423130595', 'Die Blechtrommel', 592, 'Ein grotesker Roman über einen Jungen, der beschließt, nicht weiter zu wachsen und seine Umwelt durch seine Trommel zum Wahnsinn treibt.', 'German', 'path/to/image38.jpg', 'Groteske, Kindheit, Krieg'),
	('9783596906265', 'Siddhartha', 144, 'Ein spiritueller Roman über einen Mann, der auf der Suche nach Erleuchtung durch Indien reist und schließlich zu sich selbst findet.', 'German', 'path/to/image39.jpg', 'Spiritualität, Selbstfindung, Indien'),
	('9783423126888', 'Narziß und Goldmund', 448, 'Ein Roman über zwei Freunde, die unterschiedlicher nicht sein könnten: Der eine ist ein asketischer Mönch, der andere ein lebenslustiger Künstler.', 'German', 'path/to/image40.jpg', 'Freundschaft, Kunst, Spiritualität'),
);


INSERT INTO publisher (publisher_name) VALUES (
	('Penguin Random House'),
	('HarperCollins'),
	('Simon & Schuster'),
	('Hachette Livre'),
	('Macmillan Publishers')
);


INSERT INTO category (category_name) VALUES (
    ('Fiction'),
    ('Non-fiction'),
    ('Mystery'),
    ('Romance'),
    ('Sci-Fi'),
    ('Fantasy'),
    ('Biography'),
    ('History'),
    ('Self-help'),
    ('Travel')
);


INSERT INTO author (author_first_name, author_last_name) VALUES (
    ('J.K.', 'Rowling'),
    ('Stephen', 'King'),
    ('George R.R.', 'Martin'),
    ('John', 'Grisham'),
    ('Dan', 'Brown'),
    ('Haruki', 'Murakami'),
    ('Margaret', 'Atwood'),
    ('Agatha', 'Christie'),
    ('Toni', 'Morrison'),
    ('Jane', 'Austen'),
    ('Mark', 'Twain'),
    ('Ernest', 'Hemingway'),
    ('Gabriel', 'García Márquez'),
    ('Khaled', 'Hosseini'),
    ('Philip', 'Roth'),
    ('J.D.', 'Salinger'),
    ('Mary', 'Shelley'),
    ('Herman', 'Melville'),
    ('Leo', 'Tolstoy'),
    ('Fyodor', 'Dostoevsky')
);

INSERT INTO review (user_id, book_id, review_text, rating)
VALUES (1, 2, 'This book was a page-turner', 4),
       (2, 5, 'One of the best books I''ve ever read', 5),
       (3, 8, 'Didn''t live up to the hype', 2),
       (4, 12, 'A good book, but not my favorite', 3),
       (5, 20, 'I couldn''t put this book down', 5),
       (6, 25, 'The ending left me wanting more', 4),
       (7, 30, 'The writing was beautiful, but the plot was slow', 3),
       (8, 35, 'This book made me cry', 5),
       (9, 40, 'I found this book to be very thought-provoking', 4),
       (10, 45, 'The characters were well-developed', 4),
       (11, 50, 'This book was a bit predictable', 3),
       (12, 15, 'A great coming-of-age story', 4),
       (13, 18, 'The twists and turns kept me on the edge of my seat', 5),
       (14, 23, 'I wasn''t a fan of the writing style', 2),
       (15, 27, 'This book was an emotional rollercoaster', 5),
       (16, 33, 'I would recommend this book to anyone', 5),
       (17, 39, 'The world-building was fantastic', 4),
       (18, 42, 'This book fell short of my expectations', 3),
       (19, 46, 'I couldn''t connect with the main character', 2),
       (20, 49, 'This book was a bit slow-paced', 3);

