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
INSERT INTO chessboard(id_chessman, x, y) VALUES(19, 5, 5);
INSERT INTO chessboard(id_chessman, x, y) VALUES(25, 6, 5);

SELECT * FROM chessboard;

-- ************************
-- ************************
-- ************************
-- ЗДЕСЬ НАЧИНАЮТCЯ ЗАПРОСЫ
-- ************************
-- ************************
-- ************************

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
SELECT type_of, COUNT(type_of) AS count FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman 
        WHERE color = 'black' GROUP BY type_of;

-- 9) Найдите типы фигур (любого цвета), которых осталось, по крайней мере, не меньше двух на доске. 
SELECT type_of FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY type_of HAVING COUNT(type_of) >= 2;

-- 10) Вывести цвет фигур, которых на доске больше. 
SELECT TOP(1) WITH TIES color FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY color ORDER BY COUNT(color);

-- 11) Найдите фигуры, которые стоят на возможном пути движения ладьи (rock) (Любой ладьи любого цвета). (Ладья может двигаться по горизонтали или 
-- по вертикали относительно своего положения на доске в любом направлении.). 

SELECT boardRestFigures.id_chessman FROM chessman figures, chessboard boardRook, chessboard boardRestFigures 
        WHERE figures.id = 1 AND boardRook.id_chessman = 1 AND boardRestFigures.id_chessman != 1 AND 
        ((boardRook.x - boardRestFigures.x = 0) OR (boardRook.y - boardRestFigures.y = 0));

-- 12) У каких игроков (цвета) еще остались ВСЕ пешки (pawn)? 
SELECT color FROM chessman INNER JOIN chessboard ON (chessman.id = chessboard.id_chessman AND type_of = 'pawn') 
        GROUP BY color HAVING COUNT(color) = 8;
        
-- 13) Пусть отношения board1 и board2 представляют собой два последовательных состояние игры (Chessboard). Какие фигуры (cid) изменили свою 
-- позицию (за один ход это может быть передвигаемая фигура и возможно еще фигура, которая была “съедена”)?
-- В отношение Chessboard2 надо скопировать все строки отношения Chessboard. Из Chessboard2 надо одну фигуру удалить, а другую фигуру 
-- поставить на место удаленной («съесть фигуру»).
-- Задание надо выполнить двумя способами:
-- a) через JOIN
-- b) через UNION/INTERSECT/EXCEPT 

-- 13) a
SELECT board1.id_chessman FROM chessboard board1 LEFT 
        JOIN chessboardAft board2 ON board1.id_chessman = board2.id_chessman 
        WHERE board1.x != board2.x OR board1.y != board2.y OR board2.id_chessman is NULL;
        
-- 13) b
-- Скушанные и перемещенные фигуры.
SELECT id_chessman FROM chessboard EXCEPT SELECT id_chessman FROM chessboardAft 
        UNION SELECT chessboard.id_chessman FROM chessboard, chessboardAft 
        WHERE chessboard.id_chessman = chessboardAft.id_chessman AND (chessboard.x != chessboardAft.x OR chessboard.y != chessboardAft.y);
        
-- 14) Вывести id фигуры, если она стоит в «опасной близости» от черного короля? «опасной близостью» будем считать квадрат 5х5 с 
-- королем в центре.
SELECT board2.id_chessman FROM chessman figures, chessboard board1, chessboard board2 
        WHERE figures.type_of = 'king' AND figures.color = 'black'AND
        board1.id_chessman = figures.id AND board1.id_chessman != board2.id_chessman AND ABS(board2.x - board1.x) <= 2 AND 
        ABS(board2.y - board1.y) <= 2;
 
-- 15) Найти фигуру, ближе всех стоящую к белому королю (расстояние считаем по метрике L1 – разница координат по X + разница координат по Y. 
SELECT TOP(1) WITH TIES board2.id_chessman FROM chessman figures, chessboard board1, chessboard board2 
        WHERE figures.type_of = 'king' AND figures.color = 'white'AND board1.id_chessman = figures.id AND 
        board1.id_chessman != board2.id_chessman 
        ORDER BY (ABS(board2.x - board1.x) + ABS(board2.y - board1.y)) ASC;

-- 16) Найти фигуры, которые может съесть ладья (Cid ладьи задан). Помните, что «своих» есть нельзя!
SELECT board2.id_chessman FROM chessman figureRook, chessman figuresRest, chessboard board1, chessboard board2 
        WHERE board1.id_chessman = 1 AND figureRook.id = 1 AND board2.id_chessman = figuresRest.id AND figureRook.color != figuresRest.color
        AND board2.id_chessman != 1 AND ((board2.x - board1.x = 0) OR (board2.y - board1.y = 0));
        


-- ************************
-- ************************
-- ************************
-- ПРОЦЕДУРА
-- ************************
-- ************************
-- ************************

-- Процедура – «сделать ход». Если мы встали на клетку, где стояла фигура другого
-- цвета, то «съесть» ее, если своего, то такой ход делать нельзя.


--GO
--CREATE PROCEDURE MakeMove(@x1 INT, @y1 INT, @x2 INT, @y2 INT) AS
--BEGIN
    -- Проверяем, находится ли кто-то в клетке, из которой собираемся сделать ход.
--    IF (SELECT COUNT(id_chessman) FROM chessboard WHERE chessboard.x = @x1 AND chessboard.y = @y1) > 0
    -- Случай, когда мы хотим встать в клетку, где стоит "наша" фигура.
--        IF (SELECT figures.color FROM chessman figures, chessboard board WHERE figures.id = board.id_chessman AND board.x = @x1 AND 
--                board.y = @y1) = (SELECT figures.color FROM chessman figures, chessboard board WHERE figures.id = board.id_chessman AND 
--                board.x = @x2 AND board.y = @y2)
--            SELECT 'Такой ход невозможен! Вы не можете съесть "свою" фигуру!';
--        ELSE -- Хотим перейти в клетку, где стоит другая фигура - "съедим" ее.
--            DELETE FROM chessboard WHERE x = @x2 AND y = @y2;
--            UPDATE chessboard SET x = @x2, y = @y2 WHERE x = @x1 AND y = @y1;
--            RETURN;
--    ELSE -- В клетке, из которой мы собираемся "пойти", никого нет.
--        SELECT 'Такой ход невозможен! Вы не можете сделать ход из клетки, в которой нет фигуры!';
--END





-- ************************
-- ************************
-- ************************
-- ФУНКЦИЯ
-- ************************
-- ************************
-- ************************

-- Функция-таблица, имеет параметр ID фигуры. В качестве результата выдает
-- фигуры противника, которого может съесть заданная фигура. Т.к. фигур много, и
-- правила “съедания” для каждого типа фигур свои, можно ограничиться одним
-- типом фигур (например, слоны, ладьи и пр.) Про фигуры, которые можем съесть,
-- выводим следующую информацию: ID, тип, Х, У.

-- Задачу будем решать для ладьи.
GO
CREATE FUNCTION FiguresPossibleToEat(@id INT) 
RETURNS TABLE

RETURN(
        SELECT board2.id_chessman, figures.type_of, board2.x, board2.y FROM chessman figures, chessboard board1, chessboard board2 
        WHERE @id = figures.id AND @id = board1.id_chessman AND board1.id_chessman != board2.id_chessman AND 
        ((board1.x - board2.x = 0) OR (board1.y - board2.y = 0))
);





-- ************************
-- ************************
-- ************************
-- ТРИГГЕР
-- ************************
-- ************************
-- ************************

/*
Триггер
Создать файл для записи истории шахматной партии. Структура таблицы:
1) идентификатор хода,
2) время (TIMESTAMP),
3) ID фигуры,
4) новая X координата,
5) новая Y координата.
Для тех фигур, которые были съедены, новые координаты становятся незаданным
значением.
При каждом ходе записывать изменения в таблице истории.
*/



