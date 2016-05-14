CREATE TABLE CATEGORY(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	des TEXT
);
INSERT INTO CATEGORY (id,name,des) VALUES (1,'jialong','unavailable! !');
SELECT *
From category
DROP TABLE CATEGORY
update category set name='jialong', des='unavailable!' where id=1;
SELECT * from classification,products where products.sku=classification.product
SELECT * FROM CLASSIFICATION
SELECT * FROM products WHERE products.name like '%Intro%'