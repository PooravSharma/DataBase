
CREATE TABLE [dbo].[Team]
(
[TeamName] VARCHAR (50) PRIMARY KEY  NOT NULL,
[Founded] INT NOT NULL, 
[Members] INT NOT NULL, 
[Points_Scored] INT NOT NULL, 
[Points_Conceded] INT NOT NULL

)

CREATE TABLE [dbo].[Ladder]
(
[Position] INT PRIMARY KEY NOT NULL,
[TeamName] VARCHAR (50)  NOT NULL,
[Played] INT NOT NULL,
[Wins] INT NOT NULL,
[Lost] INT NOT NULL,
[Points] INT NOT NULL,
CONSTRAINT FK_TeamName FOREIGN KEY ([TeamName]) REFERENCES Team([TeamName])
	
)

CREATE TABLE [dbo].[Players]
(
[PlayerID] INT PRIMARY KEY NOT NULL,
[PlayerName] VARCHAR (50) NOT NULL,
[Attack] INT,
[Scoring] INT,
[Defending] INT,
[Passing] INT,
[TeamName] VARCHAR (50) NOT NULL
CONSTRAINT FKTeamName FOREIGN KEY ([TeamName]) REFERENCES Team([TeamName])
)







