-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema week4_assignment_12181763
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema week4_assignment_12181763
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `week4_assignment_12181763` DEFAULT CHARACTER SET utf8mb3 ;
USE `week4_assignment_12181763` ;

-- -----------------------------------------------------
-- Table `week4_assignment_12181763`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week4_assignment_12181763`.`building` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week4_assignment_12181763`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week4_assignment_12181763`.`department` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(30) NULL DEFAULT NULL,
  `Phone number` CHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone number_UNIQUE` (`Phone number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week4_assignment_12181763`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week4_assignment_12181763`.`room` (
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
    REFERENCES `week4_assignment_12181763`.`building` (`Id`),
  CONSTRAINT `fk_Room_Department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week4_assignment_12181763`.`department` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week4_assignment_12181763`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week4_assignment_12181763`.`class` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  `Professor` VARCHAR(20) NULL DEFAULT NULL,
  `Number of participants` INT NULL DEFAULT NULL,
  `Did` INT NOT NULL,
  `Rid` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Class_Department1_idx` (`Did` ASC) VISIBLE,
  INDEX `fk_Class_Room1_idx` (`Rid` ASC) VISIBLE,
  CONSTRAINT `fk_Class_Department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week4_assignment_12181763`.`department` (`Id`),
  CONSTRAINT `fk_Class_Room1`
    FOREIGN KEY (`Rid`)
    REFERENCES `week4_assignment_12181763`.`room` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week4_assignment_12181763`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week4_assignment_12181763`.`student` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(20) NULL DEFAULT NULL,
  `Email` VARCHAR(30) NULL DEFAULT NULL,
  `Phone number` CHAR(13) NULL DEFAULT NULL,
  `Major` VARCHAR(50) NULL DEFAULT NULL,
  `Student ID` CHAR(8) NOT NULL,
  `Did` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Student ID_UNIQUE` (`Student ID` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone number_UNIQUE` (`Phone number` ASC) VISIBLE,
  INDEX `fk_Student_Department1_idx` (`Did` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Department1`
    FOREIGN KEY (`Did`)
    REFERENCES `week4_assignment_12181763`.`department` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `week4_assignment_12181763`.`take_classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `week4_assignment_12181763`.`take_classes` (
  `Sid` INT NOT NULL,
  `Cid` INT NOT NULL,
  PRIMARY KEY (`Cid`, `Sid`),
  INDEX `fk_Student_has_Class1_Class1_idx` (`Cid` ASC) VISIBLE,
  INDEX `fk_Student_has_Class1_Student1_idx` (`Sid` ASC) INVISIBLE,
  CONSTRAINT `fk_Student_has_Class1_Class1`
    FOREIGN KEY (`Cid`)
    REFERENCES `week4_assignment_12181763`.`class` (`Id`),
  CONSTRAINT `fk_Student_has_Class1_Student1`
    FOREIGN KEY (`Sid`)
    REFERENCES `week4_assignment_12181763`.`student` (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


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
            (232, '???????????? ?????????2', 40, 12,3 );
            
INSERT INTO CLASS
VALUES      (1, '??????????????????', '?????????', 20, 6, 501),
            (2, '????????????????????????', '?????????', 40, 3, 232),
            (3, '?????????????????????', '?????????', 30, 3, 232),
            (4, '???????????????????????????', '?????????', 20, 3, 424),
            (5, '?????????????????????', '?????????', 40, 3, 230);

INSERT INTO STUDENT
VALUES      (1, '?????????', 'kimhs982@inha.edu', '010-0000-0000', '??????????????????', '12181763', 3),
            (2, '?????????', 'Hong@inha.edu', '010-1234-5678', '??????????????????', '12191234', 3),
            (3, '?????????', 'Charles@inha.edu', '010-2345-6789', '????????????', '12202345', 4),
            (4, '?????????', 'Yeongheui@inha.edu', '010-3456-7890', '????????????', '12213456', 5),
            (5, '?????????', 'Minu@inha.edu', '010-4567-8901', '????????????', '12224567', 1);

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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
