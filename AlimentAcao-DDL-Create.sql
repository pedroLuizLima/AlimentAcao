-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AlimentAcao
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AlimentAcao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AlimentAcao` DEFAULT CHARACTER SET utf8 ;
USE `AlimentAcao` ;

-- -----------------------------------------------------
-- Table `AlimentAcao`.`Doador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`Doador` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `telefone` VARCHAR(14) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`enderecoDoador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`enderecoDoador` (
  `cep` VARCHAR(9) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `Doador_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Doador_CPF`),
  CONSTRAINT `fk_enderecoDoador_Doador`
    FOREIGN KEY (`Doador_CPF`)
    REFERENCES `AlimentAcao`.`Doador` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`redesSociaisDoador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`redesSociaisDoador` (
  `redeSocial` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `Doador_CPF` VARCHAR(14) NOT NULL,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_redesSociaisDoador_Doador1_idx` (`Doador_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_redesSociaisDoador_Doador1`
    FOREIGN KEY (`Doador_CPF`)
    REFERENCES `AlimentAcao`.`Doador` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`doacaoAnonima`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`doacaoAnonima` (
  `idDoacaoAnonima` INT NOT NULL AUTO_INCREMENT,
  `dataDoacao` DATE NOT NULL,
  `pesoTotal(kg)` INT(5) ZEROFILL NOT NULL,
  `condicaoDeRetirada` VARCHAR(45) NOT NULL,
  `Doador_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idDoacaoAnonima`),
  INDEX `fk_doacaoAnonima_Doador1_idx` (`Doador_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_doacaoAnonima_Doador1`
    FOREIGN KEY (`Doador_CPF`)
    REFERENCES `AlimentAcao`.`Doador` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`ONG/Instituicao/Igreja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`ONG/Instituicao/Igreja` (
  `CNPJ` VARCHAR(18) NOT NULL,
  `nomeInstituicao` VARCHAR(100) NOT NULL,
  `nomeResponsavel` VARCHAR(100) NOT NULL,
  `tipoInstituicao` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(14) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `numBeneficiarios` INT(5) ZEROFILL NOT NULL,
  `horaDeAbertura` TIME NOT NULL,
  `horaDeFechamento` TIME NOT NULL,
  PRIMARY KEY (`CNPJ`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  UNIQUE INDEX `nomeInstituicao_UNIQUE` (`nomeInstituicao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`doacaoEspecifica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`doacaoEspecifica` (
  `idDoacaoEspecifica` INT NOT NULL AUTO_INCREMENT,
  `dataDoacao` DATE NOT NULL,
  `pesoTotal(kg)` INT(5) ZEROFILL NOT NULL,
  `condicaoDeRetirada` VARCHAR(45) NOT NULL,
  `metodoDeEntrega` VARCHAR(45) NOT NULL,
  `Doador_CPF` VARCHAR(14) NOT NULL,
  `ONG/Instituicao/Igreja_CNPJ` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`idDoacaoEspecifica`),
  INDEX `fk_doacaoEspecifica_Doador1_idx` (`Doador_CPF` ASC) VISIBLE,
  INDEX `fk_doacaoEspecifica_ONG/Instituicao/Igreja1_idx` (`ONG/Instituicao/Igreja_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_doacaoEspecifica_Doador1`
    FOREIGN KEY (`Doador_CPF`)
    REFERENCES `AlimentAcao`.`Doador` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doacaoEspecifica_ONG/Instituicao/Igreja1`
    FOREIGN KEY (`ONG/Instituicao/Igreja_CNPJ`)
    REFERENCES `AlimentAcao`.`ONG/Instituicao/Igreja` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`alimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`alimentos` (
  `idAlimento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAlimento`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`doacaoAlimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`doacaoAlimento` (
  `kilosAlimento` INT(5) ZEROFILL NOT NULL,
  `quantidade(und)` INT(5) ZEROFILL NOT NULL,
  `alimentos_idAlimento` INT NOT NULL,
  `doacaoAnonima_idDoacaoAnonima` INT NULL,
  `doacaoEspecifica_idDoacaoEspecifica` INT NULL,
  INDEX `fk_doacaoAlimento_alimentos1_idx` (`alimentos_idAlimento` ASC) VISIBLE,
  INDEX `fk_doacaoAlimento_doacaoAnonima1_idx` (`doacaoAnonima_idDoacaoAnonima` ASC) VISIBLE,
  INDEX `fk_doacaoAlimento_doacaoEspecifica1_idx` (`doacaoEspecifica_idDoacaoEspecifica` ASC) VISIBLE,
  CONSTRAINT `fk_doacaoAlimento_alimentos1`
    FOREIGN KEY (`alimentos_idAlimento`)
    REFERENCES `AlimentAcao`.`alimentos` (`idAlimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doacaoAlimento_doacaoAnonima1`
    FOREIGN KEY (`doacaoAnonima_idDoacaoAnonima`)
    REFERENCES `AlimentAcao`.`doacaoAnonima` (`idDoacaoAnonima`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doacaoAlimento_doacaoEspecifica1`
    FOREIGN KEY (`doacaoEspecifica_idDoacaoEspecifica`)
    REFERENCES `AlimentAcao`.`doacaoEspecifica` (`idDoacaoEspecifica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`enderecoRecebedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`enderecoRecebedor` (
  `cep` VARCHAR(9) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `ONG/Instituicao/Igreja_CNPJ` VARCHAR(18) NOT NULL,
  INDEX `fk_enderecoRecebedor_ONG/Instituicao/Igreja1_idx` (`ONG/Instituicao/Igreja_CNPJ` ASC) VISIBLE,
  PRIMARY KEY (`ONG/Instituicao/Igreja_CNPJ`),
  CONSTRAINT `fk_enderecoRecebedor_ONG/Instituicao/Igreja1`
    FOREIGN KEY (`ONG/Instituicao/Igreja_CNPJ`)
    REFERENCES `AlimentAcao`.`ONG/Instituicao/Igreja` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`redesSociaisRecebedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`redesSociaisRecebedor` (
  `redeScial` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `ONG/Instituicao/Igreja_CNPJ` VARCHAR(18) NOT NULL,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_redesSociaisRecebedor_ONG/Instituicao/Igreja1_idx` (`ONG/Instituicao/Igreja_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_redesSociaisRecebedor_ONG/Instituicao/Igreja1`
    FOREIGN KEY (`ONG/Instituicao/Igreja_CNPJ`)
    REFERENCES `AlimentAcao`.`ONG/Instituicao/Igreja` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`alimentosAceitos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`alimentosAceitos` (
  `tipoDeAlimento` VARCHAR(45) NOT NULL,
  `ONG/Instituicao/Igreja_CNPJ` VARCHAR(18) NOT NULL,
  INDEX `fk_alimentosAceitos_ONG/Instituicao/Igreja1_idx` (`ONG/Instituicao/Igreja_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_alimentosAceitos_ONG/Instituicao/Igreja1`
    FOREIGN KEY (`ONG/Instituicao/Igreja_CNPJ`)
    REFERENCES `AlimentAcao`.`ONG/Instituicao/Igreja` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlimentAcao`.`areaAtuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlimentAcao`.`areaAtuacao` (
  `bairro` VARCHAR(45) NOT NULL,
  `ONG/Instituicao/Igreja_CNPJ` VARCHAR(18) NOT NULL,
  INDEX `fk_areaAtuacao_ONG/Instituicao/Igreja1_idx` (`ONG/Instituicao/Igreja_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_areaAtuacao_ONG/Instituicao/Igreja1`
    FOREIGN KEY (`ONG/Instituicao/Igreja_CNPJ`)
    REFERENCES `AlimentAcao`.`ONG/Instituicao/Igreja` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
