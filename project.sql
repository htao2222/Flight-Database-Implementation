CREATE DATABASE     IF NOT EXISTS projectpt3;
USE projectpt3;


SET FOREIGN_KEY_CHECKS=0;


DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  question varchar(250) NOT NULL,
  answer varchar(250) NOT NULL,
  id int DEFAULT '0',
  PRIMARY KEY (id));
  INSERT INTO questions VALUES ('How does this work?','Ask a question and we will answer!',1);
  
DROP TABLE IF EXISTS users;


  CREATE TABLE users (
  username varchar(50) NOT NULL,
  password varchar(50) NOT NULL,
  level int DEFAULT '0',
  PRIMARY KEY (username));
  INSERT INTO users VALUES ('admin','password',2),('custrep','reppass',1),('steven','steven',0);


DROP TABLE IF EXISTS aircraftData;


CREATE TABLE aircraftData(
aircraftData varchar(10) NOT NULL,
econSeats int DEFAULT 0,
businessSeats int DEFAULT 0,
firstSeats int DEFAULT 0,
primary key(aircraftData));
INSERT INTO aircraftData VALUES ("747", 2, 2, 2);


DROP TABLE IF EXISTS airportData;


CREATE TABLE airportData(
airportData varchar(3) NOT NULL,
primary key(airportData));
INSERT INTO airportData VALUES ("LAX");
INSERT INTO airportData VALUES ("JFK");
INSERT INTO airportData VALUES ("MIN");


DROP TABLE IF EXISTS flights;
CREATE TABLE flights(
flightId int NOT NULL,
aircraftData varchar(10) NOT NULL,
arrivalAirport varchar(3) NOT NULL,
departingAirport varchar(3) NOT NULL,
arrivalTime time NOT NULL,
departureTime time NOT NULL,
typeFlight varchar(50) NOT NULL,
econRate int NOT NULL,
businessRate int NOT NULL,
firstRate int NOT NULL,
duration int NOT NULL,
airline char(2) NOT NULL,
arrivalDate date NOT NULL,
departureDate date NOT NULL,
foreign Key (arrivalAirport) references airportData (airportData) ON DELETE CASCADE ON UPDATE CASCADE,
foreign Key (departingAirport) references airportData (airportData) ON DELETE CASCADE ON UPDATE CASCADE,
foreign Key (aircraftData) references aircraftData (aircraftData) ON DELETE CASCADE ON UPDATE CASCADE,
primary Key(flightId));
#INSERT INTO flights VALUES (7, "747", "JFK", "LAX", "10:10:10", "08:08:08", "One-Way Specific", 20, 30, 40, 20, "DA", "2020-03-14", "2020-03-13") ,(21,"747", "LAX", "MIN", "11:01:01","11:59:59","Round-Trip Specific",30,40,50,25,"SP","2020-03-17","2020-03-15");


DROP TABLE IF EXISTS tickets;
CREATE TABLE tickets(
username varchar(50) DEFAULT NULL,
flightId int NOT NULL,
class varchar(10) NOT NULL,
seatNum int NOT NULL,
fare int NOT NULL,
datePurchase date,
bookingFee int DEFAULT 0,
cancelFee int DEFAULT 0,
foreign key(flightId) references flights(flightId) ON DELETE CASCADE ON UPDATE CASCADE,
#foreign key(username) references users(username) ON DELETE SET NULL ON UPDATE CASCADE,
primary key(flightID,class,seatNum));
#INSERT INTO tickets VALUES (NULL,1,"first",3,4,NULL,3,4),(NULL,1,"first",2,4,NULL,3,4);


DROP TABLE IF EXISTS waitinglist;
CREATE TABLE waitinglist(
username varchar(50) NOT NULL,
flightId int NOT NULL,
class varchar(10),
#foreign key(username) references users(username) ON DELETE CASCADE ON UPDATE CASCADE,
primary key(username,flightId,class)
);


DROP TABLE IF EXISTS cancellist;
CREATE TABLE cancellist(
username varchar(50) NOT NULL,
id int AUTO_INCREMENT,
fee int,
cancelDate date,
#foreign key(username) references users(username) ON DELETE CASCADE,
primary key(id)
);




##SET FOREIGN_KEY_CHECKS=1;


#SELECT * FROM tickets where flightId=1 and class='first' and username is null ORDER BY seatNum ASC;
#DELETE FROM tickets WHERE flightId=1 and class='first' and username is null and seatNum = 3;
#INSERT INTO tickets values ('username',1,'first',3,1,'11:11:11',2,3);
#SELECT * From tickets;


SHOW tables;