CREATE TABLE users (
	user_id TEXT PRIMARY KEY,
	password TEXT NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	age INTEGER NOT NULL CHECK (age > 0),
	role TEXT NOT NULL,
	email TEXT NOT NULL
);

CREATE TABLE products (
	sku TEXT PRIMARY KEY,
	price FLOAT NOT NULL CHECK (price > 0),
	name TEXT NOT NULL UNIQUE
);

CREATE TABLE category (
	name TEXT PRIMARY KEY,
	description TEXT
);

CREATE TABLE classification (
	id SERIAL PRIMARY KEY,
	product TEXT REFERENCES products(sku) NOT NULL,
	category TEXT REFERENCES category(name) NOT NULL
);

CREATE TABLE purchase (
	id SERIAL PRIMARY KEY,
	price FLOAT NOT NULL CHECK(price > 0),
	quantity INTEGER,
	time TEXT NOT NULL,
	buyer TEXT REFERENCES users(user_id) NOT NULL,
	product TEXT REFERENCES products(sku) NOT NULL
);

CREATE TABLE shoppingcart (
	id SERIAL PRIMARY KEY,
	quantity INTEGER,
	price FLOAT NOT NULL CHECK (price > 0),
	buyer TEXT REFERENCES users(user_id),
	product TEXT REFERENCES products(sku)

);

INSERT INTO users (user_id, password, first_name, last_name, age, role, email)  VALUES ('XiejiaNing', 'xjn12345', 'Xiejia', 'Ning', 20, 'customer', 'cool@ucsd.edu');
INSERT INTO products (sku, price, name) VALUES ('coolcool', 100.0, 'Introduction to Web Application');
INSERT INTO category (name, description) VALUES ('Education','Materials, e.g., Book & CD, for educational purpose');
INSERT INTO classification (product, category) VALUES ('coolcool','Education');
INSERT INTO purchase (price, quantity, time, buyer, product) VALUES (100.0, 1,'2:53 May 08 2016', 'XiejiaNing', 'coolcool');