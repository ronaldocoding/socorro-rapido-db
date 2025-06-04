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
