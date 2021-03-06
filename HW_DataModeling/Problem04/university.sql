-- MySQL Script generated by MySQL Workbench
-- 06/18/15 18:31:02
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`Faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Faculties` (
  `Id` INT NOT NULL COMMENT '',
  `Name` VARCHAR(50) NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Departments` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(50) NULL COMMENT '',
  `Faculties_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`, `Faculties_Id`)  COMMENT '',
  INDEX `fk_Departments_Faculties_idx` (`Faculties_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Departments_Faculties`
    FOREIGN KEY (`Faculties_Id`)
    REFERENCES `university`.`Faculties` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Professors` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NULL COMMENT '',
  `Departments_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`, `Departments_Id`)  COMMENT '',
  INDEX `fk_Professors_Departments1_idx` (`Departments_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Professors_Departments1`
    FOREIGN KEY (`Departments_Id`)
    REFERENCES `university`.`Departments` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Titles` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Titles_has_Professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Titles_has_Professors` (
  `Titles_Id` INT NOT NULL COMMENT '',
  `Professors_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Titles_Id`, `Professors_Id`)  COMMENT '',
  INDEX `fk_Titles_has_Professors_Professors1_idx` (`Professors_Id` ASC)  COMMENT '',
  INDEX `fk_Titles_has_Professors_Titles1_idx` (`Titles_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Titles_has_Professors_Titles1`
    FOREIGN KEY (`Titles_Id`)
    REFERENCES `university`.`Titles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Titles_has_Professors_Professors1`
    FOREIGN KEY (`Professors_Id`)
    REFERENCES `university`.`Professors` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Students` (
  `Id` INT NOT NULL COMMENT '',
  `Name` NVARCHAR(45) NOT NULL COMMENT '',
  `Faculties_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`, `Faculties_Id`)  COMMENT '',
  INDEX `fk_Students_Faculties1_idx` (`Faculties_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Students_Faculties1`
    FOREIGN KEY (`Faculties_Id`)
    REFERENCES `university`.`Faculties` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Courses` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(45) NOT NULL COMMENT '',
  `Departments_Id` INT NOT NULL COMMENT '',
  `Professors_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`, `Departments_Id`, `Professors_Id`)  COMMENT '',
  INDEX `fk_Courses_Departments1_idx` (`Departments_Id` ASC)  COMMENT '',
  INDEX `fk_Courses_Professors1_idx` (`Professors_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Courses_Departments1`
    FOREIGN KEY (`Departments_Id`)
    REFERENCES `university`.`Departments` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Courses_Professors1`
    FOREIGN KEY (`Professors_Id`)
    REFERENCES `university`.`Professors` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`Students_has_Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`Students_has_Courses` (
  `Students_Id` INT NOT NULL COMMENT '',
  `Courses_Id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Students_Id`, `Courses_Id`)  COMMENT '',
  INDEX `fk_Students_has_Courses_Courses1_idx` (`Courses_Id` ASC)  COMMENT '',
  INDEX `fk_Students_has_Courses_Students1_idx` (`Students_Id` ASC)  COMMENT '',
  CONSTRAINT `fk_Students_has_Courses_Students1`
    FOREIGN KEY (`Students_Id`)
    REFERENCES `university`.`Students` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Students_has_Courses_Courses1`
    FOREIGN KEY (`Courses_Id`)
    REFERENCES `university`.`Courses` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
