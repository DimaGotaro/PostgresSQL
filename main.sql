CREATE TABLE customers
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30),
LastName CHARACTER VARYING(30),
Email CHARACTER VARYING(30),
Age INTEGER
);
CREATE TABLE customers2
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30),
LastName CHARACTER VARYING(30),
Email CHARACTER VARYING(30),
Age INTEGER
);
DROP TABLE customers2;
CREATE TABLE customers2
(
Id SERIAL,
Name CHARACTER VARYING(30),
TW NUMERIC(9, 2),
Age INTEGER
);
CREATE TABLE customers3
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30),
Super Real,
Age INTEGER
);
CREATE TABLE customers2
(
Id SERIAL,
FirstName CHARACTER VARYING(30),
Super Real,
Age INTEGER,
PRIMARY KEY(Id, Super)
);
CREATE TABLE customers3
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30) UNIQUE,
Super Real,
Age INTEGER
);
CREATE TABLE customers3
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30) NULL,
Super Real,
Age INTEGER
);
CREATE TABLE customers4
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30) NULL,
Super Real,
Age INTEGER DEFAULT 18
);
CREATE TABLE customers5
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30) CHECK(FirstName !=''),
Super Real,
Age INTEGER DEFAULT 18 CHECK(Age > 0 AND Age < 100)
);
CREATE TABLE customers7
(
Id SERIAL PRIMARY KEY,
FirstName CHARACTER VARYING(30),
Super Real,
Age INTEGER DEFAULT 18,
CONSTRAINT chek_age CHECK(Age > 0 AND Age < 100),
CONSTRAINT check_FN CHECK (FirstName !='')
);
CREATE TABLE customers8
(
Id SERIAL PRIMARY KEY,
CustomId INTEGER REFERENCES customers7 (Id),
Quanti INTEGER
);
CREATE TABLE customers9
(
Id SERIAL PRIMARY KEY,
CustomId INTEGER REFERENCES customers7 (Id) ON DELETE CASCADE,
Quanti INTEGER
);
CREATE TABLE customers10
(
Id SERIAL PRIMARY KEY,
CustomId INTEGER REFERENCES customers7 (Id) ON DELETE SET NULL,
Quanti INTEGER
);
CREATE TABLE customers1
(
Id SERIAL PRIMARY KEY,
CustomId INTEGER REFERENCES customers7 (Id) ON DELETE SET DEFAULT,
Quanti INTEGER
);
ALTER TABLE customers1
ADD Phone CHARACTER VARYING(20) NULL;
ALTER TABLE customers1
ADD Adress CHARACTER VARYING(20) NOT NULL DEFAULT 'Неизвестно';
ALTER TABLE customers1
ALTER COLUMN Adress TYPE VARCHAR(50);

ALTER TABLE Customers1
ALTER COLUMN quanti
SET NOT NULL;
ALTER TABLE Customers1
ALTER COLUMN quanti
DROP NOT NULL;
ALTER TABLE customers1
ADD CHECK (quanti > 0);
ALTER TABLE customers1
ADD CONSTRAINT quanti_unique UNIQUE (quanti);
ALTER TABLE customers1
DROP CONSTRAINT quanti_unique;
ALTER TABLE customers1
RENAME COLUMN adress TO City;
ALTER TABLE customers1
RENAME TO customers11;
CREATE TABLE Prod
(
Id SERIAL PRIMARY KEY,
ProductName VARCHAR(30) NOT NULL,
Manufacturer VARCHAR(20) NOT NULL,
ProductCount INTEGER DEFAULT 0,
Price NUMERIC
);
INSERT INTO prod (Manufacturer, Price, ProductName, ProductCount)
VALUES('Samsung', 650, 'Gelaxi 6', 6);
VALUES('Samsung', 250, 'Gelaxi 4s', 10);
INSERT INTO prod (Manufacturer, Price, ProductName, ProductCount)
VALUES ('Apple', 1000, 'iPhone12', 8) RETURNING id;
SELECT * FROM Prod
WHERE ProductCount IS NOT NULL;

UPDATE prod
SET productcount = productcount + 1;
DELETE FROM prod
WHERE price < 500 AND manufacturer = 'Samsung Inc.';
ALTER TABLE prod
ADD IsDisc BOOLEAN;
INSERT INTO prod (IsDisc)
VALUES
(true),
(false),
(false),
(true),
(false),
(true);
CREATE TABLE Prod2
(
Id SERIAL PRIMARY KEY,
Company VARCHAR(30) NOT NULL,
ProductName VARCHAR(30) NOT NULL,
ProductCount INTEGER DEFAULT 0,
Price NUMERIC DEFAULT 0,
IsDisc BOOLEAN
);
INSERT INTO prod2 (Company, ProductName, ProductCount, Price, IsDisc)
VALUES 
('XIAOMI', 'Redmi 3', 5, 250, true),
('XIAOMI', 'POCO X3', 7, 320, false),
('Samsung', 'Galaxu 5', 3, 670, false),
('Samsung', 'Galaxu 4si', 9, 190, true),
('APPLE', 'iPhone 12', 8, 500, true),
('LENOVO', 'Asus 2r', 6, 800, false);
SELECT AVG(price) AS sred_price FROM prod2;
SELECT AVG(price) AS sred_price FROM prod2
WHERE company = 'Samsung';
SELECT AVG(price * productcount) AS sred_price FROM prod2;
SELECT COUNT(DISTINCT company) FROM prod2;
SELECT MIN(price) FROM prod2;
SELECT MAX(price) FROM prod2;
SELECT STRING_AGG(productname, ', ') FROM prod2;
SELECT
COUNT(*),
MIN(price) AS MinPrice,
SUM(productcount) AS SumPR
FROM prod2;
SELECT company, COUNT(*) AS ModL, SUM(productcount)
FROM prod2
GROUP BY CUBE(company, productcount);
CREATE TABLE pokyp (
Id SERIAL PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL
);
CREATE TABLE orders (
Id SERIAL PRIMARY KEY,
ProductId INTEGER NOT NULL REFERENCES prod2(id) ON DELETE CASCADE,
PokypId INTEGER NOT NULL REFERENCES pokyp(id) ON DELETE CASCADE,
CreateAt DATE NOT NULL,
ProdyctCount INTEGER DEFAULT 1,
Price NUMERIC NOT NULL
);
INSERT INTO pokyp(FirstName)
VALUES 
('Tom'),
('Bob'),
('Jons');
INSERT INTO orders(productid, pokypid, createat, prodyctcount, price)
VALUES 
(
  (SELECT Id FROM prod2 WHERE productname = 'Redmi 3'),
  (SELECT Id FROM pokyp WHERE FirstName = 'Tom'),
  '2022-02-01',
  2,
  (SELECT price FROM prod2 WHERE productname = 'Redmi 3')
),
(
  (SELECT Id FROM prod2 WHERE productname = 'Galaxu 5'),
  (SELECT Id FROM pokyp WHERE FirstName = 'Bob'),
  '2022-02-03',
  3,
  (SELECT price FROM prod2 WHERE productname = 'Galaxu 5')
),
(
  (SELECT Id FROM prod2 WHERE productname = 'iPhone 12'),
  (SELECT Id FROM pokyp WHERE FirstName = 'Jons'),
  '2022-02-05',
  4,
  (SELECT price FROM prod2 WHERE productname = 'iPhone 12')
);
SELECT * FROM prod2
WHERE price = (SELECT MIN(price) FROM prod2);
SELECT * FROM prod2
WHERE price > (SELECT AVG(price) FROM prod2);
SELECT createat, price,
(SELECT productname FROM prod2
WHERE orders.pokypid = prod2.id)
FROM orders;
SELECT productname, price, company,
(SELECT AVG(price) FROM prod2 AS Sprod
WHERE Sprod.company = prod2.company)
FROM prod2
WHERE price > 
(SELECT AVG(price) FROM prod2 AS Sprod
WHERE Sprod.company = prod2.company);
CREATE TABLE mass
(
  Id SERIAL PRIMARY KEY,
  Title VARCHAR(30),
  body TEXT,
  massive VARCHAR(10)[]
);
INSERT INTO mass(title, body, massive)
VALUES ('Paaf', 'Jpoef', '{"sql", "postgres", "course"}');
SELECT massive[3] FROM mass;
update mass 
set massive='{}'
where id=1;
update mass
set massive='{"sql", "postgres", "database"}'
where id=1;
update mass
set massive[1]='sql3'
where id=1;
CREATE TYPE perechsl AS ENUM ('bgin', 'approwd', 'finish');
CREATE TABLE ENAM
(
Id SERIAL PRIMARY KEY,
soderj VARCHAR(20),
status perechsl
);
INSERT INTO enam(soderj, status)
VALUES ('jfkdi', 'approwd'),
('544df', 'bgin');
update enam
set status ='finish'
where id=2;
ALTER TYPE perechsl ADD VALUE 'porebric';
CREATE TYPE newperec2 AS ENUM ('finish', 'approwd', 'done');
ALTER TABLE enam ALTER COLUMN status TYPE newperec2
USING status::TEXT::newperec2;
DROP TYPE perechsl;
SELECT * FROM orders, pokyp
WHERE orders.pokypid = pokyp.id;
SELECT P.firstname, D.productname, O.*
FROM pokyp AS P, prod2 AS D, orders AS O
WHERE O.pokypid = P.id AND O.productid = D.id;

SELECT G.createat, G.prodyctcount, F.productname
FROM orders AS G
JOIN prod2 AS F ON F.id = G.productid;
SELECT orders.createat, prod2.productname, pokyp.firstname
FROM orders
JOIN prod2 ON prod2.id = orders.productid AND prod2.company = 'XIAOMI'
JOIN pokyp ON pokyp.id = orders.pokypid
ORDER BY pokyp.firstname;
SELECT createat, price, firstname
FROM orders
JOIN pokyp ON pokyp.id = orders.pokypid;
INSERT INTO orders(productid, pokypid, createat, prodyctcount, price)
VALUES
(
  (SELECT Id FROM prod2 WHERE productname = 'Galaxu 5'),
  (SELECT Id FROM pokyp WHERE FirstName = 'Tom'),
  '2022-02-07',
  1,
  (SELECT price FROM prod2 WHERE productname = 'Galaxu 5')
);
SELECT createat, firstname, company
FROM pokyp
LEFT JOIN orders ON pokyp.id = orders.pokypid
LEFT JOIN prod2 ON prod2.id = orders.productid;
SELECT createat, firstname, company
FROM pokyp
LEFT JOIN orders ON pokyp.id = orders.pokypid
LEFT JOIN prod2 ON prod2.id = orders.productid
WHERE prod2.price > 300
ORDER BY orders.createat;
SELECT firstname, createat, productname FROM orders
JOIN prod2 ON prod2.id = orders.productid
LEFT JOIN pokyp ON pokyp.id = orders.pokypid;
SELECT createat, firstname FROM orders, pokyp;
SELECT pokyp.firstname, COUNT(pokypid), SUM(prod2.price * prod2.productcount) AS sumn
FROM pokyp LEFT JOIN orders
ON pokyp.id = orders.pokypid
LEFT JOIN prod2 ON prod2.id = orders.productid
GROUP BY pokyp.id, pokyp.firstname
ORDER BY sumn;
CREATE TABLE client
(
  Id SERIAL PRIMARY KEY,
  FirstName VARCHAR(20),
  LastName VARCHAR(20),
  Schet NUMERIC DEFAULT 0
);
CREATE TABLE sotr
(
  Id SERIAL PRIMARY KEY,
  FirstName VARCHAR(20),
  LastName VARCHAR(20)
);
INSERT INTO client(FirstName, LastName, Schet)
VALUES
('Tom', 'Naki', 1200),
('Bob', 'Maki', 1800),
('Jon', 'Milkovich', 2000),
('Victor', 'Baya', 2800),
('Mark', 'Adams', 2500),
('Tim', 'Cook', 2800);
INSERT INTO sotr(FirstName, LastName)
VALUES
('Homer', 'Simpson'),
('Tom', 'Naki'),
('Mark', 'Adams'),
('Nick', 'Svensson');
SELECT firstname, lastname FROM client
UNION ALL SELECT firstname, lastname FROM sotr;
SELECT firstname|| ' ' || lastname AsF
FROM client
UNION ALL SELECT firstname|| ' ' || lastname AS AsL
FROM sotr
ORDER BY AsF;
SELECT firstname, lastname, schet + schet * 0.1 Asv
FROM client WHERE schet < 2000
UNION ALL SELECT firstname, lastname, schet + schet * 0.1 Asv 
FROM client WHERE schet >= 2000;
SELECT firstname, lastname
FROM sotr
EXCEPT SELECT firstname, lastname
FROM client;
SELECT firstname, lastname
FROM sotr
INTERSECT SELECT firstname, lastname
FROM client;
-- hfkurnfkj