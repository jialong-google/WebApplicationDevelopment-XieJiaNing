CREATE TABLE users (
	user_id TEXT PRIMARY KEY UNIQUE,
	password TEXT NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	state TEXT NOT NULL;
	age INTEGER NOT NULL CHECK (age > 0),
	role TEXT NOT NULL,
);

CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	des TEXT
);


CREATE TABLE products (
	sku TEXT PRIMARY KEY,
	price FLOAT NOT NULL CHECK (price > 0),
	name TEXT NOT NULL UNIQUE,
	category TEXT REFERENCES categories(name) NOT NULL
);



CREATE TABLE classification (
	id SERIAL PRIMARY KEY,
	product TEXT REFERENCES products(sku) NOT NULL,
	category TEXT REFERENCES categories(name) NOT NULL
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


INSERT INTO categories (name, des) VALUES ('A','init A');
INSERT INTO categories (name, des) VALUES ('B','init B');
INSERT INTO categories (name, des) VALUES ('C','init C');
INSERT INTO categories (name, des) VALUES ('D','init D');
INSERT INTO categories (name, des) VALUES ('E','init E');



DELETE FROM classification WHERE EXISTS"
					+ "SELECT * FROM products  WHERE classification.product=products.sku"
					+ "AND products.name=?