--Sql Server 2014 Express Edition
--Batches are separated by 'go'

select @@version as 'sql server version'

CREATE TABLE chessman(id INT IDENTITY(1, 1) PRIMARY KEY, type_of VARCHAR(10) NOT NULL, color VARCHAR(15) NOT NULL, 
        CHECK(type_of IN ('king', 'queen', 'rook', 'bishop', 'knight', 'pawn') AND color IN ('black', 'white')));

-- Таблица фигур.

INSERT INTO chessman(type_of, color) VALUES('rook', 'black'); -- 1
INSERT INTO chessman(type_of, color) VALUES('rook', 'black'); -- 2
INSERT INTO chessman(type_of, color) VALUES('rook', 'white'); -- 3
INSERT INTO chessman(type_of, color) VALUES('rook', 'white'); -- 4
INSERT INTO chessman(type_of, color) VALUES('bishop', 'black'); -- bishop - слон
INSERT INTO chessman(type_of, color) VALUES('bishop', 'black'); -- 6
INSERT INTO chessman(type_of, color) VALUES('bishop', 'white'); -- 7
INSERT INTO chessman(type_of, color) VALUES('bishop', 'white'); -- 8

INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- pawn - пешка
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 10
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 11
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 12
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 13
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 14
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 15
INSERT INTO chessman(type_of, color) VALUES('pawn', 'black'); -- 16

INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 17
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 18
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 19
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 20
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 21
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 22
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 23
INSERT INTO chessman(type_of, color) VALUES('pawn', 'white'); -- 24

INSERT INTO chessman(type_of, color) VALUES('king', 'white'); -- 25
INSERT INTO chessman(type_of, color) VALUES('king', 'black'); -- 26

INSERT INTO chessman(type_of, color) VALUES('queen', 'white'); -- 27
INSERT INTO chessman(type_of, color) VALUES('queen', 'black'); -- 28

INSERT INTO chessman(type_of, color) VALUES('knight', 'black'); -- knight - конь
INSERT INTO chessman(type_of, color) VALUES('knight', 'black'); -- 30
INSERT INTO chessman(type_of, color) VALUES('knight', 'white'); -- 31
INSERT INTO chessman(type_of, color) VALUES('knight', 'white'); -- 32


SELECT * FROM chessman;

CREATE TABLE chessboard(id_chessman INT, x INT CHECK(x > 0 AND x < 9), y INT CHECK(y > 0 AND y < 9), FOREIGN KEY (id_chessman) REFERENCES chessman(id) ON DELETE CASCADE ON UPDATE CASCADE, 
        CHECK((x > 0 AND x < 9) AND (y > 0 AND y < 9)), UNIQUE (x, y));
        
CREATE TABLE chessboardAft(id_chessman INT, x INT CHECK(x > 0 AND x < 9), y INT CHECK(y > 0 AND y < 9), FOREIGN KEY (id_chessman) REFERENCES chessman(id) ON DELETE CASCADE ON UPDATE CASCADE, 
        CHECK((x > 0 AND x < 9) AND (y > 0 AND y < 9)), UNIQUE (x, y));
        
-- Таблица фигур, оставшихся на доске после сделанного хода.
INSERT INTO chessboardAft(id_chessman, x, y) VALUES(1, 1, 1);
INSERT INTO chessboardAft(id_chessman, x, y) VALUES(9, 3, 4);

INSERT INTO chessboardAft(id_chessman, x, y) VALUES(17, 2, 1);
INSERT INTO chessboardAft(id_chessman, x, y) VALUES(19, 5, 5);
INSERT INTO chessboardAft(id_chessman, x, y) VALUES(25, 6, 5);


-- Таблица фигур, стоящих на доске.

INSERT INTO chessboard(id_chessman, x, y) VALUES(1, 5, 3); -- ладья
INSERT INTO chessboard(id_chessman, x, y) VALUES(5, 7, 1);
INSERT INTO chessboard(id_chessman, x, y) VALUES(9, 4, 3);

INSERT INTO chessboard(id_chessman, x, y) VALUES(17, 5, 4);
INSERT INTO chessboard(id_chessman, x, y) VALUES(19, 2, 5);
INSERT INTO chessboard(id_chessman, x, y) VALUES(25, 5, 5);

SELECT * FROM chessboard;

-- 1) Сколько фигур стоит на доске? Вывести количество.
SELECT COUNT(*) AS count_figures_on_chessboard FROM chessboard;

-- 2) Вывести id фигур, чьи названия начинаются на букву k. 
SELECT id FROM chessman WHERE type_of LIKE 'k%';

-- 3) Какие типы фигур бывают и по сколько штук? Вывести тип и количество. 
SELECT type_of, COUNT(type_of) AS count FROM chessman GROUP BY type_of;

-- 4) Вывести id белых пешек , стоящих на доске. 
SELECT id FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = 'white' AND type_of = 'pawn';

-- 5) Какие фигуры стоят на главной диагонали? Вывести их тип и цвет.
SELECT type_of, color FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE x = y;

-- 6) Найдите общее количество фигур, оставшихся у каждого игрока. Вывести цвет и количество.
SELECT color, COUNT(color) AS count FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY color;

-- 7) Какие фигуры черных имеются на доске? Вывести тип. 
SELECT type_of FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = 'black';

-- 8) Какие фигуры черных имеются на доске? Вывести тип и количество. 
SELECT type_of, COUNT(type_of) AS count FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = 'black' GROUP BY type_of;

-- 9) Найдите типы фигур (любого цвета), которых осталось, по крайней мере, не меньше двух на доске. 
SELECT type_of FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY type_of HAVING COUNT(type_of) >= 2;

-- 10) Вывести цвет фигур, которых на доске больше. 
SELECT TOP(1) WITH TIES color FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY color ORDER BY COUNT(color);

-- 11) Найдите фигуры, которые стоят на возможном пути движения ладьи (rock) (Любой ладьи любого цвета). (Ладья может двигаться по горизонтали или по вертикали
-- относительно своего положения на доске в любом направлении.). 





-- 12) У каких игроков (цвета) еще остались ВСЕ пешки (pawn)? 
SELECT color FROM chessman INNER JOIN chessboard ON (chessman.id = chessboard.id_chessman AND type_of = 'pawn') GROUP BY color
        HAVING COUNT(color) = 8;
        
-- 13) Пусть отношения board1 и board2 представляют собой два последовательных состояние игры (Chessboard). Какие фигуры (cid) изменили свою 
-- позицию (за один ход это может быть передвигаемая фигура и возможно еще фигура, которая была “съедена”)?
-- В отношение Chessboard2 надо скопировать все строки отношения Chessboard. Из Chessboard2 надо одну фигуру удалить, а другую фигуру 
-- поставить на место удаленной («съесть фигуру»).
-- Задание надо выполнить двумя способами:
-- a) через JOIN
-- b) через UNION/INTERSECT/EXCEPT 

--SELECT 'AAAAAAAAAAAAA';

-- 13) a



        
--SELECT 'AAAAAAAAAAAAA';
        
-- 13) b
-- Скушанные и перемещенные фигуры.
SELECT id_chessman FROM chessboard EXCEPT SELECT id_chessman FROM chessboardAft UNION SELECT chessboard.id_chessman FROM 
        chessboard, chessboardAft WHERE chessboard.id_chessman = chessboardAft.id_chessman AND 
        (chessboard.x != chessboardAft.x OR chessboard.y != chessboardAft.y);
        
-- 14) Вывести id фигуры, если она стоит в «опасной близости» от черного короля? «опасной близостью» будем считать квадрат 5х5 с 
-- королем в центре.
SELECT board2.id_chessman FROM chessman figures, chessboard board1, chessboard board2 WHERE figures.type_of = 'king' AND figures.color = 'black'AND
        board1.id_chessman = figures.id AND board1.id_chessman != board2.id_chessman AND ABS(board2.x - board1.x) <= 2 AND 
        ABS(board2.y - board1.y) <= 2;
 
-- 15) Найти фигуру, ближе всех стоящую к белому королю (расстояние считаем по метрике L1 – разница координат по X + разница координат по Y. 
SELECT TOP(1) WITH TIES board2.id_chessman FROM chessman figures, chessboard board1, chessboard board2 WHERE figures.type_of = 'king' 
        AND figures.color = 'white'AND board1.id_chessman = figures.id AND board1.id_chessman != board2.id_chessman 
        ORDER BY (ABS(board2.x - board1.x) + ABS(board2.y - board1.y)) ASC;

-- 16) Найти фигуры, которые может съесть ладья (Cid ладьи задан). Помните, что «своих» есть нельзя!
SELECT board2.id_chessman FROM chessman figureRook, chessman figuresRest, chessboard board1, chessboard board2 WHERE board1.id_chessman = 1 
        AND figureRook.id = 1 AND board2.id_chessman = figuresRest.id AND figureRook.color != figuresRest.color
        AND board2.id_chessman != 1 AND 
        ((board2.x - board1.x = 0) OR (board2.y - board1.y = 0));


