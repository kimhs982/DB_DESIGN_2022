-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema week5_assignment_12181763
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema week5_assignment_12181763
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `week5_assignment_12181763` DEFAULT CHARACTER SET utf8mb3 ;
USE `week5_assignment_12181763` ;

-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`building` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`department` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(30) NULL DEFAULT NULL,
  `Phone_number` CHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`room` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Capacity` INT NULL DEFAULT NULL,
  `Bid` INT NOT NULL,
  `Did` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Room_Building_idx` (`Bid` ASC) VISIBLE,
  INDEX `fk_Room_Department1_idx` (`Did` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Building`
    FOREIGN KEY (`Bid`)
    REFERENCES `week5_assignment_12181763`.`building` (`Id`),
  CONSTRAINT `fk_Room_Department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week5_assignment_12181763`.`department` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`Employee` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NULL,
  `Position` VARCHAR(20) NULL,
  `Did` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Employee_department1_idx` (`Did` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week5_assignment_12181763`.`department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`class` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  `Professor` VARCHAR(20) NULL DEFAULT NULL,
  `Number_of_participants` INT NULL DEFAULT NULL,
  `Did` INT NOT NULL,
  `Rid` INT NOT NULL,
  `Eid` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Class_Department1_idx` (`Did` ASC) VISIBLE,
  INDEX `fk_Class_Room1_idx` (`Rid` ASC) VISIBLE,
  INDEX `fk_class_Employee1_idx` (`Eid` ASC) VISIBLE,
  CONSTRAINT `fk_Class_Department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week5_assignment_12181763`.`department` (`Id`),
  CONSTRAINT `fk_Class_Room1`
    FOREIGN KEY (`Rid`)
    REFERENCES `week5_assignment_12181763`.`room` (`Id`),
  CONSTRAINT `fk_class_Employee1`
    FOREIGN KEY (`Eid`)
    REFERENCES `week5_assignment_12181763`.`Employee` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`student` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NULL DEFAULT NULL,
  `Email` VARCHAR(30) NULL DEFAULT NULL,
  `Phone_number` CHAR(13) NULL DEFAULT NULL,
  `Major` VARCHAR(50) NULL DEFAULT NULL,
  `Student_Id` CHAR(8) NOT NULL,
  `Did` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Student_Id_UNIQUE` (`Student_Id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE,
  INDEX `fk_Student_Department1_idx` (`Did` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week5_assignment_12181763`.`department` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`take_classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`take_classes` (
  `Sid` INT NOT NULL,
  `Cid` INT NOT NULL,
  PRIMARY KEY (`Cid`, `Sid`),
  INDEX `fk_Student_has_Class1_Class1_idx` (`Cid` ASC) VISIBLE,
  INDEX `fk_Student_has_Class1_Student1_idx` (`Sid` ASC) INVISIBLE,
  CONSTRAINT `fk_Student_has_Class1_Class1`
    FOREIGN KEY (`Cid`)
    REFERENCES `week5_assignment_12181763`.`class` (`Id`),
  CONSTRAINT `fk_Student_has_Class1_Student1`
    FOREIGN KEY (`Sid`)
    REFERENCES `week5_assignment_12181763`.`student` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`Club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`Club` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NULL,
  `Rid` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Club_room1_idx` (`Rid` ASC) VISIBLE,
  CONSTRAINT `fk_Club_room1`
    FOREIGN KEY (`Rid`)
    REFERENCES `week5_assignment_12181763`.`room` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `week5_assignment_12181763`.`join_clubs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week5_assignment_12181763`.`join_clubs` (
  `CId` INT NOT NULL,
  `SId` INT NOT NULL,
  PRIMARY KEY (`CId`, `SId`),
  INDEX `fk_Club_has_student_student1_idx` (`SId` ASC) VISIBLE,
  INDEX `fk_Club_has_student_Club1_idx` (`CId` ASC) VISIBLE,
  CONSTRAINT `fk_Club_has_student_Club1`
    FOREIGN KEY (`CId`)
    REFERENCES `week5_assignment_12181763`.`Club` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Club_has_student_student1`
    FOREIGN KEY (`SId`)
    REFERENCES `week5_assignment_12181763`.`student` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO BUILDING
VALUES      (2,'2??????'),
            (3, '60???????????????'),
            (4, '4??????'),
            (5, '5??????'),
            (12, '??????????????????');

INSERT INTO DEPARTMENT
VALUES      (1, '???????????????', 'Environmental@inha.ac.kr', '032-860-7500'),
            (2, '????????????', 'Architecture@inha.ac.kr', '032-860-7580'),
            (3, '?????????????????????', 'IC@inha.ac.kr', '032-860-7430'),
            (4, '???????????????', 'Electric@inha.ac.kr', '032-860-7716'),
            (5, '???????????????', 'Electronic@inha.ac.kr', '032-860-7719'),
            (6, '??????????????????', 'generaledu@inha.ac.kr', '032-860-8499');

INSERT INTO ROOM
VALUES      (441, '??????????????? ?????????', 20, 2, 1),
            (413, '???????????? ?????????', 20, 2, 2),
            (501, '?????? ?????????', 30, 3, 6),
            (1306, '?????????????????? ?????????', 20, 3, 6),
            (416, '?????????????????? ?????????', 20, 12, 3),
            (603, '??????????????? ?????????', 20, 12, 4),
            (801, '??????????????? ?????????', 20, 12, 5),
            (424, '???????????? ?????????', 40, 12, 3),
            (230, '???????????? ?????????1', 40, 12, 3),
            (232, '???????????? ?????????2', 40, 12,3 ),
            (308, '5?????? ????????????1', 20, 5, 6),
            (17, '5?????? ????????????2', 20, 5, 6);

INSERT INTO STUDENT
VALUES      (1, '?????????', 'kimhs982@inha.edu', '010-0000-0000', '??????????????????', '12181763', 3),
            (2, '?????????', 'Hong@inha.edu', '010-1234-5678', '??????????????????', '12191234', 3),
            (3, '?????????', 'Charles@inha.edu', '010-2345-6789', '????????????', '12202345', 4),
            (4, '?????????', 'Yeongheui@inha.edu', '010-3456-7890', '????????????', '12213456', 5),
            (5, '?????????', 'Minu@inha.edu', '010-4567-8901', '????????????', '12224567', 1);

INSERT INTO EMPLOYEE
VALUES      (1, '?????????', 'professor', 3),
            (2, '?????????', 'professor', 6),
            (3, '?????????', 'professor', 3),
            (4, '?????????', 'professor', 3),
            (5, '?????????', 'professor', 3),
            (6, '?????????', 'office worker', 6);

INSERT INTO CLASS
VALUES      (1, '??????????????????', '?????????', 20, 6, 501, 2),
            (2, '????????????????????????', '?????????', 40, 3, 232, 1),
            (3, '?????????????????????', '?????????', 30, 3, 232, 3),
            (4, '???????????????????????????', '?????????', 20, 3, 424, 4),
            (5, '?????????????????????', '?????????', 40, 3, 230, 5);

INSERT INTO TAKE_CLASSES
VALUES      (1, 1),
            (1, 2),
            (1, 3),
            (1, 4),
            (2, 2),
            (2, 5),
            (3, 3),
            (4, 1),
            (4, 4),
            (5, 1);

INSERT INTO CLUB
VALUES      (1, '????????????', 308),
            (2, '?????????', 17),
            (3, 'GDSC', NULL),
            (4, '?????????', NULL),
            (5, 'Open Seasame', NULL);

INSERT INTO JOIN_CLUBS
VALUES      (3, 1),
            (1, 2),
            (2, 2),
            (5, 3),
            (1, 4),
            (5, 4),
            (4, 5);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
