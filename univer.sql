CREATE TABLE faculty (id int PRIMARY KEY,
						name varchar(100),
						price numeric(10, 2)
						);
CREATE TABLE cource (id int PRIMARY KEY,
						number int,
						faculty_id int REFERENCES faculty(id)
						);
CREATE TABLE student (id int PRIMARY KEY,
						name varchar(50),
						surname varchar(50),
						patronymic varchar(50),
						form_of_education varchar(10),
						cource_id int REFERENCES cource(id)
						);
						
INSERT INTO faculty VALUES(1, 'Инженерный', 30000);
INSERT INTO faculty VALUES(2, 'Экономический', 49000);

INSERT INTO cource VALUES(1, 1, 1); -- Инжен 1 курс
INSERT INTO cource VALUES(2, 1, 2); -- Экономич 1 курс
INSERT INTO cource VALUES(3, 4, 2); -- Экономич 4 курс

INSERT INTO student VALUES(1, 'Петр', 'Петров', 'Петрович', 'Бюджет', 1);
INSERT INTO student VALUES(2, 'Иван', 'Иванов', 'Иваныч', 'Частник', 1);
INSERT INTO student VALUES(3, 'Сергей', 'Михно', 'Иваныч', 'Бюджет', 3);
INSERT INTO student VALUES(4, 'Ирина', 'Стоцкая', 'Юрьевна', 'Частник', 3);
INSERT INTO student VALUES(5, 'Настасья', 'Младич', NULL, 'Частник', 2);

SELECT student.*, faculty.name, faculty.price
FROM student
	JOIN cource ON student.cource_id = cource.id
	JOIN faculty ON cource.faculty_id = faculty.id
	WHERE price > 30000 
	AND form_of_education = 'Частник';

UPDATE student SET cource_id = 2
WHERE surname LIKE 'Петров%';

SELECT student.*
FROM student
WHERE surname IS NULL 
	OR patronymic is NULL;

SELECT student.*
FROM student
WHERE name LIKE '%ван%'
	OR patronymic LIKE '%ван%';

DELETE FROM student;
DELETE FROM cource;
DELETE FROM faculty;
