--Sql Server 2014 Express Edition
--Batches are separated by 'go'

select @@version as 'sql server version'



-- ************************
-- ************************
-- ************************
-- ТАБЛИЦЫ
-- ************************
-- ************************
-- ************************


-- Таблица, представляющая человека, ищущего работу.
CREATE TABLE person(id INT IDENTITY(1, 1) PRIMARY KEY, position NVARCHAR(30) NOT NULL, education NVARCHAR(30) NOT NULL, salary INT NOT NULL, 
        seniority INT NOT NULL,            
        CHECK(education IN ('no', 'higher', 'secondary', 'secondary special', 'secondary sp.', 'sec. sp.', 'incomplete higher', 'incomplete h.')));
        
                               
-- Таблица, представляющая вакансию.                               
CREATE TABLE vacancy(id INT IDENTITY(1, 1) PRIMARY KEY, pos NVARCHAR(30) NOT NULL, education NVARCHAR(30) NOT NULL, salary INT NOT NULL,
                     company NVARCHAR(30) NOT NULL, insurance INT NOT NULL, description NVARCHAR(200),
                     CHECK(education IN ('higher', 'secondary', 'secondary special', 'secondary sp.', 'sec. sp.', 'incomplete higher', 
                                             'incomplete h.', 'no') AND insurance IN (0, 1)));
                     
                     
-- Таблица, связывающая вакансии и подходящих для них людей.
CREATE TABLE person_vacancy_bindings(id INT IDENTITY(1, 1) PRIMARY KEY, id_person INT, id_vacancy INT,
                                     FOREIGN KEY (id_person) REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
                                     FOREIGN KEY (id_vacancy) REFERENCES vacancy(id) ON DELETE CASCADE ON UPDATE CASCADE,
                                     UNIQUE (id_person, id_vacancy));
                                     

-- Заполняем таблицу с людьми, ищущими работу.
INSERT INTO person(position, education, salary, seniority) VALUES ('teacher', 'higher', 80, 2);
INSERT INTO person(position, education, salary, seniority) VALUES ('ololo', 'no', 80, 2);
INSERT INTO person(position, education, salary, seniority) VALUES ('teacher', 'secondary', 80, 1);
INSERT INTO person(position, education, salary,seniority) VALUES ('progr', 'secondary', 70, 3);
INSERT INTO person(position, education, salary,seniority) VALUES ('progr', 'secondary', 90, 3);

                                     
-- Заполняем таблицу с вакансиями.                                     
INSERT INTO vacancy(pos, education, salary, company, insurance, description) VALUES ('teacher', 'higher', 80, 'GOOGLE', 1, 'cool');
INSERT INTO vacancy(pos, education, salary, company, insurance) VALUES ('progr', 'secondary', 70, 'lala', 1);
INSERT INTO vacancy(pos, education, salary, company, insurance) VALUES ('progr', 'secondary', 70, 'lol', 0);
INSERT INTO vacancy(pos, education, salary, company, insurance, description) VALUES ('teacher', 'higher', 60, 'lala', 0, 'cool');
INSERT INTO vacancy(pos, education, salary, company, insurance, description) VALUES ('teacher', 'higher', 80, 'lala', 1, 'cool');

INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(1, 1);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(1, 4);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(1, 5);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(2, NULL);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(3, 1);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(3, 4);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(3, 5);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(4, 2);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(4, 3);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(5, 2);
INSERT INTO person_vacancy_bindings(id_person, id_vacancy) VALUES(5, 3);
                                     
                                     
-- ************************
-- ************************
-- ************************
-- ЗАПРОСЫ
-- ************************
-- ************************
-- ************************
                                     
-- 1.    Количество вакансий на каждую специальность.
SELECT pos, COUNT(pos) AS count FROM vacancy GROUP BY pos;

-- 2.    Среднее количество человек (а не заявок!) на одну вакансию.
SELECT cast((SELECT COUNT(id) FROM person) AS float) / (SELECT COUNT(id) FROM vacancy) AS avg_num_of_people_for_vacancy;

-- 3.    Какие компании предлагают вакансии с оплатой медицинской страховки?
SELECT company AS company_with_insurance FROM vacancy WHERE insurance = 1;

-- Собрать статистику в зависимости от образования и трудового стажа.    
SELECT education, seniority, COUNT(seniority) AS job_applicants FROM person GROUP BY education, seniority;



-- ************************
-- ************************
-- ************************
-- ФУНКЦИЯ
-- ************************
-- ************************
-- ************************

-- Вывести все вакансии на определенную должность. Упорядочить по убыванию з/платы.

GO
CREATE FUNCTION VacanciesForPosition(@position NVARCHAR(30)) 
RETURNS @result_table TABLE(education NVARCHAR(30), salary INT, company NVARCHAR(30), insurance INT)
AS
BEGIN
    INSERT INTO @result_table
	SELECT education, salary, company, insurance FROM vacancy WHERE pos = @position GROUP BY education, salary, company, insurance ORDER BY salary DESC;
	RETURN;
END
GO

SELECT * FROM VacanciesForPosition('teacher') ORDER BY salary DESC;


-- ТРИГГЕР ТРИГГЕРНУЛСЯ

-- ************************
-- ************************
-- ************************
-- ТРИГГЕР
-- ************************
-- ************************
-- ************************

-- Работодатель, независимо от агентства, отбирает одного из претендентов, который должен занять вакансию в базе данных агентства, 
-- после этого аннулируются заявки на другие вакансии принятого на работу человека.

SELECT id, id_person, id_vacancy FROM person_vacancy_bindings;

GO
CREATE TRIGGER employedRemoveApplications ON person_vacancy_bindings
FOR DELETE AS
   DELETE FROM person_vacancy_bindings WHERE person_vacancy_bindings.id_person = (SELECT id_person FROM deleted);


SELECT 'OLOLO';

DELETE FROM person_vacancy_bindings WHERE id_person = 3 AND id_vacancy = 5;
    
SELECT id, id_person, id_vacancy FROM person_vacancy_bindings;





-- ************************
-- ************************
-- ************************
-- ПРЕДСТАВЛЕНИЕ
-- ************************
-- ************************
-- ************************        
        
-- Вывести сводку по всем профессиям: количество вакансий и количество предложений. Упорядочить по убыванию количества вакансий. 

GO
CREATE VIEW OccupationalSummary AS
SELECT * FROM (SELECT pos, COUNT(*) AS numberOfTPositionVacancy FROM vacancy group BY pos) "v1"
FULL OUTER JOIN (SELECT position, COUNT(*) AS numberOfPositionPerson FROM person group BY position) "v2" ON "v1".pos = "v2".position;
GO

SELECT * FROM OccupationalSummary ORDER BY (numberOfTPositionVacancy) DESC;
