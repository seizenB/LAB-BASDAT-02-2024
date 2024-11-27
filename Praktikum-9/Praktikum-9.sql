-- nomor 1
CREATE DATABASE sepakbola
DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;
CREATE TABLE klub (
	id INT PRIMARY KEY AUTO_INCREMENT, 
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);
CREATE TABLE pemain (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES klub (id)
);
CREATE TABLE pertandingan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub (id),
	id_klub_tamu INT,
	FOREIGN KEY (id_klub_tamu) REFERENCES klub (id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);


CREATE INDEX idx_posisi ON pemain (posisi);
DESCRIBE pemain;

CREATE INDEX idx_kota_asal ON klub (kota_asal);
DESCRIBE klub;



-- nomor 2
SELECT c.customerName, c.country, 
	ROUND(SUM(p.amount),2) TotalPayment,
	COUNT(o.orderNumber) orderCount, 
	MAX(p.paymentDate) LastPaymentDate,
	case
	when SUM(p.amount) > 100000 then 'VIP'
	when SUM(p.amount) > 5000 then 'Loyal'
	ELSE 'New'
	END AS 'Status'
FROM customers c
LEFT JOIN payments p
USING(customernumber)
LEFT JOIN orders o
USING(customernumber)
GROUP BY c.customerNumber
ORDER BY c.customerName;


-- nomor 3
SELECT c.customerNumber, 
	c.customerName,
SUM(od.quantityOrdered) total_quantity,
case
when SUM(od.quantityOrdered) > (
		SELECT AVG(total) 
		FROM ( 
		SELECT SUM(od2.quantityOrdered) AS total
		FROM customers c2
		JOIN orders o2
		USING(customerNumber)
		JOIN orderdetails od2
		USING(ordernumber)
		GROUP BY c2.customerNumber
		) ratarata) then 'di atas rata-rata'
ELSE 'di bawah rata-rata'
END AS 'kategori_pembelian'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(ordernumber)
JOIN products p
USING(productcode)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC;


-- soal tambahan
START TRANSACTION 
-- nomor 1
INSERT INTO authors (`name`, nationality)
VALUES ("Gabriel Garcia Marquez", "Colombian"),
		 ("Haruki Murakami", NULL),
		 ("George Orwell", "British"),
		 ("J.K. Rowling", "British");
SELECT * FROM authors;

-- nomor 2
INSERT INTO books (`Isbn`, Title, author_id, Published_year, 
genre, copies_avaliable)
VALUES (7040289780000, 'Norwegian Wood', 2, 1987, 'Romance', 12),
		 (9780375704000, '1984', 3, 1949, 'Dystopian', 3),
		 (978074753200, "Harry Potter and the Philosopher's Stone", 4, 1997, NULL, 2),
		 (7210301703000, 'The Running Grave', 4, 2016, 'Fiction', 20)
SELECT * FROM books
JOIN authors
ON authors.id = books.author_id
		 
-- nomor 3
INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('Ethan', 'Collins', 'ethan@example.com', NULL, '2024-03-24', ''),
		 ('Sofia', 'Rivera', 'rivera@example.com', 0001231231, '2024-04-05', 'Standar'),
		 ('williams','', 'williams123@example.com', 3213214456, '2023-04-06', 'Premium')
SELECT * FROM members;

-- nomor 4
SELECT * FROM borrowings
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES (1, 1, '2024-07-10', '2024-07-25'),
		 (1, 4, '2024-08-01', NULL),
		 (3, 3, '2024-09-06', '2024-09-09'),
		 (2, 1, '2024-09-08', NULL),
		 (3, 2, '2024-09-10', NULL)

ROLLBACK;
COMMIT;
		 
SET autocommit  = 0;

