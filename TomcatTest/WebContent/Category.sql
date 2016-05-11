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