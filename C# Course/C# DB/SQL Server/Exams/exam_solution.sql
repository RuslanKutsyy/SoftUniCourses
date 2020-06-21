--01. DDL

CREATE TABLE Cities
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	CountryCode VARCHAR(2) NOT NULL CHECK(LEN(CountryCode) = 2)
)

CREATE TABLE Hotels
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	CityId INT NOT NULL FOREIGN KEY REFERENCES Cities(Id),
	EmployeeCount INT NOT NULL,
	BaseRate DECIMAL(15, 2)
)

CREATE TABLE Rooms
(
	Id INT PRIMARY KEY IDENTITY,
	Price DECIMAL(15, 2) NOT NULL,
	[Type] NVARCHAR(20) NOT NULL,
	Beds INT NOT NULL,
	HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotels(Id)
)

CREATE TABLE Trips
(
	Id INT PRIMARY KEY IDENTITY,
	RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id),
	BookDate DATE NOT NULL,
	ArrivalDate DATE NOT NULL,
	ReturnDate DATE NOT NULL,
	CancelDate DATE
)

CREATE TABLE Accounts
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(20),
	LastName NVARCHAR(50) NOT NULL,
	CityId INT NOT NULL FOREIGN KEY REFERENCES Cities(Id),
	BirthDate DATE NOT NULL,
	Email NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE AccountsTrips
(
	AccountId INT NOT NULL FOREIGN KEY REFERENCES Accounts(Id),
	TripId INT NOT NULL FOREIGN KEY REFERENCES Trips(Id),
	Luggage INT NOT NULL
	PRIMARY KEY (AccountId, TripId)
)


--02. Insert

INSERT INTO Accounts (FirstName, MiddleName, LastName, CityId, BirthDate, Email)
VALUES
('John', 'Smith', 'Smith', 34, '1975-07-21', 'j_smith@gmail.com'),
('Gosho', NULL, 'Petrov', 11, '1978-05-16',	'g_petrov@gmail.com'),
('Ivan', 'Petrovich', 'Pavlov', 59, '1849-09-26', 'i_pavlov@softuni.bg'),
('Friedrich', 'Wilhelm', 'Nietzsche', 2, '1844-10-15', 'f_nietzsche@softuni.bg')

INSERT INTO Trips (RoomId, BookDate, ArrivalDate, ReturnDate, CancelDate)
VALUES
(101, '2015-04-12', '2015-04-14', '2015-04-20',	'2015-02-02'),
(102, '2015-07-07',	'2015-07-15', '2015-07-22',	'2015-04-29'),
(103, '2013-07-17',	'2013-07-23', '2013-07-24',	NULL),
(104, '2012-03-17',	'2012-03-31', '2012-04-01',	'2012-01-10'),
(109, '2017-08-07',	'2017-08-28', '2017-08-29',	NULL)


--03. Update

UPDATE Rooms
SET Price = Price * 1.14
WHERE HotelId IN (5, 7, 9)


--04. Delete

DELETE FROM AccountsTrips
WHERE AccountId = 47


--05. EEE-Mails

SELECT a.FirstName, a.LastName, FORMAT(a.BirthDate, 'MM-dd-yyyy') AS BirthDate,
		c.Name AS Hometown, a.Email
FROM Accounts as a
JOIN Cities AS c
	ON a.CityId = c.Id
WHERE Email LIKE 'e%'
ORDER BY Hometown


--06. City Statistics

SELECT c.Name AS City, COUNT(h.Id) AS Hotels
FROM Hotels AS h
JOIN Cities AS c
	ON h.CityId = c.Id
GROUP BY c.Name
ORDER BY Hotels DESC, City

--07. Longest and Shortest Trips
SELECT info.AccountId, info.FullName, MAX(info.LongestTrip) AS LongestTrip,
		MIN(info.ShortestTrip) AS ShortestTrip
FROM 
(SELECT  atr.AccountId,
		a.FirstName + ' ' + a.LastName AS FullName,
		DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate) AS LongestTrip,
		DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate) AS ShortestTrip
FROM Trips AS t
JOIN AccountsTrips AS atr
	ON t.Id = atr.TripId
JOIN Accounts AS a
	ON atr.AccountId = a.Id
WHERE a.MiddleName IS NULL AND t.CancelDate IS NULL) AS info
GROUP BY info.AccountId, info.FullName
ORDER BY LongestTrip DESC, ShortestTrip


--08. Metropolis

SELECT  c.Id, c.Name AS City,
		c.CountryCode AS Country,
		COUNT(a.Id) AS Accounts
FROM Cities AS c
JOIN Accounts AS a
	ON c.Id = a.CityId
GROUP BY c.Id, c.Name, c.CountryCode
ORDER BY Accounts DESC


--09. Romantic Getaways


SELECT * FROM 
(SELECT ac.Id, ac.Email, c.Name AS City, COUNT(atr.TripId) AS Trips
FROM Accounts AS ac
JOIN AccountsTrips AS atr
	ON ac.Id = atr.AccountId
JOIN Trips AS tr
	ON atr.TripId = tr.Id
JOIN Rooms AS r
	ON r.Id = tr.RoomId
JOIN Hotels AS h
	ON h.Id = r.HotelId
JOIN Cities AS c
	ON c.Id = h.CityId
WHERE ac.CityId = h.CityId
GROUP BY ac.Id, ac.Email, c.Name) AS info
WHERE info.Trips >= 1
ORDER BY info.Trips DESC, info.Id