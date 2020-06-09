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
CREATE TABLE person(id INT IDENTITY(1, 1) PRIMARY KEY, position NVARCHAR(30) NOT NULL, education_lvl NVARCHAR(25) NOT NULL, salary INT NOT NULL, 
        seniority INT NOT NULL,            
        CHECK(education_lvl IN ('no', 'higher', 'secondary', 'secondary special', 'secondary sp.', 'sec. sp.', 'incomplete higher', 'incomplete h.')));
        
                               
-- Таблица, представляющая вакансию.                               
CREATE TABLE vacancy(id INT IDENTITY(1, 1) PRIMARY KEY, position NVARCHAR(30) NOT NULL, education_lvl NVARCHAR(25) NOT NULL, salary INT NOT NULL,
                     company NVARCHAR(30) NOT NULL, insurance INT NOT NULL, description NVARCHAR(200),
                     CHECK(education_lvl IN ('higher', 'secondary', 'secondary special', 'secondary sp.', 'sec. sp.', 'incomplete higher', 
                                             'incomplete h.', 'no') AND insurance IN (0, 1)));
                     
                     
-- Таблица, связывающая вакансии и подходящих для них людей.
CREATE TABLE person_vacancy_bindings(id INT IDENTITY(1, 1) PRIMARY KEY, id_person INT, id_vacancy INT,
                                     FOREIGN KEY (id_person) REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
                                     FOREIGN KEY (id_vacancy) REFERENCES vacancy(id) ON DELETE CASCADE ON UPDATE CASCADE);
                                     

INSERT INTO person(position, education_lvl, salary, seniority) VALUES ('teacher', 'higher', 80000, 2);
INSERT INTO person(position, education_lvl, salary, seniority) VALUES ('ololo', 'no', 80000, 2);
INSERT INTO person(position, education_lvl, salary, seniority) VALUES ('teacher', 'secondary', 80000, 1);
INSERT INTO person(position, education_lvl, salary,seniority) VALUES ('progr', 'secondary', 70000, 3);

                                     
                                     
INSERT INTO vacancy(position, education_lvl, salary, company, insurance, description) VALUES ('teacher', 'higher', 80000, 'GOOGLE', 1, 'cool');
INSERT INTO vacancy(position, education_lvl, salary, company, insurance) VALUES ('progr', 'secondary', 70000, 'osd', 1);
INSERT INTO vacancy(position, education_lvl, salary, company, insurance) VALUES ('progr', 'secondary', 70000, 'lol', 0);
INSERT INTO vacancy(position, education_lvl, salary, company, insurance, description) VALUES ('teacher', 'higher', 60000, 'osd', 0, 'cool');
INSERT INTO vacancy(position, education_lvl, salary, company, insurance, description) VALUES ('teacher', 'higher', 80000, 'osd', 1, 'cool');
                                     
                                     
-- ************************
-- ************************
-- ************************
-- ЗАПРОСЫ
-- ************************
-- ************************
-- ************************
                                     
-- 1.    Количество вакансий на каждую специальность.
SELECT position, COUNT(position) AS count FROM vacancy GROUP BY position;

-- 2.    Среднее количество человек (а не заявок!) на одну вакансию.
SELECT cast((SELECT COUNT(id) FROM person) AS float) / (SELECT COUNT(id) FROM vacancy) AS avg_num_of_people_for_vacancy;

-- 3.    Какие компании предлагают вакансии с оплатой медицинской страховки?
SELECT company AS company_with_insurance FROM vacancy WHERE insurance = 1;

                                     
                                     

-- ************************
-- ************************
-- ************************
-- ПРОЦЕДУРА
-- ************************
-- ************************
-- ************************





-- ************************
-- ************************
-- ************************
-- ФУНКЦИЯ
-- ************************
-- ************************
-- ************************

-- Вывести все вакансии на определенную должность. Упорядочить по убыванию з/платы.


--GO
--CREATE FUNCTION VacanciesForPosition(@position NVARCHAR(30)) 
--RETURNS TABLE

--RETURN(
--        SELECT education_lvl, salary, company, insurance FROM vacancy WHERE position = @position -- ORDER BY salary DESC
--);


-- ************************
-- ************************
-- ************************
-- ТРИГГЕР
-- ************************
-- ************************
-- ************************




-- ************************
-- ************************
-- ************************
-- ПРЕДСТАВЛЕНИЕ
-- ************************
-- ************************
-- ************************        
        
-- Вывести сводку по всем профессиям: количество вакансий и количество предложений. Упорядочить по убыванию количества вакансий. 
SELECT vacancy.position, COUNT(vacancy.position) AS number_of_vacancies, COUNT(person.position) AS job_applicants 
    FROM person, vacancy
    WHERE vacancy.position = person.position GROUP BY vacancy.position ORDER BY vacancy.position DESC; -- ЧТО НЕ ТАК?
    
    
    
    
    
-- ************************
-- ************************
-- ************************
-- СТАТИСТИКА
-- ************************
-- ************************
-- ************************   
    
-- Собрать статистику в зависимости от образования и трудового стажа.