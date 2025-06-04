-- 1) Inserir 3 usuários de exemplo
INSERT INTO usuario (nome, email, senha_hash, telefone)
VALUES
  ('Ana Silva', 'ana.silva@example.com', 'hash_senha_ana', '91991234567'),
  ('Bruno Costa', 'bruno.costa@example.com', 'hash_senha_bruno', '91999876543'),
  ('Carla Mendes', 'carla.mendes@example.com', 'hash_senha_carla', '91993456789');

-- 2) Inserir dados médicos para cada usuário
INSERT INTO dados_medicos (id_usuario, tipo_sanguineo, alergias, medicamentos)
VALUES
  (1, 'O+', 'Penicilina', 'Anlodipino'),
  (2, 'A-', '', 'Metformina'),
  (3, 'B+', 'Pólen', '');

-- 3) Inserir contatos de emergência para cada usuário
INSERT INTO contato_emergencia (id_usuario, nome_contato, telefone_contato)
VALUES
  (1, 'José Silva', '91990001122'),
  (1, 'Cláudia Santos', '91990002233'),
  (2, 'Maria Costa', '91990003344'),
  (3, 'Pedro Mendes', '91990004455');

-- 4) Inserir 3 hospitais de exemplo
INSERT INTO hospital (nome_hospital, endereco, telefone_hospital, latitude, longitude, categoria)
VALUES
  ('Hospital Central', 'Av. Principal, 1000, Manaus', '9234578901', -3.101944, -60.025556, 'Geral'),
  ('UPA Japiim', 'Rua Japiim, 123, Manaus', '9234578912', -3.115432, -60.046789, 'Emergência'),
  ('Hospital Santa Casa', 'Rua 7 de Setembro, 200, Manaus', '9234578923', -3.138765, -60.019876, 'Trauma');

-- 5) Inserir 2 registros no histórico de rotas
INSERT INTO historico_rota (id_usuario, id_hospital, data_hora_solicitacao, distancia_metros, duracao_segundos)
VALUES
  (1, 2, '2025-05-30 14:20:00', 2500, 300),
  (2, 1, '2025-06-01 09:10:00', 4500, 600);

UPDATE contato_emergencia
SET telefone_contato = '91990006677'
WHERE id_contato = 2;

DELETE FROM contato_emergencia
WHERE id_contato = 4;

-- Supondo-se ponto central (latitude_central, longitude_central)
SET @lat0 = -3.101944, @lon0 = -60.025556, @raio_m = 10000;

SELECT id_hospital,
       nome_hospital,
       endereco,
       telefone_hospital,
       categoria,
       (6371000 * ACOS(
          COS(RADIANS(@lat0)) * COS(RADIANS(latitude)) *
          COS(RADIANS(longitude) - RADIANS(@lon0)) +
          SIN(RADIANS(@lat0)) * SIN(RADIANS(latitude))
       )) AS distancia
FROM hospital
HAVING distancia <= @raio_m
ORDER BY distancia;

SELECT u.nome AS Usuario,
       h.nome_hospital AS Hospital,
       hr.data_hora_solicitacao AS DataHora,
       hr.distancia_metros AS Distancia,
       hr.duracao_segundos AS Duracao
FROM historico_rota hr
  JOIN usuario u ON hr.id_usuario = u.id_usuario
  JOIN hospital h ON hr.id_hospital = h.id_hospital
WHERE u.id_usuario = 1
ORDER BY hr.data_hora_solicitacao DESC;
