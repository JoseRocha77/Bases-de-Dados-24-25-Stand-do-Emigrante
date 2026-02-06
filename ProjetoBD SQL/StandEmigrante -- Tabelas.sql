-- -----------------------------------------------------
-- Schema standEmigrante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS standEmigrante DEFAULT CHARACTER SET utf8 ;
USE standEmigrante;

-- -----------------------------------------------------
-- Tabela 'Stands'
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.Stands (
  idStand INT NOT NULL,
  rua VARCHAR(100) NOT NULL,
  numero INT NOT NULL,
  localidade VARCHAR(80) NOT NULL,
  codigoPostal VARCHAR(8) NOT NULL,
  anoAbertura INT NULL,
  nrFuncionarios INT NOT NULL DEFAULT 0,
  nrVeiculos INT NOT NULL DEFAULT 0,
  telefone VARCHAR(9) NOT NULL,
  PRIMARY KEY (idStand)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela 'Veiculos'
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.Veiculos (
	idVeiculo INT NOT NULL,
	matricula VARCHAR(8) NOT NULL,
	marca VARCHAR(30) NOT NULL,
	modelo VARCHAR(30) NOT NULL,
	cor VARCHAR(30) NULL,
	anoFabrico INT NULL,
	tipoCombustivel VARCHAR(30) NOT NULL,
	quilometragem INT NOT NULL,
	prazoSeguro DATE NOT NULL,
	prazoInspecao DATE NOT NULL,
	precoDia DECIMAL(6,2) NOT NULL,
	idStand INT NOT NULL,
	PRIMARY KEY (idVeiculo),
	FOREIGN KEY (idStand)
		REFERENCES standEmigrante.Stands (idStand)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela 'Funcionarios'
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.Funcionarios (
	idFuncionario INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	rua VARCHAR(100) NOT NULL,
	numero INT NOT NULL,
	localidade VARCHAR(80) NOT NULL,
	codigoPostal VARCHAR(8) NOT NULL,
	dataNascimento DATE NULL,
	cargo VARCHAR(20) NOT NULL,
	idStand INT NOT NULL,
	PRIMARY KEY (idFuncionario),
	FOREIGN KEY (idStand)
		REFERENCES standEmigrante.Stands (idStand)
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela standEmigrante.Clientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.Clientes (
	idCliente INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	nacionalidade VARCHAR(30) NULL,
	NIF VARCHAR(9) NOT NULL,
	rua VARCHAR(100) NOT NULL,
	numero INT NOT NULL,
	localidade VARCHAR(80) NOT NULL,
	codigoPostal VARCHAR(8) NOT NULL,
	PRIMARY KEY (idCliente)
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela standEmigrante.Alugueres
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.Alugueres (
	idAluguer INT NOT NULL,
	idVeiculo INT NOT NULL,
	idFuncionario INT NOT NULL,
	idCliente INT NOT NULL,
	dataInicio DATETIME NOT NULL,
	dataFinalPrevista DATETIME NOT NULL,
	dataFinalEfetiva DATETIME NULL,
	valorTotal DECIMAL(8,2) NOT NULL,
	tipoPagamento VARCHAR(15) NOT NULL,
	estado VARCHAR(10) NOT NULL,
	PRIMARY KEY (idAluguer),
	FOREIGN KEY (idVeiculo)
		REFERENCES standEmigrante.Veiculos (idVeiculo),
	FOREIGN KEY (idFuncionario)
		REFERENCES standEmigrante.Funcionarios (idFuncionario),
	FOREIGN KEY (idCliente)
		REFERENCES standEmigrante.Clientes (idCliente),
	CHECK (estado IN ('Ativo', 'Inativo')),
	CHECK (tipoPagamento IN ('Parcial', 'A Pronto'))
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela standEmigrante.Pagamentos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.Pagamentos (
	idPagamento INT NOT NULL,
	idAluguer INT NOT NULL,
	valor DECIMAL(6,2) NOT NULL,
	dataHora DATETIME NULL,
	metodo VARCHAR(30) NOT NULL,
	PRIMARY KEY (idPagamento),
	FOREIGN KEY (idAluguer)
		REFERENCES standEmigrante.Alugueres (idAluguer)
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela standEmigrante.contactos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS standEmigrante.contactos (
	idCliente INT NOT NULL,
	contacto VARCHAR(15) NOT NULL,
	PRIMARY KEY (idCliente, contacto),
	FOREIGN KEY (idCliente)
	REFERENCES standEmigrante.Clientes (idCliente)
)ENGINE = InnoDB;
 




























