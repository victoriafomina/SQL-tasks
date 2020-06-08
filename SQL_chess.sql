CREATE TABLE chessman(id INT PRIMARY KEY AUTO_INCREMENT, type_of VARCHAR(10) NOT NULL, color VARCHAR(15) NOT NULL, 
CHECK(type_of IN ("king", "queen", "rook", "bishop", "knight", "pawn") AND color IN ("black", "white")));

-- Таблица фигур.

INSERT INTO chessman(type_of, color) VALUES("rook", "black");
INSERT INTO chessman(type_of, color) VALUES("rook", "black");
INSERT INTO chessman(type_of, color) VALUES("rook", "white");
INSERT INTO chessman(type_of, color) VALUES("rook", "white"); 
INSERT INTO chessman(type_of, color) VALUES("bishop", "black"); -- bishop - слон
INSERT INTO chessman(type_of, color) VALUES("bishop", "black");
INSERT INTO chessman(type_of, color) VALUES("bishop", "white");
INSERT INTO chessman(type_of, color) VALUES("bishop", "white"); 

INSERT INTO chessman(type_of, color) VALUES("pawn", "black"); -- pawn - пешка
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");
INSERT INTO chessman(type_of, color) VALUES("pawn", "black");

INSERT INTO chessman(type_of, color) VALUES("pawn", "white");
INSERT INTO chessman(type_of, color) VALUES("pawn", "white"); 
INSERT INTO chessman(type_of, color) VALUES("pawn", "white");
INSERT INTO chessman(type_of, color) VALUES("pawn", "white"); 
INSERT INTO chessman(type_of, color) VALUES("pawn", "white");
INSERT INTO chessman(type_of, color) VALUES("pawn", "white"); 
INSERT INTO chessman(type_of, color) VALUES("pawn", "white");
INSERT INTO chessman(type_of, color) VALUES("pawn", "white"); 

INSERT INTO chessman(type_of, color) VALUES("king", "white");
INSERT INTO chessman(type_of, color) VALUES("king", "black"); 

INSERT INTO chessman(type_of, color) VALUES("queen", "white");
INSERT INTO chessman(type_of, color) VALUES("queen", "black"); 

INSERT INTO chessman(type_of, color) VALUES("knight", "black"); -- knight - конь
INSERT INTO chessman(type_of, color) VALUES("knight", "black");
INSERT INTO chessman(type_of, color) VALUES("knight", "white");
INSERT INTO chessman(type_of, color) VALUES("knight", "white"); 


SELECT * FROM chessman;

CREATE TABLE chessboard(id_chessman INT, x INT CHECK(x > 0 AND x < 9), y INT CHECK(y > 0 AND y < 9), FOREIGN KEY (id_chessman) REFERENCES chessman(id) ON DELETE CASCADE ON UPDATE CASCADE, 
CHECK((x > 0 AND x < 9) AND (y > 0 AND y < 9)));

-- Таблица фигур, стоящих на доске.

INSERT INTO chessboard(id_chessman, x, y) VALUES(1, 1, 1);
INSERT INTO chessboard(id_chessman, x, y) VALUES(5, 7, 1);
INSERT INTO chessboard(id_chessman, x, y) VALUES(9, 3, 4);
INSERT INTO chessboard(id_chessman, x, y) VALUES(17, 2, 2);
INSERT INTO chessboard(id_chessman, x, y) VALUES(19, 6, 5);
INSERT INTO chessboard(id_chessman, x, y) VALUES(25, 6, 5);

SELECT * FROM chessboard;

-- Сколько фигур стоит на доске? Вывести количество. -- !!! 1 TASK
SELECT COUNT(*) FROM chessboard;

-- Вывести id фигур, чьи названия начинаются на букву k. -- !!! 2 TASK
SELECT id FROM chessman WHERE type_of LIKE 'k%';

-- Какие типы фигур бывают и по сколько штук? Вывести тип и количество. -- !!! 3 TASK
SELECT type_of, COUNT(type_of) FROM chessman GROUP BY type_of;

-- Вывести id белых пешек , стоящих на доске. -- !!! 4 TASK
SELECT id FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = "white" AND type_of = "pawn";

-- Какие фигуры стоят на главной диагонали? Вывести их тип и цвет. -- !!! 5 TASK
SELECT type_of, color FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE x = y;

-- Найдите общее количество фигур, оставшихся у каждого игрока. Вывести цвет и количество. -- !!! 6 TASK
SELECT color, COUNT(color) FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY color;

-- Какие фигуры черных имеются на доске? Вывести тип. -- !!! 7 TASK
SELECT type_of FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = "black";

-- Какие фигуры черных имеются на доске? Вывести тип и количество. -- !!! 8 TASK
SELECT type_of, COUNT(type_of) FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = "black" GROUP BY type_of;

-- Найдите типы фигур (любого цвета), которых осталось, по крайней мере, не меньше двух на доске. -- !!! 9 TASK
SELECT type_of FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY type_of HAVING COUNT(type_of) >= 2;

-- Вывести цвет фигур, которых на доске больше. -- !!! 10 TASK
SELECT color FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman GROUP BY color ORDER BY COUNT(color) DESC LIMIT 1;

-- Найдите фигуры, которые стоят на возможном пути движения ладьи (rock) (Любой ладьи любого цвета). (Ладья может двигаться по горизонтали или по вертикали
-- относительно своего положения на доске в любом направлении.). -- !!! 11 TASK



-- Найти фигуру, ближе всех стоящую к белому королю (расстояние считаем по метрике L1 – разница координат по X + разница координат по Y. -- !!! 15 TASK



-- Найти фигуры, которые может съесть ладья (Cid ладьи задан). Помните, что «своих» есть нельзя! -- !!! 16 TASK