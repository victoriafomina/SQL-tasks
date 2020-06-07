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
INSERT INTO chessboard(id_chessman, x, y) VALUES(10, 6, 5);

SELECT * FROM chessboard;

-- Сколько фигур стоит на доске? Вывести количество.
SELECT COUNT(*) FROM chessboard; -- !!! 1 TASK

-- Вывести id фигур, чьи названия начинаются на букву k.
SELECT id FROM chessman WHERE type_of LIKE 'k%'; -- !!! 2 TASK

-- Вывести id белых пешек , стоящих на доске.
SELECT id FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE color = "white" AND type_of = "pawn"; -- !!! 4 TASK

-- Какие фигуры стоят на главной диагонали? Вывести их тип и цвет.
SELECT type_of, color FROM chessman INNER JOIN chessboard ON chessman.id = chessboard.id_chessman WHERE x = y -- !!! 5 TASK