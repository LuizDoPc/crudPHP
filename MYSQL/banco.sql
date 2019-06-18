-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `CPF` CHAR(11) NOT NULL,
  `nomeCliente` VARCHAR(45) NOT NULL,
  `enderecoCliente` VARCHAR(45) NOT NULL,
  `telefoneCliente` VARCHAR(45) NOT NULL,
  `dataNascCliente` DATE NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `chassiVeiculo` VARCHAR(45) NOT NULL,
  `placaVeiculo` VARCHAR(45) NOT NULL,
  `corVeiculo` VARCHAR(45) NOT NULL,
  `marcaVeiculo` VARCHAR(45) NOT NULL,
  `anoVeiculo` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  UNIQUE INDEX `chassiVeiculo_UNIQUE` (`chassiVeiculo` ASC),
  UNIQUE INDEX `placaVeiculo_UNIQUE` (`placaVeiculo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `CPFFuncionario` CHAR(11) NOT NULL,
  `salarioFuncionario` FLOAT NOT NULL,
  `enderecoFuncionario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peca` (
  `idPeca` INT NOT NULL AUTO_INCREMENT,
  `numeroPeca` VARCHAR(45) NOT NULL,
  `valorPeca` FLOAT NOT NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Proprietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Proprietario` (
  `documentoProprietario` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  INDEX `fk_Proprietario_Cliente1_idx` (`Cliente_idCliente` ASC),
  PRIMARY KEY (`Cliente_idCliente`),
  CONSTRAINT `fk_Proprietario_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fonecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fonecedor` (
  `idFonecedor` INT NOT NULL,
  `nomeFornecedor` VARCHAR(45) NOT NULL,
  `CNPJFornecedor` CHAR(14) NOT NULL,
  PRIMARY KEY (`idFonecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fornecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fornecimento` (
  `idFornecimento` INT NOT NULL,
  `qtdeForncimento` FLOAT NOT NULL,
  `dataFornecimento` DATE NOT NULL,
  `Peca_idPeca` INT NOT NULL,
  `Fonecedor_idFonecedor` INT NOT NULL,
  PRIMARY KEY (`idFornecimento`),
  INDEX `fk_Fornecimento_Peca1_idx` (`Peca_idPeca` ASC),
  INDEX `fk_Fornecimento_Fonecedor1_idx` (`Fonecedor_idFonecedor` ASC),
  CONSTRAINT `fk_Fornecimento_Peca1`
    FOREIGN KEY (`Peca_idPeca`)
    REFERENCES `oficina`.`Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecimento_Fonecedor1`
    FOREIGN KEY (`Fonecedor_idFonecedor`)
    REFERENCES `oficina`.`Fonecedor` (`idFonecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Serviço` (
  `idServiço` INT NOT NULL,
  `dataInicioServiço` DATE NOT NULL,
  `dataFimServiço` DATE NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idServiço`),
  INDEX `fk_Serviço_Veiculo1_idx` (`Veiculo_idVeiculo` ASC),
  INDEX `fk_Serviço_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Serviço_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `oficina`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serviço_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fornecimento de Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fornecimento de Serviço` (
  `Fornecimento_idFornecimento` INT NOT NULL,
  `Serviço_idServiço` INT NOT NULL,
  PRIMARY KEY (`Fornecimento_idFornecimento`, `Serviço_idServiço`),
  INDEX `fk_Fornecimento_has_Serviço_Serviço1_idx` (`Serviço_idServiço` ASC),
  INDEX `fk_Fornecimento_has_Serviço_Fornecimento_idx` (`Fornecimento_idFornecimento` ASC),
  CONSTRAINT `fk_Fornecimento_has_Serviço_Fornecimento`
    FOREIGN KEY (`Fornecimento_idFornecimento`)
    REFERENCES `oficina`.`Fornecimento` (`idFornecimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecimento_has_Serviço_Serviço1`
    FOREIGN KEY (`Serviço_idServiço`)
    REFERENCES `oficina`.`Serviço` (`idServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Serviço do Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Serviço do Funcionario` (
  `Serviço_idServiço` INT NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`Serviço_idServiço`, `Funcionario_idFuncionario`),
  INDEX `fk_Serviço_has_Funcionario_Funcionario1_idx` (`Funcionario_idFuncionario` ASC),
  INDEX `fk_Serviço_has_Funcionario_Serviço1_idx` (`Serviço_idServiço` ASC),
  CONSTRAINT `fk_Serviço_has_Funcionario_Serviço1`
    FOREIGN KEY (`Serviço_idServiço`)
    REFERENCES `oficina`.`Serviço` (`idServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serviço_has_Funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `oficina`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Engenheiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Engenheiro` (
  `idEngenheiro` INT UNSIGNED NOT NULL,
  `tipoEngenheiro` VARCHAR(45) NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idEngenheiro`),
  INDEX `fk_Engenheiro_Funcionario1_idx` (`Funcionario_idFuncionario` ASC),
  CONSTRAINT `fk_Engenheiro_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `oficina`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Tecnico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Tecnico` (
  `idTecnico` INT NOT NULL,
  `grauTecnico` VARCHAR(45) NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idTecnico`),
  INDEX `fk_Tecnico_Funcionario1_idx` (`Funcionario_idFuncionario` ASC),
  CONSTRAINT `fk_Tecnico_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `oficina`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
