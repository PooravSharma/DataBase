
CREATE TABLE Team (
TeamName VARCHAR (50) PRIMARY KEY  NOT NULL,
Founded INT NOT NULL, 
Members INT NOT NULL, 
Points_Scored INT NOT NULL, 
Points_Conceded INT NOT NULL
);

CREATE TABLE Ladder(
Position INT PRIMARY KEY NOT NULL,
TeamName VARCHAR (50) NOT NULL,
Played INT NOT NULL,
Wins INT NOT NULL,
Lost INT NOT NULL,
Points INT NOT NULL,
FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);

CREATE TABLE Players (
PlayerID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
PlayerName VARCHAR (50) NOT NULL,
Attack INT,
Scoring INT,
Defending INT,
Passing INT,
TeamName VARCHAR (50) NOT NULL
FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);







