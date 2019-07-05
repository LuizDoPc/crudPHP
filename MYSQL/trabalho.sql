#Criação de todas as tabelas e de todas as restrições de integridade. Todas as
#restrições de chave (PRIMARY KEY) e de integridade referencial (FOREIGN KEY)
#devem ser criadas. Além disso, crie pelo menos um exemplo com cada uma das
#restrições UNIQUE e DEFAULT;


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


#Exemplos de ALTER TABLE (pelo menos 3 exemplos, envolvendo alterações diversas) e DROP TABLE;
ALTER TABLE `oficina`.`funcionario` ADD COLUMN CPFDependente varchar(10);
ALTER TABLE `oficina`.`funcionario` MODIFY COLUMN CPFDependente varchar(11);
ALTER TABLE `oficina`.`funcionario` DROP COLUMN CPFDependente;
DROP TABLE `oficina`.`cliente`;


#Exemplo de uma inserção de dados em cada uma das tabelas. Para testar o trabalho,
#recomenda-se inserir dezenas de registros em cada tabela. Mostre esses dados na
#apresentação do trabalho;

-- Inserting data into table cliente
--
INSERT INTO cliente(idCliente, CPF, nomeCliente, enderecoCliente, telefoneCliente, dataNascCliente) VALUES
(1, '00A848KWUQ7', 'WCC9', 'J', 'W', '2014-09-25'),
(2, '6', '4WA7S7', 'K1', 'X2706O1', '2005-08-19'),
(3, '12T', '0', 'E', 'H', '2019-06-26'),
(4, 'FSS1374T7U1', 'J', '7U', 'VS83MC9P3BR3', '1989-09-17'),
(5, '08L', '6O3', 'KXI', 'BMO', '2000-09-07'),
(6, 'B4PMCU', '9DF', '020499C3L1XC', '0MN8A59YZ2', '2005-08-20'),
(7, '2', 'L8', 'DT358', 'Y171', '1971-03-09'),
(8, 'V', '5', '9R8A', '1P', '2009-10-15'),
(9, '71', 'PU7', '3Q683084', 'X', '2014-09-26'),
(10, 'IOJ', '7823H9ANM99OGB57T081J041U61', '6YQV498J6', 'B7', '1976-02-19'),
(11, '32X90964X5P', '10', 'UH', 'KD3625J', '2000-09-08'),
(12, '66', '27H', 'K9W', 'HH7X23XN9T6621N637K081394X5', '2009-10-16'),
(13, '3', 'EV1F47A9', '61M31M43A80', '1', '2014-09-27'),
(14, '27', '5B5', 'W2K742SJG', 'O050S', '1971-03-10'),
(15, '4Y7E8W7R', 'BNIL10U9', '15W8I1ZC4', 'S', '1991-05-06'),
(16, 'H', 'M5186E4J63SE', 'DTB', '0S795ACBY2M', '1976-02-20'),
(17, 'C', 'JZC5016J29XU2', 'XB', 'U7', '2005-08-21'),
(18, 'C5M970G3PJQ', '8', 'B720206WQ19D2VYC568N45PIGRU7X', '3A44', '1996-04-17'),
(19, 'X', '7N8G8H737987', 'B39F0R', 'SNV4H2K0', '2000-09-09'),
(20, '6V', '1K9B7192931C56Z', 'PBC50', 'JYE4TU831', '1984-10-06'),
(21, 'KJ12T6S', 'ADG8', 'SN', 'GG', '2005-08-22'),
(22, '09D', '1848Q', 'UKX6', '8M', '1971-03-11'),
(23, '7J', '24', 'XZ844H5', '3S34F9A4ISS78', '1991-05-07'),
(24, 'HN4N3U', '4M66', '357Z', 'EHT841', '1989-09-18'),
(25, 'S', 'K86', '68675SL8048', 'YU1047J', '2009-10-17'),
(26, 'D7', '8LQ07I2OL8V', '2D6O', 'D', '1996-04-18'),
(27, '1', '7KG0Z569M8843208ADSK90R7TA8J', '0Z', '0PECZ89', '2014-09-28'),
(28, '4', '7F1B9Z26Z41K16G4H', '2TDNV487', '23R4S69YN96L0461SFG', '2009-10-18'),
(29, 'W5147W', 'WJQ6', '9', '8IOA7E6T104R82AWIM320W', '2000-09-10'),
(30, '6N31GJ9', 'T', '24N', '875HA47YMBP1H3C1HF', '1976-02-21'),
(31, '9H', 'V8QBV8D', 'J917VZ', 'R', '1991-05-08'),
(32, 'T2W', '5XVJ114IN', '2I910YC4156S94S7QQ7S00', 'V2FAOF1AU7OCEB3', '1996-04-19'),
(33, '39O2QGSX', '5N5TX32', 'U2V4I3HJ1', '6', '1991-05-09'),
(34, '55M', 'M78', '0Z0PZ', '759Y4T17Q85', '2005-08-23'),
(35, 'D8WQ4V48JVF', 'K11Z5WU56W004GA', '47CCJB393N37', '38XX0', '2000-09-11'),
(36, '95W4', '8YD', 'XS5', '9VN059QY', '1971-03-12'),
(37, 'CL4', 'CJU98056Q810VMJZY88098W937ISU6', 'YG8IO8X3', 'V47K7', '2005-08-24'),
(38, '23', '48FJ9AGBQ7GY16Y4', 'UCNSYJI7JTB7S3S', 'EC4YH7K7', '1984-10-07'),
(39, 'I', 'NXVP6UL3M29', '25B4C8B2C10', '6B6', '1989-09-19'),
(40, '7H', 'I6', 'W', '2', '1996-04-20'),
(41, 'DXG', '9UV592K5OF0AD45', 'VLFM1I6DU78N99C48EM150C9', '8NVR', '1976-02-22'),
(42, '4MZ3F49IISY', 'J604NYT', '4', 'A1G71H61JK9C14Q299Y73', '2014-09-29'),
(43, '0', '69A60', 'I0NLD7198', '72', '1991-05-10'),
(44, '59MTLU99', '8VA8N54', 'VV28Q9T', 'R45853DO6BGB8HME7344', '1996-04-21'),
(45, '367', 'X', '19B375C45RWB6SNZ822F6', '15', '2000-09-12'),
(46, 'KD9216JD8V', 'T3FQ9H75H', '553HV5ZR', 'UE7U0', '1991-05-11'),
(47, 'U8', '7E', '5NCU72KE690336ZID8IUDDO9G759W5ITJC0JTOWFM8DKS', 'V9', '1971-03-13'),
(48, '0I57QU41H49', '5IBH6213E3XBTJ164', 'F72J43YV0D', '13MI', '2005-08-25'),
(49, 'EG', 'NMT', 'JZZ9BOAPI982ALJ7', '7S', '2009-10-19'),
(50, '25ER579', '2A816IQ6M8WP0ZB1', '8785', 'DE567O5E2R7VQED78Z14', '2000-09-13');

--
-- Inserting data into table fonecedor
--
INSERT INTO fonecedor(idFonecedor, nomeFornecedor, CNPJFornecedor) VALUES
(1, 'LQYL88117Q37260178C277', 'K18TQ71'),
(2, 'YL63L', 'R12'),
(3, '8Q10S', '7Y96'),
(4, '0', 'A0CED'),
(5, 'Y', '6HJ'),
(6, '0K', '1Y5ZP9'),
(7, '1', '4J8170'),
(8, '7P048', 'Z'),
(9, '84CSE65', 'A9K25Y'),
(10, '7I7K77729', 'E7FA37P9V'),
(11, '4K', 'UWH5L8N'),
(12, 'G22', '46ZQ2'),
(13, '0Y93', '0C18'),
(14, 'H', '23453S'),
(15, '712277SO5H7U1N2C', '5MU64S1LO'),
(16, '3DQ', '2MO7'),
(17, '41Y2PCV6', 'P'),
(18, '8G', '2801'),
(19, 'T52NU1', '28A1'),
(20, '03W', 'UZJ72'),
(21, 'CYQY67', '54E9H'),
(22, 'F1J816R', '52'),
(23, '2OS0', '8'),
(24, '9X1E', '3S4PV20VB167A0'),
(25, 'X', '6'),
(26, 'GIN', 'C'),
(27, '1I62B129PWJ', 'EN'),
(28, '9T16F6Z4MM2Y2274', '4ZA9C75QXIS1'),
(29, 'XTHB', '1E'),
(30, 'C55U', 'C8'),
(31, '80VBJ', '1N9'),
(32, '1T3PX', 'V'),
(33, 'PRN3', 'J'),
(34, 'ET0405', 'T23'),
(35, 'DY0', '45UE'),
(36, '65', 'L'),
(37, '09971', '5S26'),
(38, 'BT', 'J20L3W'),
(39, 'NNPOZ7K4', '925'),
(40, 'VB', '9'),
(41, 'MB3ZTO', '0LF2G8TPV7P055'),
(42, '5D', '960HM'),
(43, '3SV', '32'),
(44, 'T5X7WC7O899J5M8', '0D2B3VKHR0O'),
(45, 'N', '019TRJ1FAP1S'),
(46, 'WDYE2C', 'D9A'),
(47, 'R2K40959', 'HX'),
(48, 'KJEU16196X8641', 'UUM81NB3'),
(49, '6PT', 'XX54203'),
(50, '2Z44J52', 'SV');

--
-- Inserting data into table funcionario
--
INSERT INTO funcionario(idFuncionario, CPFFuncionario, salarioFuncionario, enderecoFuncionario) VALUES
(1, '81K27', 4628187, '7UF5D'),
(2, '080VO', 7044037, '851'),
(3, 'K', -6899975, 'DK746KNPD'),
(4, '80', -939537, 'JN74QR3F1'),
(5, 'VQ9IPA1WHF1', 2628187, 'LI'),
(6, '286K', 1060464, 'VI81BQ8GF'),
(7, 'SW', 9044035, '2EY2S6YFRML83Y83QH'),
(8, 'F', -3923246, 'R6VW9'),
(9, 'V08', -5923246, '05K8'),
(10, 'UG', 4628188, '7Q'),
(11, '26Y9KX9', -3923245, 'Q5A'),
(12, '8', 7044038, 'PR1896N763L2070T'),
(13, '98', -8899975, 'OTW05L6I'),
(14, 'T', -939536, '5V29'),
(15, '1', 2628188, '82CZ3LAMZE3VQQD002EK'),
(16, '2', 9044036, '770S4W3917941KL'),
(17, 'XY', -6899974, '00865Q4'),
(18, 'J2Z4W71W7F', 1060465, '44G6O4RQESL1VCJ2CRTK'),
(19, '1W9U2T', -939535, 'KF'),
(20, 'K65Z', 7044039, '132167'),
(21, '33DMMT', 1060466, 'B'),
(22, 'DC', -5923245, '4TVZG4T1'),
(23, 'RO53', 9044037, '8XG7E3950TZPV'),
(24, '5B87', 4628189, '6'),
(25, '1I', -939534, 'U09B4O85'),
(26, 'OOWU1Z877SI', 2628189, '35DM'),
(27, '4', -3923244, 'N'),
(28, '786', -5923244, '4R75O'),
(29, 'V8', -8899974, 'FIEN145W1G'),
(30, '30X', -6899973, '478Y1QE11'),
(31, 'RE86', 7044040, 'L19X1C'),
(32, '1P', -8899973, '97X'),
(33, '8D3096', 1060467, '45O5'),
(34, 'RT335', -939533, '9B44TDF2'),
(35, '078DK9', -3923243, '33U0LH'),
(36, '3X114', 9044038, '449V9PC23'),
(37, '76O4XJ0J8LK', 1060468, 'Y49T15T'),
(38, 'W', 4628190, '87T88Z9'),
(39, '52F', -939532, 'V'),
(40, 'MZ', 7044041, 'C7'),
(41, '9', -6899972, '9'),
(42, '94049B', 9044039, 'DM7F20F30R98128127R5MQ4'),
(43, '899', -5923243, '9I459ZL'),
(44, '60BX', 2628190, 'Y25963W140'),
(45, '11FG', -3923242, 'IZ'),
(46, 'H4083D8MF55', -5923242, 'MSP'),
(47, '2999IV0SKT1', -8899972, 'TY1'),
(48, 'KQJNZ', 1060469, '6X7LA9YEUP6AX'),
(49, 'K0J', -6899971, '9LW8MMN7RLVYB01XP0CN'),
(50, 'E', -8899971, 'J77Q16XT');

--
-- Inserting data into table peca
--
INSERT INTO peca(idPeca, numeroPeca, valorPeca) VALUES
(1, '16153', -4455986),
(2, '08545', 5042690),
(3, '07564', -67),
(4, '17759', 6006989),
(5, '38357', -2455985),
(6, '54611', 8006987),
(7, '43408', -4455985),
(8, '89927', 1999934),
(9, '34510', -66),
(10, '27379', -6049579),
(11, '05932', 1999935),
(12, '08756', -65),
(13, '53246', 1999936),
(14, '47420', -64),
(15, '14585', -8049579),
(16, '91266', 6006990),
(17, '03732', -6049578),
(18, '39158', -2455984),
(19, '79960', 3042690),
(20, '73960', 5042691),
(21, '77891', 3042691),
(22, '12971', -4455984),
(23, '81470', 1999937),
(24, '84567', -2455983),
(25, '28421', -8049578),
(26, '43101', -6049577),
(27, '67522', -8049577),
(28, '68850', -63),
(29, '01366', -4455983),
(30, '43314', -6049576),
(31, '06621', -8049576),
(32, '06849', 5042692),
(33, '63370', 1999938),
(34, '02933', -2455982),
(35, '69192', -6049575),
(36, '42679', 3042692),
(37, '07851', -8049575),
(38, '01685', 8006988),
(39, '59890', 6006991),
(40, '71572', -62),
(41, '55848', 8006989),
(42, '30158', -4455982),
(43, '73551', -6049574),
(44, '18648', -8049574),
(45, '39804', -2455981),
(46, '30248', 1999939),
(47, '30134', 6006992),
(48, '94055', -6049573),
(49, '72440', -61),
(50, '58278', 8006990);

--
-- Inserting data into table veiculo
--
INSERT INTO veiculo(idVeiculo, chassiVeiculo, placaVeiculo, corVeiculo, marcaVeiculo, anoVeiculo) VALUES
(1, 'J7O4', 'U58', '1', '9YSKD13P', 2147483647),
(2, 'SDQ909K', '14Y10P8I3V', 'JAE', '571DBG8O2', 910594429),
(3, 'H24A9SH', '3M', 'S702', 'KNRFP5MM88Q16DKVD', -2093373739),
(4, '2N', 'MM', 'AS', 'JEY188398FL63O55B423', -867555513),
(5, '7', '9PXR92938P281O9D7KQ4CDX7INE5N', 'CE30K', 'OU4', -321447601),
(6, 'OM', '7L', '51', 'M4', 1690682324),
(7, 'S8T1737', '76', 'X667OW002', '5', -1663877008),
(8, 'MHVQG4229L3Z8BWM29QV2Q4WO93RV', '6WE17AV0', 'WJ0QY', '7S25CF6HW', 108049130),
(9, 'U', '46', 'BI0QP30249HX668', 'J6GL9', -321447600),
(10, '5Q1G7355TEP3B', '01K5', 'K5L9', 'R1', 108049131),
(11, '6XC3D6PA844', 'M9Q3XZMK7VL6OHN5Z074823A59W26998D1T9', 'F25Q1', '515Q', 2120179050),
(12, 'LPCUQM', 'OGAG1', 'QJX', '05', -438058782),
(13, 'X5RC5MW0Q', 'FTARJG7GGF84DR7R0D', '0DF3Z9H34TSU2TQ12G51U', 'A', 1690682325),
(14, '016KLE', '7R73664124D4XZE42Z400T45V04I697', 'RHP85081O', '59CUI7GQLLCGLP1N91VRL022B9GB966K2', 2120179051),
(15, 'J35J', 'T1Z4IC', 'BAC6YS', 'JV', 481097699),
(16, 'WSI308U0R7ZI3', 'DY6608C', 'D4C4', '2D236097F82N02', 910594430),
(17, 'P1', 'QDSVI8', '1LGX2', 'Y96', -321447599),
(18, '6857Q353423LJ4', 'SR0', '7', '8', -867555512),
(19, '9E', '2B839N914WOP', '4869', 'AT0PFE6MJ8I43IWO', -2093373738),
(20, 'XXO', '87QE7Y9', 'GJSS6MFM', 'BXZ0', 481097700),
(21, 'PE6QA71O', 'O362', '1P34N', '8U65B5', 108049132),
(22, '4', 'HC3S2I3', 'QU3PG', '7A', -321447598),
(23, 'F', '5F1H8', 'V', 'K53M3Y91', -1663877007),
(24, '413WGH2', 'BKLCN328Z8', 'NHQ0T', 'W0X7Q', -438058781),
(25, '986IY6L13PZI7', 'QVGTE', '5HGC', 'YFB4', 1690682326),
(26, 'UHK403VB', 'K07S9HM64XQ3AT1', 'W', '0S6D9', -867555511),
(27, 'NNFPNFOG4', '937', 'FL', 'VZ3131BG7', 108049133),
(28, 'JI', '8PX9H8Q', '6VK26M9Z470MI', '5L', 2120179052),
(29, 'K63S4Y3LY', '0', '431', '94IE73', 910594431),
(30, 'WP023', 'N', '8M645677H', '44H9M', -438058780),
(31, '8ZNG8', '79P7T7DGDQX61F', '0', '6I37NL', 481097701),
(32, '03P', 'JJ5TM', '44M5EL6E789', '051U8YH0JIFQD7AV284', 910594432),
(33, 'BP3H', '88VL0Y552', '5', '1', 481097702),
(34, '234K', '6', '4G2R3L5QU95', '3SHEB24HP109I7ZDUE4PT3O360', 910594433),
(35, '3JG8689', 'M4HV', '4D705VV', '16S87G0W0F7K', -867555510),
(36, 'XAESUZ1DT0F65TV5U', '5N4C55', 'SYV1HYM', 'Z73ON3', -438058779),
(37, '49RMV2535', 'PXVUF4N', 'O', 'G04UF4', -321447597),
(38, 'OD08N473G4K3', 'M9O5WJR', '8I2U9', '0', 481097703),
(39, 'B091V2', 'O3V2W5W22K09Y0JGE365KL2Z6KDFE', '8', '81O31DF8J1P85MFY0BZ', 910594434),
(40, 'V28Y16H5Q1Q6UFPSO78VQ0CU3', 'C20', '32', '7X9H9N1R', -2093373737),
(41, '10', 'F847JE1', 'TXB', 'CW6V64K0T12Q4', 1690682327),
(42, '3K7', '7', '2X50', 'U8TK8', -867555509),
(43, '027ZC4P4026M', '2', 'QC', 'T26', -438058778),
(44, 'B1H2', 'EBE4D6Z93G', 'D2F', '3DP', 2120179053),
(45, '8', '6KV9', 'E71', 'A5DAWH246', 108049134),
(46, '55R8U7R1X7SA', 'OOA5SW1P9', '6K1IDTIB', '9YF9C9A109XDVE73EH82', 481097704),
(47, 'SOU2', '152JGT125', '9', '99AA9ZEQQ1Z01ZWM', 910594435),
(48, 'H', '0F', '37H59C', 'EB2S6', -1663877006),
(49, 'YHJ9Y7NAKN8V9D67651R9478E6N', 'O3AU42', '829OKH7475X5TONBSZP9CRN53S6FO5HG570H10C', '54K3JD8', -867555508),
(50, '81R', '7EG1', 'NN85DA52U8WEC9X2925', '6K35N535NOYCK', 481097705);

--
-- Inserting data into table fornecimento
--
INSERT INTO fornecimento(idFornecimento, qtdeForncimento, dataFornecimento, Peca_idPeca, Fonecedor_idFonecedor) VALUES
(1, -1095500, '2003-04-22', 35, 23),
(2, 2865363, '1988-02-07', 50, 22),
(3, 4865364, '1983-02-26', 46, 17),
(4, 6554348, '2010-03-14', 22, 12),
(5, 8554346, '2019-06-26', 5, 43),
(6, 2865364, '1996-08-24', 11, 47),
(7, 4865365, '1974-05-05', 24, 29),
(8, -7736135, '2008-04-03', 49, 38),
(9, -9736135, '1991-09-13', 17, 4),
(10, -7736134, '1979-04-17', 12, 24),
(11, 6554349, '2015-02-23', 18, 30),
(12, 904501, '2010-03-15', 30, 45),
(13, -9736134, '2003-04-23', 6, 10),
(14, 8554347, '2015-02-24', 41, 18),
(15, -7736133, '1988-02-08', 1, 50),
(16, -1095499, '2010-03-16', 47, 25),
(17, -9736133, '2015-02-25', 25, 48),
(18, -5654805, '2010-03-17', 36, 46),
(19, -7736132, '2008-04-04', 7, 49),
(20, -9736132, '1983-02-27', 42, 44),
(21, -7736131, '1988-02-09', 45, 39),
(22, 2865365, '1996-08-25', 37, 34),
(23, -3654804, '2003-04-24', 31, 5),
(24, -5654804, '1991-09-14', 2, 11),
(25, 6554350, '1974-05-06', 43, 31),
(26, 4865366, '1983-02-28', 8, 26),
(27, 8554348, '2015-02-26', 48, 13),
(28, 904502, '1996-08-26', 3, 6),
(29, -3654803, '2008-04-05', 26, 1),
(30, -9736131, '2010-03-18', 13, 7),
(31, 6554351, '2015-02-27', 19, 32),
(32, 2865366, '1988-02-10', 14, 40),
(33, -7736130, '1983-03-01', 20, 19),
(34, -9736130, '1979-04-18', 38, 35),
(35, -5654803, '1988-02-11', 9, 41),
(36, -3654802, '2003-04-25', 4, 2),
(37, -1095498, '1974-05-07', 32, 27),
(38, -5654802, '1983-03-02', 27, 36),
(39, 4865367, '1988-02-12', 33, 42),
(40, 904503, '1983-03-03', 10, 8),
(41, -3654801, '2008-04-06', 28, 3),
(42, -5654801, '2010-03-19', 15, 33),
(43, -3654800, '1991-09-15', 44, 37),
(44, 2865367, '1979-04-19', 21, 28),
(45, -7736129, '1996-08-27', 23, 14),
(46, 8554349, '1991-09-16', 29, 9),
(47, -1095497, '2003-04-26', 16, 20),
(48, 6554352, '1974-05-08', 39, 15),
(49, 8554350, '2015-02-28', 34, 21),
(50, 4865368, '2008-04-07', 40, 16);

--
-- Inserting data into table serviço
--
INSERT INTO serviço(idServiço, dataInicioServiço, dataFimServiço, Veiculo_idVeiculo, Cliente_idCliente) VALUES
(1, '1993-12-29', '2007-01-17', 47, 37),
(2, '1998-12-11', '1995-05-23', 9, 32),
(3, '2010-12-14', '2002-02-05', 18, 50),
(4, '1970-02-24', '1976-01-30', 4, 14),
(5, '2003-01-14', '2007-01-18', 28, 43),
(6, '1975-02-06', '2019-06-26', 50, 5),
(7, '1980-12-04', '1971-02-18', 45, 38),
(8, '2015-11-25', '2002-02-06', 48, 49),
(9, '1970-02-25', '2009-09-17', 46, 27),
(10, '1975-02-07', '1990-06-11', 23, 20),
(11, '2019-06-26', '2014-08-29', 13, 15),
(12, '1993-12-30', '1995-05-24', 19, 47),
(13, '2010-12-15', '2007-01-19', 42, 45),
(14, '2007-12-27', '1976-01-31', 14, 33),
(15, '1998-12-12', '1990-06-12', 20, 28),
(16, '1985-11-16', '1971-02-19', 49, 48),
(17, '2015-11-26', '1985-02-11', 15, 44),
(18, '1993-12-31', '2009-09-18', 37, 46),
(19, '1970-02-26', '1995-05-25', 43, 23),
(20, '1975-02-08', '1990-06-13', 21, 21),
(21, '1970-02-27', '2002-02-07', 29, 29),
(22, '1998-12-13', '1980-03-02', 38, 16),
(23, '1994-01-01', '2007-01-20', 10, 11),
(24, '2003-01-15', '1976-02-01', 16, 39),
(25, '1980-12-05', '1971-02-20', 5, 24),
(26, '1985-11-17', '2014-08-30', 11, 34),
(27, '1980-12-06', '1976-02-02', 24, 30),
(28, '1985-11-18', '2002-02-08', 30, 22),
(29, '2010-12-16', '1971-02-21', 25, 25),
(30, '1998-12-14', '1995-05-26', 22, 6),
(31, '2007-12-28', '1976-02-03', 44, 17),
(32, '1980-12-07', '2009-09-19', 6, 31),
(33, '2015-11-27', '1985-02-12', 31, 12),
(34, '2003-01-16', '1980-03-03', 39, 26),
(35, '1994-01-02', '1985-02-13', 26, 1),
(36, '1998-12-15', '2014-08-31', 32, 7),
(37, '1985-11-19', '1980-03-04', 17, 18),
(38, '1975-02-09', '1971-02-22', 12, 13),
(39, '1970-02-28', '1990-06-14', 1, 40),
(40, '1980-12-08', '1985-02-14', 34, 19),
(41, '1975-02-10', '1995-05-27', 40, 35),
(42, '1994-01-03', '2009-09-20', 27, 2),
(43, '1998-12-16', '1976-02-04', 33, 41),
(44, '2007-12-29', '1971-02-23', 7, 8),
(45, '1985-11-20', '2007-01-21', 35, 36),
(46, '1994-01-04', '2002-02-09', 41, 42),
(47, '2010-12-17', '1990-06-15', 36, 3),
(48, '1970-03-01', '2014-09-01', 2, 9),
(49, '1980-12-09', '1995-05-28', 8, 4),
(50, '1998-12-17', NULL, 3, 10);

--
-- Inserting data into table engenheiro
--
INSERT INTO engenheiro(idEngenheiro, tipoEngenheiro, Funcionario_idFuncionario) VALUES
(1, '7782C8B87X1465', 30),
(2, 'AOEX9BT4SCUB3L', 8),
(3, '18', 50),
(4, '3RVH', 25),
(5, '4S721J', 3),
(6, 'C7168QI', 9),
(7, '94TW515', 31),
(8, 'NK8B5V0D8', 39),
(9, '2IUATN', 45),
(10, '3NYN', 48),
(11, 'B1J842N', 46),
(12, 'H3VM9EZI41', 22),
(13, 'K362Y', 26),
(14, 'HCZ9W09I', 4),
(15, 'H6', 17),
(16, '3', 32),
(17, 'MN2CHL', 27),
(18, 'B1', 33),
(19, '0CQ2QW1', 34),
(20, 'R', 40),
(21, '6', 12),
(22, 'XV9ND', 10),
(23, 'BN5MQNA6N', 28),
(24, 'F', 5),
(25, 'P3M', 18),
(26, 'W1', 11),
(27, 'EF89', 49),
(28, '7LN', 35),
(29, '7YI2452P541O3FO4423VHZP', 23),
(30, '9', 47),
(31, 'YU', 6),
(32, '39', 1),
(33, 'YN', 41),
(34, '393JM7E', 13),
(35, 'RD2C2X0MP2', 7),
(36, 'V9LF8', 36),
(37, 'T7J99', 2),
(38, 'O', 42),
(39, '5URS7', 29),
(40, '98E', 24),
(41, 'P', 19),
(42, 'L4', 14),
(43, '363695B1', 20),
(44, 'V7IO590K0460J77J2H', 37),
(45, '384YV', 43),
(46, '92S', 15),
(47, 'KTJM2', 38),
(48, 'Y0GRPI32O', 44),
(49, '53I', 21),
(50, 'PM4', 16);

--
-- Inserting data into table `fornecimento de serviço`
--
INSERT INTO `fornecimento de serviço`(Fornecimento_idFornecimento, Serviço_idServiço) VALUES
(47, 47),
(9, 9),
(18, 18),
(4, 4),
(28, 28),
(50, 50),
(45, 45),
(48, 48),
(46, 46),
(23, 23),
(13, 13),
(19, 19),
(42, 42),
(14, 14),
(20, 20),
(49, 49),
(15, 15),
(37, 37),
(43, 43),
(21, 21),
(29, 29),
(38, 38),
(10, 10),
(16, 16),
(5, 5),
(11, 11),
(24, 24),
(30, 30),
(25, 25),
(22, 22),
(44, 44),
(6, 6),
(31, 31),
(39, 39),
(26, 26),
(32, 32),
(17, 17),
(12, 12),
(1, 1),
(34, 34),
(40, 40),
(27, 27),
(33, 33),
(7, 7),
(35, 35),
(41, 41),
(36, 36),
(2, 2),
(8, 8),
(3, 3);

--
-- Inserting data into table proprietario
--
INSERT INTO proprietario(Cliente_idCliente, documentoProprietario) VALUES
(10, '0P09Z3X50'),
(50, 'TY6H2K0'),
(47, 'H'),
(45, '3Z'),
(5, '4W4I7EM'),
(33, '000C46C9'),
(42, 'C0'),
(37, 'CJ8MNU94'),
(21, 'T'),
(11, 'O16'),
(28, '8'),
(23, 'EWDMWP5TL8GTXYZHQ17374W8HKY'),
(29, 'NK6Q'),
(6, 'Y5X8CF9AWM8Z42UI13ZZ8EF'),
(1, '97NV594X8XLE0279EO'),
(43, 'J88B4M0GA'),
(48, 'Y16GG'),
(24, 'IRH0Q998O'),
(46, 'WB48BN7D8K'),
(49, 'YQ59V3707DN'),
(38, '8L9'),
(16, 'BP'),
(44, '4MU50CQ8KZ5T1PIQ95O'),
(7, '2YVBMJ8XKEONVT9K00'),
(39, '5P3I'),
(30, 'M'),
(22, 'Q'),
(2, 'PLWFIU3U497T'),
(34, 'Y4'),
(25, 'LM0ZBG4F3'),
(17, 'A'),
(31, '680SLWJ4P817O5N8'),
(8, '8SM'),
(40, '2A'),
(35, 'HV85QWTG5A374A'),
(26, 'KXPFD'),
(12, '0B55U4JEUG71W9V'),
(3, '2R24H33Q'),
(32, '5D7E'),
(9, '38T82LZAI7V9283S25O7V'),
(18, '1'),
(13, 'Y56X2LQT6E434V'),
(4, 'KC32RU627SE'),
(41, '6SHQ'),
(36, '9'),
(19, 'P'),
(27, '922'),
(14, 'U9VCKT7S273WBPMA1W0'),
(20, '82T42X'),
(15, 'Q6M40MQWS');

--
-- Inserting data into table `serviço do funcionario`
--
INSERT INTO `serviço do funcionario`(Serviço_idServiço, Funcionario_idFuncionario) VALUES
(47, 47),
(9, 9),
(18, 18),
(4, 4),
(28, 28),
(50, 50),
(45, 45),
(48, 48),
(46, 46),
(23, 23),
(13, 13),
(19, 19),
(42, 42),
(14, 14),
(20, 20),
(49, 49),
(15, 15),
(37, 37),
(43, 43),
(21, 21),
(29, 29),
(38, 38),
(10, 10),
(16, 16),
(5, 5),
(11, 11),
(24, 24),
(30, 30),
(25, 25),
(22, 22),
(44, 44),
(6, 6),
(31, 31),
(39, 39),
(26, 26),
(32, 32),
(17, 17),
(12, 12),
(1, 1),
(34, 34),
(40, 40),
(27, 27),
(33, 33),
(7, 7),
(35, 35),
(41, 41),
(36, 36),
(2, 2),
(8, 8),
(3, 3);

--
-- Inserting data into table tecnico
--
INSERT INTO tecnico(idTecnico, grauTecnico, Funcionario_idFuncionario) VALUES
(1, '8641HE7A', 50),
(2, 'FW1', 19),
(3, 'VJL1C8EW4G', 41),
(4, '313H54Y2', 36),
(5, 'K', 33),
(6, 'S', 28),
(7, 'CNS345E1', 6),
(8, '8HO37B', 47),
(9, 'G3102I', 1),
(10, 'HOR3I08', 42),
(11, 'NG1', 37),
(12, '9O', 7),
(13, 'TQ1UP2XZ', 23),
(14, '92II0', 2),
(15, 'A', 29),
(16, '3', 14),
(17, 'A030A', 43),
(18, 'TP86N', 8),
(19, 'U486W484M2KCO2TGQWZCR4JV97G1AJ', 45),
(20, 'X2F7S12EN', 48),
(21, '290K5625VQ8', 38),
(22, 'Q4DVLE6VW3SQS08TF83E36V5', 24),
(23, 'YV', 20),
(24, 'Y4U5D4K5', 3),
(25, 'W', 15),
(26, '99L410', 44),
(27, 'F6W', 46),
(28, 'IXY3909IQ2UYBZCG', 21),
(29, 'C', 16),
(30, 'KYS', 49),
(31, 'B12NR3EWW5YZY96', 22),
(32, '2VS2OH65', 39),
(33, '4XM935QV0C', 9),
(34, '5LL0A3T5U24RKU06Y693', 4),
(35, 'M352', 10),
(36, 'K9TL6LSN', 34),
(37, 'RAMDQ2465806422575', 30),
(38, '5Z55', 17),
(39, 'V2V77UNNYXU7RG723X9', 5),
(40, 'X0544NF0', 12),
(41, '796IK0J', 40),
(42, 'IR18X', 11),
(43, '6Q0ZI36S4H', 18),
(44, '2WM41B7WT68NA33734L875IS7BYJ', 35),
(45, '94QB4ANL', 25),
(46, 'S2791H2995304250', 13),
(47, '49Q1XT', 31),
(48, '4TUG1B', 26),
(49, 'E951', 32),
(50, 'Z470L8PH', 27);


#Exemplos de modificação de dados em 5 tabelas. Mostre pelo menos um exemplo
#com UPDATE aninhado, envolvendo mais de uma tabela;
UPDATE `oficina`.`Proprietario` SET `documentoProprietario` = "INVALIDO" WHERE `Cliente_idCliente` IN (SELECT `idCliente` FROM `oficina`.`Cliente` WHERE `dataNascCliente` > '2000-06-28');
UPDATE `oficina`.`Cliente` SET `nomeCliente` = "Luiz Soares" WHERE `idCliente` = 7;
UPDATE `oficina`.`Veiculo` SET `corVeiculo` = "Salmão de inverno" WHERE `idVeiculo` = 7;
UPDATE `oficina`.`Funcionario` SET `salarioFuncionario` = 7000 WHERE `idFuncionario` = 7;
UPDATE `oficina`.`Peca` SET `valorPeca` = 100 WHERE `idPeca` = 7;


#Exemplos de exclusão de dados em 5 tabelas. Mostre pelo menos um exemplo com
#DELETE aninhado, envolvendo mais de uma tabela;
DELETE FROM `oficina`.`Fornecimento de Serviço` WHERE `Serviço_idServiço` IN (SELECT `idServiço` FROM `oficina`.`Serviço` WHERE `Cliente_idCliente`= 7);
DELETE FROM `oficina`.`Serviço do Funcionario` WHERE `Funcionario_idFuncionario` = 7;
DELETE FROM `oficina`.`Engenheiro` WHERE `idEngenheiro` = 7;
DELETE FROM `oficina`.`Tecnico` WHERE `idTecnico` = 7;
DELETE FROM `oficina`.`Fornecimento` WHERE `dataFornecimento` < '1974-05-05';
