DROP TABLE IF EXISTS RentalAgreement;
DROP TABLE IF EXISTS VideoForRent;
DROP TABLE IF EXISTS Video;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Director;

CREATE TABLE Director(
    DirectorNo CHAR(5) NOT NULL PRIMARY KEY,
    DirectorName VARCHAR(25)
);

CREATE TABLE Video(
    catalogNo INT NOT NULL PRIMARY KEY,
    title VARCHAR(30),
    certificate VARCHAR(10),
    category VARCHAR(10),
    dailyRental DECIMAL(13, 4),
    price DECIMAL(13, 4),
    DirectorNo CHAR(5)
);

CREATE TABLE VideoForRent(
    videoNo INT NOT NULL PRIMARY KEY,
    available BIT,
    catalogNo INT
);

CREATE TABLE Member(
    memberNo INT AUTO_INCREMENT PRIMARY KEY,
    fName VARCHAR(15),
    lName VARCHAR(15),
    sex CHAR(1),
    DOB DATETIME,
    address VARCHAR(50),
    dateJoined DATETIME
);

CREATE TABLE RentalAgreement(
    rentalNo INT AUTO_INCREMENT PRIMARY KEY,
    memberNo INT,
    videoNo INT,
    dateOut DATETIME,
    dateReturn DATETIME
);


ALTER TABLE Member ALTER sex SET DEFAULT 'M';
ALTER TABLE RentalAgreement ALTER dateOut SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Member ADD CONSTRAINT sex_chk CHECK (sex in ('M','F'));

ALTER TABLE Video
   ADD CONSTRAINT directorNo_kfor
     FOREIGN KEY (directorNo)
     REFERENCES Director (directorNo);

ALTER TABLE VideoForRent
  ADD CONSTRAINT catalogNo_kfor
    FOREIGN KEY (catalogNo)
    REFERENCES Video (catalogNo);

ALTER TABLE RentalAgreement
  ADD CONSTRAINT videoNo_kfor
    FOREIGN KEY (videoNo)
    REFERENCES VideoForRent (videoNo);

ALTER TABLE RentalAgreement
   ADD CONSTRAINT memberNo_kfor
     FOREIGN KEY (memberNo)
     REFERENCES Member(memberNo);

ALTER TABLE RentalAgreement
     ADD CONSTRAINT dateReturn_chk CHECK (dateReturn > dateOut);


INSERT INTO Director VALUES ('D0078', 'Stephen Herek');
INSERT INTO Director VALUES ('D1001', 'Roger Spottiswoode');
INSERT INTO Director VALUES ('D3765', 'Jane Emmerick');
INSERT INTO Director VALUES ('D4576', 'John Woo');
INSERT INTO Director VALUES ('D5743', 'Michael Bay');
INSERT INTO Director VALUES ('D7834', 'Sally Nichols');

INSERT INTO Video VALUES (207132, 'Tomorrow Never Dies','12','Action',5,21.99,'D1001');
INSERT INTO Video VALUES (330553, 'Face/Off','12','Thriller',5,31.99,'D4576');
INSERT INTO Video VALUES (445624, 'The Rock','18','Action',4,29.99,'D5743');
INSERT INTO Video VALUES (634817, 'Independence Day','PG','Sci-Fi',4.5,32.99,'D3765');
INSERT INTO Video VALUES (781132, '101 Dalmatians','U','Children',4,18.5,'D0078');
INSERT INTO Video VALUES (902355, 'Primary Colors','U','Comedy',4.5,14.5,'D7834');

INSERT INTO VideoForRent VALUES (178643, 0,634817);
INSERT INTO VideoForRent VALUES (199004, 1,207132);
INSERT INTO VideoForRent VALUES (200900, 1,330553);
INSERT INTO VideoForRent VALUES (210087, 1,902355);
INSERT INTO VideoForRent VALUES (243431, 1,634817);
INSERT INTO VideoForRent VALUES (245456, 1,207132);
INSERT INTO VideoForRent VALUES (245457, 1,207132);
INSERT INTO VideoForRent VALUES (317411, 1,781132);


INSERT INTO Member (fname, lname, sex, DOB, address,dateJoined) VALUES ('Karen', 'Parker','F',STR_TO_DATE('2-22-1972', '%m-%d-%Y'),
          '22 Greenway Drive, Glasgow, G12 8DS',STR_TO_DATE('1-6-1991', '%m-%d-%Y'));
INSERT INTO Member (fname, lname, sex, DOB, address,dateJoined) VALUES ('Gillian', 'Peters','F',STR_TO_DATE('3-9-1954', '%m-%d-%Y'),
'89 Redmond Road, Glasgow, G11 9YR',STR_TO_DATE('4-19-1995','%m-%d-%Y'));
INSERT INTO Member (fname, lname, sex, DOB, address,dateJoined) VALUES ('Bob', 'Adams','M',STR_TO_DATE('11-15-1974','%m-%d-%Y'),
'57 Littleway Road, Glasgow, G3 6DS',STR_TO_DATE('1-6-1998','%m-%d-%Y'));
INSERT INTO Member (fname, lname, sex, DOB, address,dateJoined) VALUES ('Don', 'Nelson','M',STR_TO_DATE('12-12-1951','%m-%d-%Y'),
'123 Suffolk Lane,Glasgow, G15 1RC',STR_TO_DATE('4-7-2000','%m-%d-%Y'));
INSERT INTO Member (fname, lname, sex, DOB, address,dateJoined) VALUES ('Lorna', 'Smith','F',STR_TO_DATE('1-1-1972','%m-%d-%Y'),
'Flat 5A London Road, Glasgow, G3',STR_TO_DATE('1-11-1998','%m-%d-%Y'));
INSERT INTO Member (fname, lname, sex, DOB, address,dateJoined) VALUES ('Dan', 'White','M',STR_TO_DATE('5-5-1960','%m-%d-%Y'),
'200 Great Western Road, Glasgow, G11 9JJ',STR_TO_DATE('5-5-2001','%m-%d-%Y'));



INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (1, 178643,STR_TO_DATE('2-5-2000','%m-%d-%Y'),STR_TO_DATE('2-7-2000','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (1, 199004,STR_TO_DATE('2-5-2000','%m-%d-%Y'),STR_TO_DATE('2-7-2000','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (1, 245456,STR_TO_DATE('2-4-2000','%m-%d-%Y'),STR_TO_DATE('2-6-2000','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (1, 243431,STR_TO_DATE('2-4-2000','%m-%d-%Y'),STR_TO_DATE('2-6-2000','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (3, 199004,STR_TO_DATE('11-11-1999','%m-%d-%Y'),STR_TO_DATE('11-12-1999','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (2, 245456,STR_TO_DATE('11-11-1999','%m-%d-%Y'),STR_TO_DATE('11-13-1999','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (4, 178643,STR_TO_DATE('11-14-1999','%m-%d-%Y'),STR_TO_DATE('11-16-1999','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (3, 243431,STR_TO_DATE('11-11-1999','%m-%d-%Y'),STR_TO_DATE('11-13-1999','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (1, 245457,STR_TO_DATE('11-12-1999','%m-%d-%Y'),STR_TO_DATE('11-14-1999','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (3, 199004,STR_TO_DATE('8-10-2000','%m-%d-%Y'),NULL);
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (2, 199004,STR_TO_DATE('8-17-2000','%m-%d-%Y'),STR_TO_DATE('8-20-2000','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (6, 178643,STR_TO_DATE('2-5-2004','%m-%d-%Y'),STR_TO_DATE('2-7-2004','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (6, 317411,STR_TO_DATE('2-5-2004','%m-%d-%Y'),STR_TO_DATE('2-7-2004','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (4, 317411,STR_TO_DATE('2-5-2003','%m-%d-%Y'),STR_TO_DATE('2-7-2003','%m-%d-%Y'));
INSERT INTO RentalAgreement (memberNo, videoNo, dateOut, dateReturn) VALUES (1, 317411,STR_TO_DATE('2-5-2002','%m-%d-%Y'),STR_TO_DATE('2-7-2002','%m-%d-%Y'));