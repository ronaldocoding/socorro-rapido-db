-- #######################################
-- Arquivo: schema.sql
-- Sistema: Socorro Rápido (Banco de Dados)
-- #######################################

-- 1) Tabela USUARIO
CREATE TABLE usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  telefone VARCHAR(20)
);

-- 2) Tabela DADOS_MEDICOS
CREATE TABLE dados_medicos (
  id_dados_medicos INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL UNIQUE,
  tipo_sanguineo ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  alergias TEXT,
  medicamentos TEXT,
  CONSTRAINT fk_dados_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- 3) Tabela CONTATO_EMERGENCIA
CREATE TABLE contato_emergencia (
  id_contato INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  nome_contato VARCHAR(100) NOT NULL,
  telefone_contato VARCHAR(20) NOT NULL,
  CONSTRAINT fk_contato_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- 4) Tabela HOSPITAL
CREATE TABLE hospital (
  id_hospital INT AUTO_INCREMENT PRIMARY KEY,
  nome_hospital VARCHAR(150) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone_hospital VARCHAR(20) NOT NULL,
  latitude DECIMAL(10,7) NOT NULL,
  longitude DECIMAL(10,7) NOT NULL,
  categoria VARCHAR(50)
);

-- 5) Tabela HISTORICO_ROTA
CREATE TABLE historico_rota (
  id_historico INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_hospital INT NOT NULL,
  data_hora_solicitacao DATETIME NOT NULL,
  distancia_metros INT NOT NULL,
  duracao_segundos INT NOT NULL,
  CONSTRAINT fk_historico_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_historico_hospital
    FOREIGN KEY (id_hospital)
    REFERENCES hospital(id_hospital)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);
