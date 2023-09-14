--**************************************************************
-- P1
-- **Required tables & their structures 

CREATE TABLE Theatre ( TheatreID INT PRIMARY KEY AUTO_INCREMENT, 
  TheatreName VARCHAR(50) NOT NULL,
  Location VARCHAR(50) NOT NULL,
  Capacity INT NOT NULL
);

INSERT INTO Theatre (TheatreName, Location, Capacity) VALUES
  ('Big Cinemas', 'Bejai', 200),
  ('PVR', 'Kavoor', 150);

SELECT * FROM Theatre;
+-----------+-------------+----------+----------+
| TheatreID | TheatreName | Location | Capacity |
+-----------+-------------+----------+----------+
|         1 | Big Cinemas | Bejai    |      200 |
|         2 | PVR         | Kavoor   |      150 |
+-----------+-------------+----------+----------+


CREATE TABLE Movie ( MovieID INT PRIMARY KEY AUTO_INCREMENT,
  MovieName VARCHAR(50) NOT NULL,
  Genre VARCHAR(50) NOT NULL,
  ReleaseDate DATE NOT NULL
);

INSERT INTO Movie (MovieName, Genre, ReleaseDate) VALUES
  ('Jawan', 'Action', '2023-10-07'),
  ('Jailer', 'Crime', '2023-09-15');

SELECT * FROM Movie;
+---------+-----------+--------+-------------+
| MovieID | MovieName | Genre  | ReleaseDate |
+---------+-----------+--------+-------------+
|       1 | Jawan     | Action | 2023-10-07  |
|       2 | Jailer    | Crime  | 2023-09-15  |
+---------+-----------+--------+-------------+


CREATE TABLE Shows (
  ShowID INT PRIMARY KEY AUTO_INCREMENT,
  MovieID INT,
  TheatreID INT,
  ShowDate DATE NOT NULL,
  ShowTime TIME NOT NULL,
  FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
  FOREIGN KEY (TheatreID) REFERENCES Theatre(TheatreID)
);

INSERT INTO Shows (MovieID, TheatreID, ShowDate, ShowTime) VALUES
  (1, 1, '2023-10-15', '18:00:00'),
  (1, 1, '2023-10-15', '20:30:00'),
  (2, 2, '2023-10-15', '19:00:00');

SELECT * FROM Shows;
+--------+---------+-----------+------------+----------+
| ShowID | MovieID | TheatreID | ShowDate   | ShowTime |
+--------+---------+-----------+------------+----------+
|      1 |       1 |         1 | 2023-10-15 | 18:00:00 |
|      2 |       1 |         1 | 2023-10-15 | 20:30:00 |
|      3 |       2 |         2 | 2023-10-15 | 19:00:00 |
+--------+---------+-----------+------------+----------+


-- Query to list all shows on a given date at a given theatre
SELECT M.MovieName, T.TheatreName, S.ShowDate, S.ShowTime
FROM Shows S
JOIN Movie M ON S.MovieID = M.MovieID
JOIN Theatre T ON S.TheatreID = T.TheatreID
WHERE S.ShowDate = '2023-10-15' AND T.TheatreName = 'Big Cinemas';
--Result
+-----------+-------------+------------+----------+
| MovieName | TheatreName | ShowDate   | ShowTime |
+-----------+-------------+------------+----------+
| Jawan     | Big Cinemas | 2023-10-15 | 18:00:00 |
| Jawan     | Big Cinemas | 2023-10-15 | 20:30:00 |
+-----------+-------------+------------+----------+


--**************************************************************
-- P2 
-- Query to list down all shows on a given date at a given theatre along with their respective show timings
SELECT M.MovieName, T.TheatreName, S.ShowDate, GROUP_CONCAT(S.ShowTime) AS ShowTimings FROM Shows S 
  JOIN Movie M ON S.MovieID = M.MovieID 
  JOIN Theatre T ON S.TheatreID = T.TheatreID 
  WHERE S.ShowDate = '2023-10-15' AND T.TheatreName = 'Big Cinemas' 
  GROUP BY M.MovieName, T.TheatreName, S.ShowDate;
--Result
+-----------+-------------+------------+-------------------+
| MovieName | TheatreName | ShowDate   | ShowTimings       |
+-----------+-------------+------------+-------------------+
| Jawan     | Big Cinemas | 2023-10-15 | 18:00:00,20:30:00 |
+-----------+-------------+------------+-------------------+


--**************************************************************
  






