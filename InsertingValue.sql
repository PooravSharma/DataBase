INSERT INTO Team
	(TeamName, Founded, Members, Points_Scored, Points_Conceded)
VALUES
	('Panthers', 1967, 19085, 456, 158),
	('Storm', 1997, 35000, 433, 224),
	('Eels', 1947, 32376, 339, 303);

INSERT INTO Ladder
	(Position, TeamName, Played, Wins, Lost, Points)
VALUES
	(1, 'Panthers', 11 , 11, 0, 22),
	(2, 'Storm', 11, 9, 2, 18),
	(3, 'Eels', 11, 9, 2, 18);


INSERT INTO Players
	(PlayerID, PlayerName, Attack, Scoring, Defending, Passing, TeamName)
VALUES
	(1234, 'Apisai Koroisau', 10, 2, 625, 1659, 'Panthers'),
	(4321, 'Felise Kaufusi', 4, 3, 355, 7, 'Storm');



