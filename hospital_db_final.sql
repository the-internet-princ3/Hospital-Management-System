SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `hospital_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `hospital_db`;

-- Table structure for table `users`
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `User_Name` varchar(20) NOT NULL,
  `Password` varchar(15) NOT NULL,
  `User_Type` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Creating table for User';

-- Dumping data for table `users`
INSERT INTO `users` (`ID`, `Name`, `User_Name`, `Password`, `User_Type`) VALUES
(1, 'Amy', 'amy', 'amy', 'Receptionist'),
(2, 'John', 'john', 'john', 'Doctor'),
(106, 'Jenna Galloway', 'Stanley', 'JRZ01ZTG4ND', 'Doctor');

-- Table structure for table `appointment`
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment` (
  `Appointment_ID` varchar(10) NOT NULL,
  `Patient_ID` varchar(255) NOT NULL,
  `Doctor_ID` varchar(255) NOT NULL,
  `Appointment_Date` date NOT NULL COMMENT 'yyyy-MM-dd',
  `Diagnosis` text DEFAULT NULL,
  `Prescription` text DEFAULT NULL,
  PRIMARY KEY (`Appointment_ID`),
  KEY `Doctor_ID` (`Doctor_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `doctor` (`Doctor_ID`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`Patient_ID`) REFERENCES `patient` (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Creating table for appointments';

-- Dumping data for table `appointment`
INSERT INTO `appointment` (`Appointment_ID`, `Patient_ID`, `Doctor_ID`, `Appointment_Date`, `Diagnosis`, `Prescription`) VALUES
('A00001', 'P00001', 'D00001', '2020-10-01', 'Fever', 'Crocin'),
('A01010', 'P01500', 'D00004', '2020-10-22', NULL, NULL);

-- Table structure for table `doctor`
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `Doctor_ID` varchar(255) NOT NULL,
  `D_Name` varchar(255) NOT NULL,
  `Specialty` varchar(255) NOT NULL,
  `D_Contact_Number` decimal(10,0) NOT NULL,
  `Visiting_Hours` varchar(40) NOT NULL,
  `Log_ID` int(11) NOT NULL,
  PRIMARY KEY (`Doctor_ID`),
  KEY `Log_ID` (`Log_ID`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`Log_ID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Creating table for Doctors';

-- Dumping data for table `doctor`
INSERT INTO `doctor` (`Doctor_ID`, `D_Name`, `Specialty`, `D_Contact_Number`, `Visiting_Hours`, `Log_ID`) VALUES
('D00001', 'John Dan', 'Cardiology', '9854521475', 'TR 17:00 - 20:00', 2),
('D00004', 'New Doctor', 'General Medicine', '1234567890', 'Mon-Fri 9:00 - 17:00', 107); -- Added new Doctor_ID

-- Table structure for table `patient`
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `Patient_ID` varchar(255) NOT NULL,
  `P_Name` varchar(255) NOT NULL,
  `Sex` varchar(1) DEFAULT NULL,
  `Address` varchar(255) NOT NULL,
  `P_Contact_Number` decimal(10,0) NOT NULL,
  PRIMARY KEY (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Creating table for Patients';

-- Dumping data for table `patient`
INSERT INTO `patient` (`Patient_ID`, `P_Name`, `Sex`, `Address`, `P_Contact_Number`) VALUES
('P00001', 'Anna Todd', 'F', 'College Station, Texas', '9852014788'),
('P01500', 'Rick Hall', 'M', 'College Station, Texas', '9852154728');

-- Add other tables and data here...

COMMIT;
