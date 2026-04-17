-- =============================================================
-- SISTEMA DE GESTÃO DE TRANSPORTE RODOVIÁRIO - ITAPEMIRIM
-- Script 02: Inserção de Dados Fictícios
-- Obs: Dados baseados em operações reais da empresa
-- =============================================================

-- Departamentos
INSERT INTO itapemirim.departamento (nome, gestor_id) VALUES
('Recursos Humanos', NULL),
('Operações', NULL),
('Financeiro', NULL),
('Manutenção', NULL),
('Transporte', NULL);

-- Funcionários
INSERT INTO itapemirim.funcionario (nome, cpf, cargo_id, salario, departamento_id, data_admissao) VALUES
('Carlos Silva',   '123.456.789-00', 1, 4200.00, 1, '2020-03-01'),
('Fernanda Lima',  '987.654.321-00', 2, 3800.00, 1, '2021-06-15'),
('João Rocha',     '321.654.987-00', 3, 4600.00, 2, '2019-08-10'),
('Mariana Costa',  '111.222.333-44', 4, 5000.00, 2, '2018-01-20'),
('Tiago Menezes',  '999.888.777-66', 5, 6000.00, 3, '2022-02-10');

-- Motoristas (especialização de funcionario)
INSERT INTO itapemirim.motorista (funcionario_id, ano_experiencia, cnh) VALUES
(3, 10, 'CNH-321654'),
(4, 8,  'CNH-111222'),
(5, 5,  'CNH-999888');

-- Veículos
INSERT INTO itapemirim.veiculo (modelo, placa, capacidade, ano_fabricacao) VALUES
('Marcopolo Paradiso', 'ABC1D23', 44, 2019),
('Comil Campione',     'XYZ9Z88', 40, 2020),
('Mascarello Roma',    'JKL4M56', 46, 2021),
('Neobus Spectrum',    'QWE5R67', 38, 2018),
('Caio Apache VIP',    'RTY7U89', 50, 2022);

-- Passageiros
INSERT INTO itapemirim.passageiro (nome, cpf, email, telefone) VALUES
('Ana Souza',     '123.123.123-12', 'ana@email.com',    '(11) 91111-1111'),
('Bruno Pereira', '456.456.456-45', 'bruno@email.com',  '(11) 92222-2222'),
('Camila Braga',  '789.789.789-78', 'camila@email.com', '(11) 93333-3333'),
('Diego Moura',   '147.258.369-00', 'diego@email.com',  '(11) 94444-4444'),
('Elaine Silva',  '321.654.987-11', 'elaine@email.com', '(11) 95555-5555');

-- Linhas
INSERT INTO itapemirim.linha (nome_linha, origem, destino, quilometragem, tempo_estimado) VALUES
('Linha SP-RJ',  'São Paulo',    'Rio de Janeiro', 430.5, '06:30:00'),
('Linha SP-BH',  'São Paulo',    'Belo Horizonte', 590.0, '08:45:00'),
('Linha RJ-VIX', 'Rio de Janeiro', 'Vitória',      520.3, '07:40:00');

-- Viagens
INSERT INTO itapemirim.viagem (veiculo_id, motorista_id, linha_id, data, horario) VALUES
(1, 1, 1, '2024-03-05', '08:00:00'),
(2, 2, 2, '2024-03-10', '07:00:00'),
(3, 3, 3, '2024-03-12', '06:30:00'),
(4, 1, 1, '2024-04-01', '09:00:00'),
(5, 2, 2, '2024-04-15', '10:00:00');

-- Vendas de passagem
INSERT INTO itapemirim.venda_passagem (passageiro_id, viagem_id, poltrona_id, valor_tarifa, pagamento_id, status, data) VALUES
(1, 1, 12, 120.50, 101, 'confirmado', '2024-02-20'),
(2, 1, 15, 120.50, 102, 'confirmado', '2024-02-21'),
(1, 2, 18, 150.00, 103, 'confirmado', '2024-02-22'),
(3, 3,  9, 135.75, 104, 'confirmado', '2024-02-25'),
(3, 1, 20, 120.50, 105, 'confirmado', '2024-02-26'),
(4, 1, 21, 120.50, 106, 'confirmado', '2024-02-27'),
(4, 2, 22, 150.00, 107, 'confirmado', '2024-03-01'),
(5, 2, 23, 150.00, 108, 'confirmado', '2024-03-02'),
(5, 2, 24, 150.00, 109, 'confirmado', '2024-03-03'),
(5, 2, 25, 150.00, 110, 'confirmado', '2024-03-04');

-- Escalas de motoristas
INSERT INTO itapemirim.escala_motorista (motorista_id, viagem_id, data_escala, carga_horaria) VALUES
(1, 1, '2024-03-05', '08:00:00'),
(2, 2, '2024-03-10', '07:30:00'),
(3, 3, '2024-03-12', '07:00:00'),
(1, 4, '2024-04-01', '08:30:00'),
(2, 5, '2024-04-15', '09:00:00');

-- Abastecimentos
INSERT INTO itapemirim.abastecimento (veiculo_id, data, quantidade_litros, valor_total) VALUES
(1, '2024-03-04', 150.00, 900.00),
(2, '2024-03-09', 130.00, 780.00),
(3, '2024-03-11', 160.00, 960.00);

-- Manutenções
INSERT INTO itapemirim.manutencao (veiculo_id, tipo_manutencao, custo, data, descricao) VALUES
(1, 'Preventiva', 1200.00, '2024-02-15', 'Troca de óleo e filtros'),
(2, 'Corretiva',  3500.00, '2024-03-01', 'Substituição de pastilhas de freio'),
(4, 'Preventiva',  800.00, '2024-03-20', 'Revisão geral pré-temporada');
