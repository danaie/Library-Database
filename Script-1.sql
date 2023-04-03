CREATE TABLE school_unit (
  school_id INT PRIMARY KEY,
  name VARCHAR(20),
  city VARCHAR(20),
  adress VARCHAR(20),
  phone_number VARCHAR(10),
  email VARCHAR(20),
  principle VARCHAR(20),
  handler VARCHAR(20)
);


CREATE TABLE lib_user (
  username VARCHAR(15) PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  user_role VARCHAR(1),
  password VARCHAR(10),
  birth_date DATE,
  age INT
);

CREATE TABLE availability (
	copies INT,
	FOREIGN KEY(school_id) REFERENCES school_unit(school_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ISBN) REFERENCES book(ISBN) ON DELETE CASCADE
);

CREATE TABLE service (
	service_type VARCHAR(1),
	service_date DATE,
	FOREIGN KEY(username) REFERENCES lib_user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ISBN) REFERENCES book(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE has_history_table(
	borrow_date DATE,
	FOREIGN KEY(username) REFERENCES lib_user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ISBN) REFERENCES book(ISBN) ON DELETE CASCADE ON UPDATE CASCADE,

);


