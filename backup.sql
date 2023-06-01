-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `author_first_name` varchar(20) NOT NULL,
  `author_last_name` varchar(20) NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE KEY `author_first_name` (`author_first_name`,`author_last_name`),
  KEY `author_idx` (`author_last_name`,`author_first_name`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (8,'Agatha','Christie'),(5,'Dan','Brown'),(12,'Ernest','Hemingway'),(20,'Fyodor','Dostoevsky'),(13,'Gabriel','García Márquez'),(3,'George R.R.','Martin'),(6,'Haruki','Murakami'),(18,'Herman','Melville'),(16,'J.D.','Salinger'),(1,'J.K.','Rowling'),(10,'Jane','Austen'),(4,'John','Grisham'),(14,'Khaled','Hosseini'),(19,'Leo','Tolstoy'),(7,'Margaret','Atwood'),(11,'Mark','Twain'),(17,'Mary','Shelley'),(15,'Philip','Roth'),(34,'Rick','Riordan'),(2,'Stephen','King'),(9,'Toni','Morrison'),(29,'Αγγελος','Σικελιανός'),(28,'Αλέξης','Ζορμπάς'),(26,'Γιάννης','Ρίτσος'),(22,'Γιώργος','Σεφέρης'),(25,'Δημήτρης','Βικέλας'),(33,'Δημήτρης','Λιαντίνης'),(27,'Ευτυχία','Παπαγιαννοπούλου'),(23,'Κωνσταντίνος','Καβάφης'),(30,'Μαρία','Ηλιοπούλου-Περδικάρη'),(32,'Νίκος','Εγγονόπουλος'),(21,'Νίκος','Καζαντζάκης'),(24,'Οδυσσέας','Ελύτης'),(31,'Τάκης','Σινόπουλος');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `author_books`
--

DROP TABLE IF EXISTS `author_books`;
/*!50001 DROP VIEW IF EXISTS `author_books`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `author_books` AS SELECT 
 1 AS `author_id`,
 1 AS `author`,
 1 AS `total_books`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availability` (
  `school_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `copies` int DEFAULT NULL,
  UNIQUE KEY `school_id` (`school_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `availability_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school_unit` (`school_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `availability_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `copies_gr_zero` CHECK ((`copies` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
INSERT INTO `availability` VALUES (2,1,18),(3,1,14),(2,2,10),(3,2,3),(1,3,11),(3,4,8),(2,5,3),(3,5,7),(3,6,10),(3,7,10),(1,8,2),(2,8,5),(3,9,12),(1,10,17),(3,10,16),(1,11,6),(2,11,5),(3,11,17),(1,12,7),(2,12,14),(3,12,5),(1,13,3),(2,13,15),(3,14,17),(2,15,4),(3,15,15),(3,16,20),(2,17,15),(2,18,8),(3,19,2),(1,20,7),(2,20,6),(3,20,5),(1,21,1),(2,21,12),(3,21,18),(1,22,2),(2,22,10),(1,23,18),(2,23,7),(3,23,7),(2,24,9),(3,24,13),(1,25,4),(3,25,9),(1,26,1),(2,26,17),(3,26,19),(1,27,7),(2,27,2),(3,28,13),(3,29,7),(1,30,4),(2,30,8),(1,31,13),(3,31,16),(1,32,15),(2,32,19),(3,32,10),(1,33,16),(3,33,4),(1,34,9),(3,34,4),(3,35,5),(2,36,10),(1,37,5),(2,37,11),(3,37,11),(1,38,13),(3,38,6),(3,39,3),(1,40,18),(3,40,9),(2,41,20),(3,42,6),(2,43,18),(2,44,3),(2,45,4),(2,46,13),(1,47,9),(2,47,14),(2,48,1),(3,48,20),(2,49,20),(1,50,11),(3,51,17),(3,52,8),(2,53,20),(1,54,3),(2,54,7),(1,55,2),(2,55,20),(1,56,20),(2,56,1),(3,57,1),(1,58,3),(2,58,17),(3,59,5),(1,60,3),(3,60,19),(3,61,10),(2,62,13),(1,63,20),(3,63,11),(3,64,14),(1,65,2),(2,65,5),(1,66,7),(1,67,5),(3,67,9),(3,68,17),(2,69,3),(3,70,9),(2,71,9),(1,72,4),(2,72,4),(1,73,7),(1,74,18),(3,74,14),(2,75,9),(2,76,15),(3,76,20),(2,77,9),(3,77,0),(2,78,20),(2,79,16),(3,79,5),(2,80,6),(3,80,4),(2,81,19),(3,81,10),(2,82,13),(3,83,2),(3,84,1),(1,85,4),(2,85,2),(3,85,11),(1,86,17),(1,87,5),(3,88,7),(2,89,19),(3,90,12),(1,91,18),(3,91,15),(2,92,13),(3,92,11),(2,93,16),(3,93,0),(3,94,11),(1,95,17),(3,95,10),(1,96,6),(3,96,6),(2,97,14),(3,97,10),(3,98,12),(1,99,1),(1,100,15),(2,100,18),(1,101,2);
/*!40000 ALTER TABLE `availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(13) NOT NULL,
  `title` varchar(100) NOT NULL,
  `page_number` int NOT NULL,
  `summary` varchar(200) DEFAULT 'No summary available.',
  `lang` varchar(15) NOT NULL,
  `image_path` varchar(100) GENERATED ALWAYS AS (concat(_utf8mb4'https://covers.openlibrary.org/b/isbn/',`ISBN`,_utf8mb4'-L.jpg')) VIRTUAL,
  `key_words` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `ISBN` (`ISBN`),
  KEY `title_idx` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` (`book_id`, `ISBN`, `title`, `page_number`, `summary`, `lang`, `key_words`) VALUES (1,'9781788399081','Learning PHP 7',320,'Learn PHP 7 with this practical and easy-to-follow guide.','English','PHP, web development'),(2,'9781593275990','Eloquent JavaScript',472,'A modern introduction to programming with JavaScript.','English','JavaScript, web development'),(3,'9781492040408','Python for Data Analysis',544,'A practical guide to processing, analyzing, and visualizing data using Python.','English','Python, data analysis'),(4,'9780132350884','Head First Design Patterns',676,'A brain-friendly guide to understanding design patterns in software development.','English','Software development, programming'),(5,'9780262033858','Introduction to Algorithms',1312,'A comprehensive introduction to algorithms and their analysis.','English','Algorithms, computer science'),(6,'9780132350874','Refactoring',448,'Improving the design of existing code.','English','Software development, programming'),(7,'9780321933883','Effective Java',416,'A guide to writing high-quality, robust Java code.','English','Java, programming'),(8,'9781449343033','Learning Python',384,'Powerful Object-Oriented Programming','English','Python, programming'),(9,'9780262033898','The C Programming Language',272,'A classic introduction to C programming.','English','C programming, computer science'),(10,'9780321205681','Agile Software Development',624,'The Cooperative Game','English','Agile software development, project management'),(11,'9781789349868','Deep Learning with TensorFlow 2 and Keras',596,'Beginner\'s Guide to Artificial Intelligence and Machine Learning','English','Deep learning, artificial intelligence'),(12,'9781491989388','Hands-On Machine Learning with Scikit-Learn and TensorFlow',596,'Concepts, Tools, and Techniques to Build Intelligent Systems','English','Machine learning, artificial intelligence'),(13,'9781839213470','Java 17 Quick Start Guide',266,'Get up to speed with Java programming in a quick and effective way','English','Java, programming'),(14,'9781838559333','Hands-On Microservices with Spring Boot and Spring Cloud',374,'Discover the world of microservices with Spring Boot and Spring Cloud','English','Microservices, Spring Boot, Spring Cloud'),(15,'9781492078722','Hands-On Rust',444,'Effective learning through practical projects, recipes, and examples','English','Rust programming, programming'),(16,'9781617294136','Deep Learning with PyTorch',520,'A practical approach to building neural network models with PyTorch.','English','Deep learning, artificial intelligence'),(17,'9780134706054','Java Concurrency in Practice',432,'A guide to developing safe and scalable concurrent applications in Java.','English','Java, concurrency'),(18,'9781617295492','Grokking Deep Learning',536,'A beginner-friendly introduction to deep learning with TensorFlow and Keras.','English','Deep learning, artificial intelligence'),(19,'9781491978917','Kubernetes: Up and Running',202,'A guide to deploying, scaling, and managing containerized applications with Kubernetes.','English','Kubernetes, containerization'),(20,'9781838987641','Mastering TypeScript 4',638,'A comprehensive guide to TypeScript, including advanced concepts like decorators and generics.','English','TypeScript, programming'),(21,'9780141182801','To Kill a Mockingbird',281,'A classic novel set in the American South during the 1930s.','English','racism, justice'),(22,'9780679745587','One Hundred Years of Solitude',417,'A landmark novel in the magical realism genre.','Spanish','family, history'),(23,'9780385472579','The Alchemist',163,'A spiritual tale about a shepherd boy on a journey to find treasure.','Portuguese','adventure, self-discovery'),(24,'9780061120084','The Name of the Wind',662,'The story of a legendary wizard, told in his own words.','English','fantasy, adventure'),(25,'9780765311788','Old Man\'s War',368,'A science fiction novel about elderly people joining a military force to defend Earth.','English','space, aliens'),(26,'9780143038412','The God of Small Things',333,'A novel about a family in India and the tragic events that befall them.','English','family, tragedy'),(27,'9780451524935','Pride and Prejudice',352,'A classic romance novel by Jane Austen','English','romance, classic, Jane Austen'),(28,'9780671027360','Angels and Demons',736,'A thriller about a conspiracy to destroy the Vatican.','English','suspense, mystery'),(29,'9780553588484','A Game of Thrones',694,'The first book in the popular A Song of Ice and Fire series, a fantasy epic about warring kingdoms.','English','fantasy, politics'),(30,'9780545162074','Harry Potter and the Deathly Hallows',784,'The final book in the Harry Potter series, in which Harry confronts Voldemort.','English','magic, adventure'),(31,'9780441013593','Altered Carbon',526,'A science fiction novel about a future in which human consciousness can be stored and transferred between bodies.','English','cyberpunk, noir'),(32,'9780575085153','The Graveyard Book',312,'A children\'s fantasy novel about a boy who grows up in a graveyard.','English','fantasy, coming-of-age'),(33,'9780553801477','The Road',287,'A post-apocalyptic novel about a father and son journeying through a desolate landscape.','English','dystopia, survival'),(34,'9780060929879','The Color Purple',288,'A Pulitzer Prize-winning novel about a young Black woman\'s struggle for self-acceptance and empowerment.','English','race, gender'),(35,'9780452284240','The Kite Runner',371,'A novel about the friendship between two boys in Afghanistan, and the betrayal that tears them apart.','English','friendship, redemption'),(36,'9789602406187','Το χρονικό μιας προετοιμασίας',279,'Ένα μυθιστόρημα που αναφέρεται στον πόλεμο και τις επιπτώσεις του στους ανθρώπους.','Greek','πόλεμος, ανθρώπινες σχέσεις'),(37,'9786185147194','Το κουρέλι του Θεού',223,'Ένα μυθιστόρημα για έναν άντρα που ξεκινά ένα ταξίδι στο παρελθόν του.','Greek','αναζήτηση ταυτότητας, μνήμη'),(38,'9789601409767','Ο ξένος',189,'Ένα μυθιστόρημα για έναν άντρα που ξεκινά ένα ταξίδι στην Αλγερία.','Greek','εξωτερικότητα, ταυτότητα'),(39,'9789600352103','Αγάπη στο χρόνο της χολέρας',352,'Ένα μυθιστόρημα για μια αγάπη που επιβίωσε μέσα από την επιδημία της χολέρας.','Greek','αγάπη, επιβίωση'),(40,'9789603066033','Το πορτραίτο του Ντόριαν Γκρέι',231,'Ένα μυθιστόρημα για έναν άντρα που διατηρεί τη νεότητά του ενώ ένας πίνακας με το πορτραίτο του γερνάει.','Greek','αιώνια νεότητα, διαφθορά'),(41,'9783426285321','Der Name der Rose',592,'Ein historischer Roman, der im 14. Jahrhundert spielt und in einem Kloster voller Geheimnisse und Intrigen verstrickt ist.','German','Mittelalter, Klosterleben, Kriminalfall'),(42,'9783550206015','Die unendliche Geschichte',448,'Ein phantastischer Roman über ein Kind, das ein Buch liest und dadurch in eine magische Welt eintaucht.','German','Fantasy, Abenteuer, Kindheit'),(43,'9783462043336','Das Parfum',304,'Ein Roman über einen Mann, der eine besondere Begabung für Düfte hat und dafür sogar Menschenleben riskiert.','German','Sinne, Mord, Obsession'),(44,'9783446207795','Der kleine Prinz',96,'Ein philosophisches Märchen über einen kleinen Prinzen, der auf seiner Reise durch das Universum wichtige Erkenntnisse gewinnt.','German','Philosophie, Kinderbuch, Erkenntnis'),(45,'9783596905756','Die Verwandlung',96,'Eine Erzählung über einen Mann, der sich plötzlich in ein Insekt verwandelt und mit der Ablehnung seiner Familie und seiner Arbeit konfrontiert wird.','German','Verwandlung, Isolation, Familienbeziehungen'),(46,'9783423261404','Im Westen nichts Neues',256,'Ein Antikriegsroman, der den Ersten Weltkrieg aus der Perspektive eines jungen Soldaten schildert.','German','Krieg, Soldatenleben, Antikrieg'),(47,'9783458328334','Der Steppenwolf',320,'Ein Roman über einen Mann, der sich zwischen seinem bürgerlichen Leben und seiner Sehnsucht nach Freiheit und Individualität zerrissen fühlt.','German','Existenzialismus, Individualität, Selbstfindung'),(48,'9783423130595','Die Blechtrommel',592,'Ein grotesker Roman über einen Jungen, der beschließt, nicht weiter zu wachsen und seine Umwelt durch seine Trommel zum Wahnsinn treibt.','German','Groteske, Kindheit, Krieg'),(49,'9783596906265','Siddhartha',144,'Ein spiritueller Roman über einen Mann, der auf der Suche nach Erleuchtung durch Indien reist und schließlich zu sich selbst findet.','German','Spiritualität, Selbstfindung, Indien'),(50,'9783423126888','Narziß und Goldmund',448,'Ein Roman über zwei Freunde, die unterschiedlicher nicht sein könnten: Der eine ist ein asketischer Mönch, der andere ein lebenslustiger Künstler.','German','Freundschaft, Kunst, Spiritualität'),(51,'9782020322667','La Bible',1200,'Le livre saint du christianisme, comprenant l\'Ancien et le Nouveau Testament.','French','christianisme, Bible, religion'),(52,'9782226100703','Le Coran',672,'Le livre saint de l\'islam, contenant les enseignements de Dieu révélés au prophète Mahomet.','French','islam, Coran, religion'),(53,'9782226120640','Le Livre tibétain de la vie et de la mort',544,'Un guide spirituel du bouddhisme tibétain sur la vie, la mort et l\'au-delà.','French','bouddhisme, spiritualité'),(54,'9782226189838','Les Quatre Accords toltèques',160,'Un guide pratique basé sur la sagesse toltèque pour trouver la liberté personnelle et le bonheur.','French','spiritualité, développement personnel'),(55,'9782226242472','La Cabale',400,'Une exploration des enseignements mystiques de la tradition juive.','French','judaïsme, mysticisme'),(56,'9782226310104','Le Dalaï-Lama parle de Jésus',224,'Un dialogue entre le Dalaï-Lama et des théologiens chrétiens sur la figure de Jésus.','French','christianisme, bouddhisme, dialogue interreligieux'),(57,'9788845293878','Breve storia di quasi tutto',512,'Un viaggio affascinante attraverso la storia della scienza e delle scoperte che hanno trasformato il nostro modo di comprendere il mondo.','Italian','scienza, storia, scoperte'),(58,'9788804668235','Il mondo in 30 secondi',160,'Un libro che offre un rapido panorama delle principali teorie scientifiche, esperimenti e concetti fondamentali.','Italian','scienza, teorie scientifiche, esperimenti'),(59,'9788850230521','Cosmos',320,'Un\'affascinante esplorazione dell\'universo, dalla formazione delle galassie alle leggi della fisica.','Italian','astronomia, fisica, universo'),(60,'9788804600519','Sapiens: Da animali a dèi',480,'Un\'indagine sulla storia dell\'umanità, dalla comparsa dei primi Homo sapiens fino alle società moderne.','Italian','storia, antropologia, evoluzione'),(61,'9788845299450','L\'universo elegante',448,'Un\'esplorazione delle teorie della fisica moderna, inclusa la teoria delle stringhe e il concetto di multiverso.','Italian','fisica, teoria delle stringhe, multiverso'),(62,'9788845285514','La particella di Dio',448,'Un\'avvincente narrazione sulle scoperte che hanno portato alla conferma dell\'esistenza del bosone di Higgs.','Italian','fisica delle particelle, bosone di Higgs'),(63,'9788804662479','L\'origine delle specie',560,'Il celebre saggio di Charles Darwin che presenta la teoria dell\'evoluzione e la selezione naturale.','Italian','evoluzione, biologia, selezione naturale'),(64,'9788281691938','Fristende mat',240,'En samling deilige oppskrifter på fristende mat som vil glede både ganen og øynene.','Norwegian','matlaging, oppskrifter, gourmet'),(65,'9788202516702','Norske mattradisjoner',320,'En bok som utforsker norske mattradisjoner og presenterer klassiske oppskrifter fra ulike regioner i landet.','Norwegian','norsk mat, tradisjonsmat, oppskrifter'),(66,'9788282115319','Vegetarisk',192,'En samling smakfulle vegetariske oppskrifter som vil inspirere deg til å utforske det grønne kjøkkenet.','Norwegian','vegetarisk mat, grønnsaker, oppskrifter'),(67,'9788281692102','Bakeglede',224,'En bok som tar deg med inn i bakers verden med oppskrifter på alt fra saftige brød til fristende kaker.','Norwegian','baking, brød, kaker'),(68,'9788282111724','Fisk og skalldyr',288,'Oppdag spennende oppskrifter med fisk og skalldyr som vil gi deg smakfulle retter fra havet.','Norwegian','fisk, skalldyr, oppskrifter'),(69,'9788205518547','Gode grillretter',160,'En bok som gir deg tips, triks og oppskrifter for å mestre kunsten å grille deilige retter utendørs.','Norwegian','grilling, grillmat, oppskrifter'),(70,'9788205544485','Kaker til fest',224,'En samling festlige oppskrifter på kaker som vil imponere gjestene dine ved spesielle anledninger.','Norwegian','kaker, festmat, bakverk'),(71,'9789957087970','Al-Riyadiyat Lil-Saff Al-Awwal Al-Ibtidai',120,'Kitab Yantahee Muhaawadh Al-Riyadiyat Al-Asasiyah Lil-Saff Al-Awwal Al-Ibtidai.','Arabic','Riyadiyat, Saff Awwal, Ta\'leem Asasi'),(72,'9789957088984','Al-Lughah Al-Arabiyyah Lil-Saff Al-Thanii Al-Ibtidai',160,'Kitab Yusharrih Qawaid Wa-Mufradat Al-Lughah Al-Arabiyyah Bi-Shakl Sahl Wa-Mubsat Lil-Saff Al-Thanii Al-Ibtidai.','Arabic','Lughah Arabiyyah, Saff Thanii, Ta\'leem Asasi'),(73,'9789957089059','Ulum Lil-Saff Al-Thalith Al-Ibtidai',200,'Kitab Yantahee Muhaawadh Al-Ulum Al-Asasiyah Lil-Saff Al-Thalith Al-Ibtidai.','Arabic','Ulum, Saff Thalith, Ta\'leem Asasi'),(74,'9789957089608','Al-Riyadiyat Lil-Saff Al-Rabi\'',180,'Kitab Yantahee Muhaawadh Al-Riyadiyat Al-Asasiyah Lil-Saff Al-Rabi\'','Arabic','Riyadiyat, Saff Rabi, Ta\'leem Asasi'),(75,'9789957089981','Al-Adab Al-Arabiyyah Lil-Saff Al-Khamis Al-Ibtidai',150,'Kitab Yusharrih Muhaawadh Al-Adab Al-Arabiyyah Lil-Saff Al-Khamis Al-Ibtidai.','Arabic','Adab Arabiyyah, Saff Khamis, Ta\'leem Asasi'),(76,'9789957089530','Al-Tarikh Lil-Saff Al-Rabi\'',180,'Kitab Yusharrih Muhaawadh Al-Tarikh Lil-Saff Al-Rabi\'','Arabic','Tarikh, Saff Rabi, Ta\'leem Asasi'),(77,'9789957089639','Al-Fiqh Al-Islami Lil-Saff Al-Sadis Al-Ibtidai',200,'Kitab Yusharrih Muhaawadh Al-Fiqh Al-Islami Lil-Saff Al-Sadis Al-Ibtidai.','Arabic','Fiqh Islami, Saff Sadis, Ta\'leem Asasi'),(78,'9789957089202','Al-Manahij Al-Bahthiyyah Lil-Saff Al-Thamin Al-Ibtidai',160,'Kitab Yusharrih Muhaawadh Al-Manahij Al-Bahthiyyah Lil-Saff Al-Thamin Al-Ibtidai.','Arabic','Manahij Bahthiyyah, Saff Thamin, Ta\'leem Asasi'),(79,'9788417033021','Anatomía con orientación clínica',1200,'Libro de anatomía con enfoque clínico para estudiantes de medicina.','Spanish','Anatomía, Orientación clínica, Medicina'),(80,'9788490229872','Fisiología Médica',800,'Manual de fisiología médica que abarca los principales sistemas del cuerpo humano.','Spanish','Fisiología, Medicina'),(81,'9788491130434','Farmacología básica y clínica',1000,'Libro de farmacología que cubre los conceptos básicos y aplicaciones clínicas de los fármacos.','Spanish','Farmacología, Medicina'),(82,'9788491130410','Microbiología médica',600,'Texto de microbiología médica que aborda los microorganismos patógenos y sus mecanismos de infección.','Spanish','Microbiología, Medicina'),(83,'9788491130182','Bioquímica médica',500,'Manual de bioquímica médica que explora los fundamentos moleculares de la vida y su relación con la salud humana.','Spanish','Bioquímica, Medicina'),(84,'9788445815155','Histología básica',400,'Libro de histología que presenta los tejidos y células del cuerpo humano de manera detallada.','Spanish','Histología, Medicina'),(85,'9788498353600','Neuroanatomía clínica',700,'Texto de neuroanatomía con enfoque clínico que analiza la estructura y función del sistema nervioso.','Spanish','Neuroanatomía, Medicina'),(86,'9788491130458','Genética médica',550,'Manual de genética médica que aborda los principios genéticos y su aplicación en el diagnóstico y tratamiento de enfermedades.','Spanish','Genética, Medicina'),(87,'9788491130199','Inmunología básica y clínica',800,'Libro de inmunología que explora los conceptos básicos del sistema inmunológico y su aplicación clínica.','Spanish','Inmunología, Medicina'),(88,'9788416004093','Bioestadística: Base para el análisis de las ciencias de la salud',450,'Texto de bioestadística que proporciona herramientas para el análisis de datos en las ciencias de la salud.','Spanish','Bioestadística, Medicina'),(89,'9788448608832','Embriología clínica',400,'Libro de embriología con enfoque clínico que examina el desarrollo embrionario y su relevancia en la medicina.','Spanish','Embriología, Medicina'),(90,'9788490228288','Endocrinología clínica',700,'Manual de endocrinología que cubre los trastornos hormonales y su diagnóstico y tratamiento.','Spanish','Endocrinología, Medicina'),(91,'9789500695742','Manual de Diagnóstico Diferencial',800,'Guía práctica para el diagnóstico diferencial de enfermedades comunes en medicina.','Spanish','Diagnóstico diferencial, Medicina'),(92,'9788416004116','Farmacología Humana',600,'Libro de farmacología que aborda los mecanismos de acción y efectos de los fármacos en el cuerpo humano.','Spanish','Farmacología, Medicina'),(93,'9788416004017','Radiología Básica',500,'Introducción a la radiología con énfasis en la interpretación de imágenes médicas.','Spanish','Radiología, Medicina'),(94,'9788498354010','Ginecología y Obstetricia',900,'Manual de ginecología y obstetricia que cubre los aspectos médicos y quirúrgicos relacionados con la salud de la mujer.','Spanish','Ginecología, Obstetricia, Medicina'),(95,'9788491131578','Medicina Interna',1500,'Compendio de medicina interna que abarca diversas enfermedades y su manejo clínico.','Spanish','Medicina interna, Enfermedades, Medicina'),(96,'9788445821828','Dermatología',700,'Texto de dermatología que presenta las enfermedades de la piel y su diagnóstico y tratamiento.','Spanish','Dermatología, Enfermedades de la piel, Medicina'),(97,'9788445814875','Neumología',600,'Manual de neumología que aborda las enfermedades respiratorias y su diagnóstico y manejo.','Spanish','Neumología, Enfermedades respiratorias, Medicina'),(98,'9788491130472','Pediatría',1000,'Libro de pediatría que cubre el cuidado y tratamiento de los niños desde el nacimiento hasta la adolescencia.','Spanish','Pediatría, Medicina'),(99,'9788498353020','Psiquiatría',800,'Manual de psiquiatría que aborda los trastornos mentales y su diagnóstico y tratamiento.','Spanish','Psiquiatría, Trastornos mentales, Medicina'),(100,'9788415684311','Cirugía: Bases del Conocimiento Quirúrgico',1200,'Libro de cirugía que cubre los principios y técnicas quirúrgicas en diversas especialidades.','Spanish','Cirugía, Medicina'),(101,'‎978142310148','Percy Jackson',589,'','English','greek mythology');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `author_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  UNIQUE KEY `author_id` (`author_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `book_author_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_author_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES (1,7),(1,10),(1,19),(1,33),(1,49),(1,63),(1,84),(1,89),(2,17),(2,40),(2,42),(2,70),(2,82),(3,6),(3,9),(3,18),(3,25),(3,28),(4,6),(4,14),(4,45),(4,92),(5,8),(5,28),(5,30),(5,37),(5,64),(5,67),(5,75),(5,87),(6,24),(6,25),(6,27),(6,36),(6,46),(6,59),(6,60),(6,73),(7,19),(7,28),(7,32),(7,44),(7,56),(7,69),(7,84),(7,98),(8,41),(8,48),(8,96),(9,4),(9,64),(9,79),(9,88),(10,1),(10,16),(10,19),(10,31),(10,32),(10,64),(10,72),(10,91),(11,8),(11,9),(11,15),(11,24),(11,34),(11,35),(11,41),(11,53),(11,89),(11,92),(12,2),(12,16),(12,64),(12,68),(12,72),(12,73),(12,78),(12,90),(12,91),(13,25),(13,53),(13,71),(14,76),(14,78),(15,13),(15,36),(15,45),(15,50),(15,51),(15,58),(15,95),(16,1),(16,17),(16,20),(16,22),(16,41),(16,54),(16,72),(16,81),(17,23),(17,60),(17,81),(17,87),(18,47),(18,97),(19,28),(19,45),(19,59),(19,69),(19,82),(19,87),(20,3),(20,6),(20,9),(20,30),(20,55),(20,63),(20,68),(20,85),(21,2),(21,58),(21,69),(21,93),(21,94),(21,100),(22,11),(22,29),(22,37),(22,52),(22,80),(22,83),(22,89),(23,2),(23,12),(23,18),(23,55),(23,65),(23,88),(24,5),(24,54),(24,76),(24,94),(25,16),(25,40),(25,70),(25,74),(25,76),(26,26),(26,57),(26,61),(26,77),(26,78),(26,82),(27,61),(28,8),(28,24),(28,75),(28,88),(28,89),(29,9),(29,20),(29,48),(29,56),(30,35),(30,92),(31,17),(31,18),(31,39),(31,42),(31,49),(31,57),(31,78),(31,99),(32,4),(32,15),(32,16),(32,23),(32,49),(32,60),(32,74),(32,79),(32,84),(33,15),(33,20),(33,24),(33,35),(33,43),(33,47),(33,62),(33,77),(33,93),(33,96),(34,10),(34,101);
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_category`
--

DROP TABLE IF EXISTS `book_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_category` (
  `category_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  UNIQUE KEY `category_id` (`category_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `book_category_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_category_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_category`
--

LOCK TABLES `book_category` WRITE;
/*!40000 ALTER TABLE `book_category` DISABLE KEYS */;
INSERT INTO `book_category` VALUES (1,2),(1,17),(1,18),(1,27),(1,35),(1,37),(1,90),(1,93),(1,99),(1,101),(2,1),(2,2),(2,6),(2,9),(2,15),(2,19),(2,26),(2,36),(2,37),(2,45),(2,57),(2,75),(2,85),(2,87),(2,95),(2,98),(3,2),(3,4),(3,7),(3,17),(3,20),(3,29),(3,39),(3,54),(3,55),(3,57),(3,59),(3,60),(3,61),(3,64),(3,68),(3,69),(3,76),(3,83),(3,88),(3,91),(3,94),(4,3),(4,6),(4,15),(4,18),(4,20),(4,24),(4,35),(4,55),(4,58),(4,60),(4,63),(4,72),(4,76),(4,79),(4,84),(4,89),(5,6),(5,9),(5,16),(5,19),(5,32),(5,41),(5,44),(5,45),(5,69),(5,71),(5,75),(5,78),(5,82),(5,94),(5,96),(5,97),(5,100),(5,101),(6,5),(6,19),(6,20),(6,33),(6,34),(6,64),(6,73),(6,74),(6,96),(7,8),(7,13),(7,16),(7,25),(7,28),(7,30),(7,46),(7,48),(7,56),(7,77),(7,89),(8,11),(8,20),(8,22),(8,31),(8,45),(8,49),(8,51),(8,52),(8,59),(8,62),(8,64),(8,69),(8,72),(8,78),(8,81),(8,84),(8,88),(9,15),(9,23),(9,49),(9,65),(9,68),(9,70),(9,74),(9,77),(9,88),(9,89),(10,12),(10,17),(10,25),(10,28),(10,35),(10,41),(10,47),(10,56),(10,58),(10,78),(10,80),(10,81),(10,82),(10,93),(11,4),(11,8),(11,24),(11,32),(11,40),(11,41),(11,42),(11,53),(11,60),(11,64),(11,70),(11,73),(11,78),(11,92),(12,1),(12,9),(12,14),(12,16),(12,25),(12,47),(12,49),(12,50),(12,61),(12,67),(12,72),(12,82),(12,87),(12,89),(13,9),(13,10),(13,16),(13,23),(13,24),(13,28),(13,42),(13,43),(13,48),(13,54),(13,63),(13,92),(15,10),(15,101);
/*!40000 ALTER TABLE `book_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `book_info`
--

DROP TABLE IF EXISTS `book_info`;
/*!50001 DROP VIEW IF EXISTS `book_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `book_info` AS SELECT 
 1 AS `book_id`,
 1 AS `title`,
 1 AS `ISBN`,
 1 AS `auth`,
 1 AS `cat`,
 1 AS `publisher_name`,
 1 AS `page_number`,
 1 AS `summary`,
 1 AS `lang`,
 1 AS `image_path`,
 1 AS `key_words`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `book_publisher`
--

DROP TABLE IF EXISTS `book_publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_publisher` (
  `publisher_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  UNIQUE KEY `publisher_id` (`publisher_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `book_publisher_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_publisher_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_publisher`
--

LOCK TABLES `book_publisher` WRITE;
/*!40000 ALTER TABLE `book_publisher` DISABLE KEYS */;
INSERT INTO `book_publisher` VALUES (1,20),(1,22),(1,38),(1,45),(1,65),(1,82),(1,86),(1,94),(2,3),(2,5),(2,9),(2,31),(2,37),(2,46),(2,56),(2,60),(2,61),(2,66),(2,68),(2,69),(2,70),(2,74),(3,7),(3,11),(3,13),(3,18),(3,26),(3,32),(3,34),(3,40),(3,50),(3,58),(3,77),(3,84),(3,89),(3,97),(3,98),(4,4),(4,12),(4,14),(4,15),(4,21),(4,28),(4,29),(4,39),(4,49),(4,53),(4,79),(4,87),(4,88),(4,95),(4,100),(5,8),(5,17),(5,19),(5,48),(5,54),(5,55),(5,59),(5,63),(5,71),(5,78),(5,83),(5,85),(5,91),(5,92),(5,93),(5,96),(6,10),(6,24),(6,35),(6,41),(6,42),(6,43),(6,51),(6,62),(7,2),(7,16),(7,25),(7,27),(7,33),(7,47),(7,52),(7,57),(7,67),(7,73),(7,75),(7,80),(7,99),(8,1),(8,6),(8,23),(8,30),(8,36),(8,44),(8,64),(8,72),(8,76),(8,81),(8,90),(9,101);
/*!40000 ALTER TABLE `book_publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_log`
--

DROP TABLE IF EXISTS `borrow_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_log` (
  `user_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `borrow_date` date NOT NULL,
  KEY `book_id` (`book_id`),
  KEY `borrow_log_idx` (`user_id`),
  CONSTRAINT `borrow_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `lib_user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `borrow_log_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_log`
--

LOCK TABLES `borrow_log` WRITE;
/*!40000 ALTER TABLE `borrow_log` DISABLE KEYS */;
INSERT INTO `borrow_log` VALUES (1,1,'2023-01-01'),(2,30,'2023-01-03'),(43,2,'2023-01-05'),(14,58,'2023-02-10'),(10,54,'2023-02-15'),(15,67,'2023-03-03'),(2,70,'2023-03-07'),(23,8,'2023-03-10'),(41,91,'2023-04-02'),(35,10,'2023-04-15'),(6,11,'2022-01-05'),(17,15,'2022-02-10'),(8,13,'2022-03-15'),(9,20,'2022-04-20'),(10,18,'2022-04-25'),(11,19,'2022-06-30'),(22,44,'2022-07-10'),(23,77,'2022-08-15'),(44,16,'2022-07-20'),(45,12,'2022-10-25'),(16,98,'2021-01-05'),(17,34,'2021-02-10'),(18,3,'2021-03-15'),(19,83,'2021-04-20'),(20,51,'2021-05-25'),(21,24,'2021-06-30'),(22,7,'2021-07-10'),(23,19,'2021-08-15'),(24,61,'2021-09-20'),(5,10,'2021-10-25'),(26,15,'2021-01-05'),(17,62,'2021-02-10'),(28,11,'2022-03-15'),(9,14,'2022-04-20'),(30,73,'2023-05-25'),(31,18,'2020-06-30'),(2,67,'2020-07-10'),(33,16,'2023-08-15'),(14,99,'2020-09-20'),(35,20,'2020-10-25'),(36,61,'2020-01-05'),(37,22,'2022-02-10'),(38,23,'2021-03-15'),(39,24,'2023-04-20'),(40,25,'2023-05-25'),(41,56,'2023-06-30'),(42,27,'2023-07-10'),(43,28,'2021-08-15'),(44,89,'2022-09-20'),(45,30,'2023-10-25'),(12,77,'2023-05-31'),(12,57,'2023-05-31');
/*!40000 ALTER TABLE `borrow_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(15) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (15,'Action'),(6,'Biography'),(11,'Cook'),(5,'Fantasy'),(1,'Fiction'),(7,'History'),(10,'Medical'),(2,'Mystery'),(13,'Programming'),(12,'Religion'),(3,'Romance'),(4,'Sci-Fi'),(8,'Self-help'),(9,'Travel');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `delay_info`
--

DROP TABLE IF EXISTS `delay_info`;
/*!50001 DROP VIEW IF EXISTS `delay_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `delay_info` AS SELECT 
 1 AS `school_id`,
 1 AS `user_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `service_date`,
 1 AS `delay`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `lib_user`
--

DROP TABLE IF EXISTS `lib_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lib_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `school_id` int DEFAULT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `birth_date` date NOT NULL,
  `user_role` varchar(1) NOT NULL,
  `active` tinyint(1) DEFAULT '0',
  `pending` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `school_id` (`school_id`),
  KEY `username_idx` (`username`),
  CONSTRAINT `lib_user_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school_unit` (`school_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lib_user`
--

LOCK TABLES `lib_user` WRITE;
/*!40000 ALTER TABLE `lib_user` DISABLE KEYS */;
INSERT INTO `lib_user` VALUES (1,'user01','p@ssword1',1,'John','Doe','1990-01-01','s',1,0),(2,'user02','p@ssword2',2,'Jane','Doe','1995-05-05','s',1,0),(3,'user03','p@ssword3',1,'Bob','Smith','1985-12-25','l',1,0),(4,'user04','p@ssword4',2,'Sarah','Johnson','1980-10-10','l',1,0),(5,'user05','p@ssword5',3,'Michael','Brown','1999-02-28','s',1,0),(6,'user06','p@ssword6',1,'Emily','Davis','2000-11-11','t',1,0),(7,'user07','p@ssword7',3,'William','Wilson','1975-07-15','l',1,0),(8,'user08','p@ssword8',2,'Sophie','Green','2002-04-20','t',1,0),(9,'user09','p@ssword9',1,'Oliver','Taylor','1988-08-08','s',1,0),(10,'user10','p@ssword10',3,'Isabella','Anderson','2005-09-16','t',1,0),(11,'user11','p@ssword11',2,'Alex','Davis','1993-03-01','s',1,0),(12,'user12','p@ssword12',3,'Mia','Robinson','2001-06-12','s',1,0),(13,'user13','p@ssword13',1,'Daniel','Clark','1997-08-27','t',1,0),(14,'user14','p@ssword14',2,'Natalie','Walker','1987-04-23','s',1,0),(15,'user15','p@ssword15',3,'Andrew','Hall','1982-11-30','s',1,0),(16,'user16','p@ssword16',1,'Grace','Lewis','2003-03-20','s',1,0),(17,'user17','p@ssword17',2,'Ethan','Young','2004-09-11','s',1,0),(18,'user18','p@ssword18',3,'Avery','King','1990-02-18','t',1,0),(19,'user19','p@ssword19',1,'Evelyn','Wright','1980-07-22','s',1,0),(20,'user20','p@ssword20',2,'Lucas','Turner','1991-12-15','s',1,0),(21,'user21','p@ssword21',1,'Liam','Scott','2002-01-05','s',1,0),(22,'user22','p@ssword22',3,'Audrey','Baker','1995-06-27','s',1,0),(23,'user23','p@ssword23',2,'Emma','Adams','1989-08-08','t',1,0),(24,'user24','p@ssword24',3,'Mason','Carter','1994-04-12','t',1,0),(25,'user25','p@ssword25',1,'Noah','Mitchell','1998-05-23','t',1,0),(26,'user26','p@ssword26',2,'Ava','Parker','1986-03-18','s',1,0),(27,'user27','p@ssword27',3,'Caleb','Turner','2003-09-28','s',1,0),(28,'user28','p@ssword28',1,'Sophia','Morris','2001-02-14','s',1,0),(29,'user29','p@ssword29',3,'Jayden','Gray','1996-11-05','t',1,0),(30,'user30','p@ssword30',2,'Chloe','Brooks','2004-07-20','s',1,0),(31,'user31','p@ssword31',1,'David','Bailey','1978-12-31','s',1,0),(32,'user32','p@ssword32',3,'Bella','Rogers','2000-08-10','s',1,0),(33,'user33','p@ssword33',2,'Jackson','James','1984-05-16','s',1,0),(34,'user34','p@ssword34',1,'Madison','Foster','1999-04-01','t',1,0),(35,'user35','p@ssword35',3,'Lucy','Harris','1992-01-22','t',1,0),(36,'user36','p@ssword36',2,'Ethan','Flores','1993-06-08','s',1,0),(37,'user37','p@ssword37',1,'Addison','Peterson','1997-09-18','s',1,0),(38,'user38','p@ssword38',3,'William','Cox','2002-08-28','s',1,0),(39,'user39','p@ssword39',2,'Grace','Ramirez','1990-12-01','s',1,0),(40,'user40','p@ssword40',1,'Daniel','Reed','2002-04-29','s',1,0),(41,'user41','p@ssword41',3,'Avery','Ward','1995-08-03','s',1,0),(42,'user42','p@ssword42',2,'Evelyn','Henry','1989-02-10','t',1,0),(43,'user43','p@ssword43',3,'Isabella','Barnes','1994-06-15','t',1,0),(44,'user44','p@ssword44',1,'Oliver','Gonzalez','1998-01-19','t',1,0),(45,'user45','p@ssword45',2,'Harper','Coleman','2003-11-30','s',1,0),(46,'user46','p@ssword46',3,'Ethan','West','1996-10-12','s',1,0),(47,'user47','p@ssword47',1,'Aria','Fisher','2001-05-05','s',1,0),(48,'user48','p@ssword48',3,'Mia','Chapman','1993-09-27','s',1,0),(49,'user49','p@ssword49',2,'Alexander','Perez','1985-07-22','s',1,0),(50,'user50','p@ssword50',1,'Sofia','Hernandez','1999-02-16','t',1,0),(51,'user51','p@ssword51',3,'Camila','Diaz','1992-03-28','t',1,0),(52,'user52','p@ssword52',2,'Aiden','Young','1997-12-06','t',1,0),(53,'user53','p@ssword53',1,'Aubrey','Wright','2000-06-18','s',1,0),(54,'user54','p@ssword54',3,'Logan','Nelson','1991-04-14','s',1,0),(55,'user55','p@ssword55',2,'Luna','Lee','2004-09-02','s',1,0),(56,'admin','admin',NULL,'admin','admin','1990-01-01','a',1,0),(57,'danai','danai',3,'Danai','Konstantakou','2002-01-26','t',1,0),(59,'mario','mario',4,'Marios','Kon','1997-07-10','l',1,0),(60,'ajkrit','ajkrit',3,'Antionios','Kritikos','2002-08-28','s',1,0),(61,'katerina','katerina',3,'Katerina','Anagnostidou','2002-05-06','s',0,0),(62,'maria','maria',3,'Maria','Gratzia','2002-07-16','s',0,0),(63,'panagiota','panagiota',3,'Panagiota','Mpreza','2002-10-20','s',1,0);
/*!40000 ALTER TABLE `lib_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `log_info`
--

DROP TABLE IF EXISTS `log_info`;
/*!50001 DROP VIEW IF EXISTS `log_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `log_info` AS SELECT 
 1 AS `user_id`,
 1 AS `ISBN`,
 1 AS `title`,
 1 AS `borrow_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(20) NOT NULL,
  PRIMARY KEY (`publisher_id`),
  UNIQUE KEY `publisher_name` (`publisher_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (9,'‎Disney Hyperion'),(4,'Hachette Livre'),(2,'HarperCollins'),(6,'Kedros'),(5,'Macmillan Publishers'),(8,'Pataki'),(1,'Penguin Random House'),(7,'Psychogios'),(3,'Simon & Schuster');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `rating_info`
--

DROP TABLE IF EXISTS `rating_info`;
/*!50001 DROP VIEW IF EXISTS `rating_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rating_info` AS SELECT 
 1 AS `school_id`,
 1 AS `username`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `user_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `review_text` varchar(200) DEFAULT NULL,
  `rating` tinyint NOT NULL,
  `pending` tinyint(1) NOT NULL,
  UNIQUE KEY `user_id` (`user_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `lib_user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,2,'This book was a page-turner',4,0),(2,5,'One of the best books I\'ve ever read',5,0),(3,8,'Didn\'t live up to the hype',2,0),(4,12,'A good book, but not my favorite',3,0),(5,20,'I couldn\'t put this book down',5,0),(6,25,'The ending left me wanting more',4,0),(7,30,'The writing was beautiful, but the plot was slow',3,0),(8,35,'This book made me cry',5,0),(9,40,'I found this book to be very thought-provoking',4,0),(10,45,'The characters were well-developed',4,0),(11,50,'This book was a bit predictable',3,0),(12,15,'A great coming-of-age story',4,0),(13,18,'The twists and turns kept me on the edge of my seat',5,0),(14,23,'I wasn\'t a fan of the writing style',2,0),(15,27,'This book was an emotional rollercoaster',5,0),(16,33,'I would recommend this book to anyone',5,0),(17,39,'The world-building was fantastic',4,0),(18,42,'This book fell short of my expectations',3,0),(19,46,'I couldn\'t connect with the main character',2,0),(20,49,'This book was a bit slow-paced',3,0),(1,60,'This book was incredibly informative and well-written. Highly recommended!',5,0),(22,73,'I couldn\'t put this book down. The story was captivating from start to finish.',4,0),(43,92,'A must-read for anyone interested in the subject. The author provides great insights.',4,0),(14,59,'This cookbook has amazing recipes that are easy to follow. I\'ve already tried several!',5,0),(10,84,'The characters in this novel are well-developed, and the plot keeps you guessing.',4,0),(35,69,'A comprehensive guide to programming. The examples are clear and practical.',5,0),(20,76,'This textbook covers all the necessary topics and is a valuable resource for students.',4,0),(3,81,'I found this self-help book to be motivating and inspiring. It offers great advice.',4,0),(4,98,'An excellent reference book for photographers. It covers both theory and techniques.',5,0),(5,99,'This children\'s book is beautifully illustrated and has a heartwarming story.',5,0),(57,29,'Interesting plot twist',5,0),(63,6,'Very informing',4,1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `review_app`
--

DROP TABLE IF EXISTS `review_app`;
/*!50001 DROP VIEW IF EXISTS `review_app`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `review_app` AS SELECT 
 1 AS `school_id`,
 1 AS `user_id`,
 1 AS `username`,
 1 AS `user_role`,
 1 AS `title`,
 1 AS `rating`,
 1 AS `review_text`,
 1 AS `book_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `review_info`
--

DROP TABLE IF EXISTS `review_info`;
/*!50001 DROP VIEW IF EXISTS `review_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `review_info` AS SELECT 
 1 AS `book_id`,
 1 AS `username`,
 1 AS `name`,
 1 AS `rating`,
 1 AS `review_text`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `school_book_info`
--

DROP TABLE IF EXISTS `school_book_info`;
/*!50001 DROP VIEW IF EXISTS `school_book_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `school_book_info` AS SELECT 
 1 AS `school_id`,
 1 AS `book_id`,
 1 AS `title`,
 1 AS `ISBN`,
 1 AS `auth`,
 1 AS `cat`,
 1 AS `publisher_name`,
 1 AS `page_number`,
 1 AS `summary`,
 1 AS `lang`,
 1 AS `image_path`,
 1 AS `key_words`,
 1 AS `copies`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `school_unit`
--

DROP TABLE IF EXISTS `school_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_unit` (
  `school_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `address` varchar(20) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `principal` varchar(20) NOT NULL,
  `lib_manager` varchar(20) NOT NULL,
  PRIMARY KEY (`school_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `school_unit_chk_1` CHECK ((`email` like _utf8mb4'%_@_%._%'))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_unit`
--

LOCK TABLES `school_unit` WRITE;
/*!40000 ALTER TABLE `school_unit` DISABLE KEYS */;
INSERT INTO `school_unit` VALUES (1,'High School','New York','123 Main St','2101234567','highschool@school.edu','David Johnson','Dick Brown'),(2,'Middle School','Los Angeles','456 Oak St','2102345678','middleschool@school.edu','Felicity Smith','Bruce Lee'),(3,'Primary School','Philadelphia','789 St Paddy\'s St','2103456789','primaryschool@school.edu','Ronald McDonald','Charlie Kelly'),(4,'Maliaras','Alimos','Pythagora 8','2109388274','mal@gmali.com','Sfiris Nikos','Marios Kon');
/*!40000 ALTER TABLE `school_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `user_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `service_type` varchar(1) NOT NULL,
  `waiting` tinyint(1) DEFAULT '0',
  `service_date` date NOT NULL DEFAULT (curdate()),
  UNIQUE KEY `user_id` (`user_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `lib_user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `service_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (10,3,'b',0,'2023-06-01'),(25,18,'b',0,'2023-05-30'),(36,34,'b',0,'2023-05-29'),(47,9,'r',0,'2023-05-27'),(20,39,'r',0,'2023-06-01'),(50,49,'b',0,'2023-05-31'),(5,19,'b',0,'2023-05-26'),(15,20,'r',0,'2023-05-31'),(41,60,'r',0,'2023-06-01'),(48,31,'b',0,'2023-05-27'),(54,14,'b',1,'2023-05-21'),(20,1,'r',0,'2023-05-29'),(49,23,'r',0,'2023-05-26'),(42,48,'b',1,'2023-05-22'),(55,72,'b',0,'2023-06-01'),(45,89,'r',0,'2023-05-30'),(2,100,'b',1,'2023-05-22'),(34,8,'r',0,'2023-05-28'),(13,60,'b',1,'2023-05-24'),(44,99,'r',0,'2023-05-27'),(28,55,'b',0,'2023-06-01'),(22,95,'b',0,'2023-06-01');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`danai`@`localhost`*/ /*!50003 TRIGGER `ins_service` BEFORE INSERT ON `service` FOR EACH ROW BEGIN
    IF (SELECT COUNT(*)
    FROM service
    WHERE service_type = 'b' AND waiting = 1 AND user_id = NEW.user_id) >= 1 THEN
        UPDATE dummy SET foo = 0 WHERE fun = 1; -- dummy statement that causes trigger to fail
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`danai`@`localhost`*/ /*!50003 TRIGGER `upd_service` BEFORE UPDATE ON `service` FOR EACH ROW BEGIN
    IF (SELECT COUNT(*)
    FROM service
    WHERE service_type = 'b' AND waiting = 1 AND user_id = NEW.user_id) >= 1 THEN
        UPDATE dummy SET foo = 0 WHERE fun = 1; -- dummy statement that causes trigger to fail
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `service_info`
--

DROP TABLE IF EXISTS `service_info`;
/*!50001 DROP VIEW IF EXISTS `service_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `service_info` AS SELECT 
 1 AS `book_id`,
 1 AS `school_id`,
 1 AS `user_id`,
 1 AS `username`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `user_role`,
 1 AS `title`,
 1 AS `ISBN`,
 1 AS `service_date`,
 1 AS `copies`,
 1 AS `service_type`,
 1 AS `waiting`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tot_loans`
--

DROP TABLE IF EXISTS `tot_loans`;
/*!50001 DROP VIEW IF EXISTS `tot_loans`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_loans` AS SELECT 
 1 AS `school_name`,
 1 AS `no_loans`,
 1 AS `b_month`,
 1 AS `b_year`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tot_loans_year`
--

DROP TABLE IF EXISTS `tot_loans_year`;
/*!50001 DROP VIEW IF EXISTS `tot_loans_year`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tot_loans_year` AS SELECT 
 1 AS `school_id`,
 1 AS `school_name`,
 1 AS `no_loans`,
 1 AS `b_year`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!50001 DROP VIEW IF EXISTS `user_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_info` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `user_role`,
 1 AS `name`,
 1 AS `birth_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `author_books`
--

/*!50001 DROP VIEW IF EXISTS `author_books`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `author_books` AS select `author`.`author_id` AS `author_id`,concat(`author`.`author_first_name`,' ',`author`.`author_last_name`) AS `author`,count(`book_author`.`book_id`) AS `total_books` from (`author` left join `book_author` on((`author`.`author_id` = `book_author`.`author_id`))) group by `author`.`author_id`,`author`.`author_first_name`,`author`.`author_last_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `book_info`
--

/*!50001 DROP VIEW IF EXISTS `book_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `book_info` AS select `b`.`book_id` AS `book_id`,`b`.`title` AS `title`,`b`.`ISBN` AS `ISBN`,`book_auth`.`auth` AS `auth`,`book_cat`.`cat` AS `cat`,`book_pub`.`publisher_name` AS `publisher_name`,`b`.`page_number` AS `page_number`,`b`.`summary` AS `summary`,`b`.`lang` AS `lang`,`b`.`image_path` AS `image_path`,`b`.`key_words` AS `key_words` from (((`book` `b` join (select `ba`.`book_id` AS `book_id`,group_concat(`a`.`author_first_name`,' ',`a`.`author_last_name` separator ',') AS `auth` from (`book_author` `ba` join `author` `a` on((`a`.`author_id` = `ba`.`author_id`))) group by `ba`.`book_id`) `book_auth` on((`b`.`book_id` = `book_auth`.`book_id`))) join (select `bc`.`book_id` AS `book_id`,group_concat(`c`.`category_name` separator ',') AS `cat` from (`book_category` `bc` join `category` `c` on((`c`.`category_id` = `bc`.`category_id`))) group by `bc`.`book_id`) `book_cat` on((`b`.`book_id` = `book_cat`.`book_id`))) join (select `bp`.`book_id` AS `book_id`,`p`.`publisher_name` AS `publisher_name` from (`book_publisher` `bp` join `publisher` `p` on((`p`.`publisher_id` = `bp`.`publisher_id`)))) `book_pub` on((`b`.`book_id` = `book_pub`.`book_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `delay_info`
--

/*!50001 DROP VIEW IF EXISTS `delay_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `delay_info` AS select `u`.`school_id` AS `school_id`,`u`.`user_id` AS `user_id`,`u`.`first_name` AS `first_name`,`u`.`last_name` AS `last_name`,`s`.`service_date` AS `service_date`,((to_days(curdate()) - to_days(`s`.`service_date`)) - 7) AS `delay` from (`lib_user` `u` join `service` `s` on((`s`.`user_id` = `u`.`user_id`))) where (`s`.`service_type` = 'b') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `log_info`
--

/*!50001 DROP VIEW IF EXISTS `log_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `log_info` AS select `u`.`user_id` AS `user_id`,`b`.`ISBN` AS `ISBN`,`b`.`title` AS `title`,`bl`.`borrow_date` AS `borrow_date` from ((`lib_user` `u` join `borrow_log` `bl` on((`bl`.`user_id` = `u`.`user_id`))) join `book` `b` on((`b`.`book_id` = `bl`.`book_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rating_info`
--

/*!50001 DROP VIEW IF EXISTS `rating_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rating_info` AS select `u`.`school_id` AS `school_id`,`u`.`username` AS `username`,`c`.`category_id` AS `category_id`,`c`.`category_name` AS `category_name`,`r`.`rating` AS `rating` from ((((`lib_user` `u` join `review` `r` on((`r`.`user_id` = `u`.`user_id`))) join `book` `b` on((`b`.`book_id` = `r`.`book_id`))) join `book_category` `bc` on((`bc`.`book_id` = `b`.`book_id`))) join `category` `c` on((`c`.`category_id` = `bc`.`category_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `review_app`
--

/*!50001 DROP VIEW IF EXISTS `review_app`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `review_app` AS select `u`.`school_id` AS `school_id`,`u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`user_role` AS `user_role`,`b`.`title` AS `title`,`r`.`rating` AS `rating`,`r`.`review_text` AS `review_text`,`b`.`book_id` AS `book_id` from ((`review` `r` join `lib_user` `u` on((`u`.`user_id` = `r`.`user_id`))) join `book` `b` on((`b`.`book_id` = `r`.`book_id`))) where (`r`.`pending` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `review_info`
--

/*!50001 DROP VIEW IF EXISTS `review_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `review_info` AS select `b`.`book_id` AS `book_id`,`u`.`username` AS `username`,`sch`.`name` AS `name`,`r`.`rating` AS `rating`,`r`.`review_text` AS `review_text` from (((`lib_user` `u` join `school_unit` `sch` on((`sch`.`school_id` = `u`.`school_id`))) join `review` `r` on((`r`.`user_id` = `u`.`user_id`))) join `book` `b` on((`b`.`book_id` = `r`.`book_id`))) where (`r`.`pending` = 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `school_book_info`
--

/*!50001 DROP VIEW IF EXISTS `school_book_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `school_book_info` AS select `a`.`school_id` AS `school_id`,`bi`.`book_id` AS `book_id`,`bi`.`title` AS `title`,`bi`.`ISBN` AS `ISBN`,`bi`.`auth` AS `auth`,`bi`.`cat` AS `cat`,`bi`.`publisher_name` AS `publisher_name`,`bi`.`page_number` AS `page_number`,`bi`.`summary` AS `summary`,`bi`.`lang` AS `lang`,`bi`.`image_path` AS `image_path`,`bi`.`key_words` AS `key_words`,`a`.`copies` AS `copies` from (`book_info` `bi` join `availability` `a` on((`a`.`book_id` = `bi`.`book_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `service_info`
--

/*!50001 DROP VIEW IF EXISTS `service_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `service_info` AS select `b`.`book_id` AS `book_id`,`u`.`school_id` AS `school_id`,`u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`first_name` AS `first_name`,`u`.`last_name` AS `last_name`,`u`.`user_role` AS `user_role`,`b`.`title` AS `title`,`b`.`ISBN` AS `ISBN`,`s`.`service_date` AS `service_date`,`a`.`copies` AS `copies`,`s`.`service_type` AS `service_type`,`s`.`waiting` AS `waiting` from (((`lib_user` `u` join `service` `s` on((`s`.`user_id` = `u`.`user_id`))) join `book` `b` on((`b`.`book_id` = `s`.`book_id`))) join `availability` `a` on(((`a`.`book_id` = `b`.`book_id`) and (`a`.`school_id` = `u`.`school_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tot_loans`
--

/*!50001 DROP VIEW IF EXISTS `tot_loans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_loans` (`school_name`,`no_loans`,`b_month`,`b_year`) AS select `sch`.`name` AS `School Name`,count(`b`.`user_id`) AS `Number of Loans`,month(`b`.`borrow_date`) AS `Month`,year(`b`.`borrow_date`) AS `Year` from ((`school_unit` `sch` join `lib_user` `u` on((`u`.`school_id` = `sch`.`school_id`))) join `borrow_log` `b` on((`b`.`user_id` = `u`.`user_id`))) group by month(`b`.`borrow_date`),year(`b`.`borrow_date`),`sch`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tot_loans_year`
--

/*!50001 DROP VIEW IF EXISTS `tot_loans_year`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tot_loans_year` (`school_id`,`school_name`,`no_loans`,`b_year`) AS select `sch`.`school_id` AS `school_id`,`sch`.`name` AS `School Name`,count(0) AS `Number of Loans`,year(`b`.`borrow_date`) AS `Year` from ((`school_unit` `sch` join `lib_user` `u` on((`u`.`school_id` = `sch`.`school_id`))) join `borrow_log` `b` on((`b`.`user_id` = `u`.`user_id`))) group by `sch`.`school_id`,year(`b`.`borrow_date`),`sch`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_info`
--

/*!50001 DROP VIEW IF EXISTS `user_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`danai`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_info` AS select `u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`first_name` AS `first_name`,`u`.`last_name` AS `last_name`,`u`.`user_role` AS `user_role`,`sch`.`name` AS `name`,`u`.`birth_date` AS `birth_date` from (`lib_user` `u` join `school_unit` `sch` on((`sch`.`school_id` = `u`.`school_id`))) order by `u`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-01 14:22:33
