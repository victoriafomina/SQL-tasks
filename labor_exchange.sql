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
        CHECK(education_lvl IN ('высш.', 'высшее', 'средн.', 'среднее', 'среднее спец.', 'среднее специальное', 'сред. спец.', 'неок. высш.',
                               'неоконченное высш.', 'неоконченное высшее')));
                               
-- Таблица, представляющая вакансию.                               
CREATE TABLE vacancy(id INT IDENTITY(1, 1) PRIMARY KEY, position NVARCHAR(30) NOT NULL, education_lvl NVARCHAR(25) NOT NULL, salary INT NOT NULL,
                     insurance INT NOT NULL, description NVARCHAR(200) NOT NULL, CHECK(education_lvl IN ('высш.', 'высшее', 'средн.', 
                     'среднее', 'среднее спец.', 'среднее специальное', 'сред. спец.', 'неок. высш.', 'неоконченное высш.', 
                     'неоконченное высшее') AND insurance IN(0, 1)));
                     
-- Таблица, связывающая вакансии и подходящих для них людей.
CREATE TABLE person_vacancy_bindings(id INT IDENTITY(1, 1) PRIMARY KEY, id_person INT NOT NULL, id_vacancy INT NOT NULL,
                                     FOREIGN KEY (id_person) REFERENCES person(id) ON DELETE CASCADE ON UPDATE CASCADE,
                                     FOREIGN KEY (id_vacancy) REFERENCES vacancy(id) ON DELETE CASCADE ON UPDATE CASCADE);
                                     
                                     
-- ************************
-- ************************
-- ************************
-- ЗАПРОСЫ
-- ************************
-- ************************
-- ************************
                                     
                                     
                                     
                                     

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



-- ************************
-- ************************
-- ************************
-- ТРИГГЕР
-- ************************
-- ************************
-- ************************