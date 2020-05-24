CREATE TABLE Majors (
	MajorID INT NOT NULL CONSTRAINT PK_MAJOR_ID PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Subjects (
	SubjectID INT NOT NULL CONSTRAINT PK_SUBJECT_ID PRIMARY KEY,
	SubjectName NVARCHAR(50) NOT NULL
)

CREATE TABLE Students (
	StudentID INT NOT NULL CONSTRAINT PK_STUDENT_ID PRIMARY KEY,
	StudentNumber NVARCHAR(50) NOT NULL,
	StudentName NVARCHAR(50) NOT NULL,
	MajorID INT NOT NULL CONSTRAINT FK_MAJOR_ID FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Payments (
	PaymentID INT NOT NULL CONSTRAINT PK_PAYMENT_ID PRIMARY KEY,
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL NOT NULL,
	StudentID INT NOT NULL CONSTRAINT FK_STUDENT_ID FOREIGN KEY REFERENCES Students(StudentID)
)

CREATE TABLE Agenda (
	StudentID INT NOT NULL CONSTRAINT FK_AGENDA_STUD_ID FOREIGN KEY REFERENCES Students(StudentID),
	SubjectID int NOT NULL CONSTRAINT FK_AGENDA_SUBJ_ID FOREIGN KEY REFERENCES Subjects(SubjectID),
	CONSTRAINT PK_AGENDA PRIMARY KEY (StudentID, SubjectID)
)