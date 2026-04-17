-- =============================================================
-- SISTEMA DE GESTÃO DE TRANSPORTE RODOVIÁRIO - ITAPEMIRIM
-- Script 01: Criação do Schema e Tabelas
-- Banco: PostgreSQL
-- =============================================================

DROP SCHEMA IF EXISTS itapemirim CASCADE;
CREATE SCHEMA itapemirim;

-- =============================================================
-- TABELA: departamento
-- Armazena os departamentos da empresa
-- =============================================================
CREATE TABLE itapemirim.departamento (
    departamento_id SERIAL PRIMARY KEY,
    nome            VARCHAR(50),
    gestor_id       INT
);

COMMENT ON TABLE itapemirim.departamento IS 'Departamentos da empresa Itapemirim';
COMMENT ON COLUMN itapemirim.departamento.departamento_id IS 'Identificador único do departamento';
COMMENT ON COLUMN itapemirim.departamento.nome IS 'Nome do departamento (ex: Operações, Financeiro)';
COMMENT ON COLUMN itapemirim.departamento.gestor_id IS 'FK para o funcionário responsável pelo departamento';

-- =============================================================
-- TABELA: funcionario
-- Armazena todos os funcionários da empresa
-- =============================================================
CREATE TABLE itapemirim.funcionario (
    funcionario_id  SERIAL PRIMARY KEY,
    nome            VARCHAR(50),
    cpf             VARCHAR(14) UNIQUE NOT NULL,
    cargo_id        INT,
    salario         DECIMAL(10, 2),
    departamento_id INT REFERENCES itapemirim.departamento(departamento_id),
    data_admissao   DATE
);

COMMENT ON TABLE itapemirim.funcionario IS 'Funcionários da empresa, incluindo motoristas e gerentes';
COMMENT ON COLUMN itapemirim.funcionario.funcionario_id IS 'Identificador único do funcionário';
COMMENT ON COLUMN itapemirim.funcionario.nome IS 'Nome completo do funcionário';
COMMENT ON COLUMN itapemirim.funcionario.cpf IS 'CPF do funcionário, único e obrigatório';
COMMENT ON COLUMN itapemirim.funcionario.cargo_id IS 'Referência ao cargo do funcionário';
COMMENT ON COLUMN itapemirim.funcionario.salario IS 'Salário mensal do funcionário';
COMMENT ON COLUMN itapemirim.funcionario.departamento_id IS 'FK para o departamento ao qual o funcionário pertence (1:N)';
COMMENT ON COLUMN itapemirim.funcionario.data_admissao IS 'Data de admissão na empresa';

-- =============================================================
-- TABELA: motorista
-- Especialização de funcionario (herança 1:1)
-- =============================================================
CREATE TABLE itapemirim.motorista (
    motorista_id    SERIAL PRIMARY KEY,
    funcionario_id  INT REFERENCES itapemirim.funcionario(funcionario_id),
    ano_experiencia INT,
    cnh             VARCHAR(20)
);

COMMENT ON TABLE itapemirim.motorista IS 'Especialização de funcionario: armazena atributos exclusivos do motorista';
COMMENT ON COLUMN itapemirim.motorista.motorista_id IS 'Identificador único do motorista';
COMMENT ON COLUMN itapemirim.motorista.funcionario_id IS 'FK para funcionario — herança da superentidade (1:1)';
COMMENT ON COLUMN itapemirim.motorista.ano_experiencia IS 'Anos de experiência como motorista profissional';
COMMENT ON COLUMN itapemirim.motorista.cnh IS 'Número da Carteira Nacional de Habilitação';

-- =============================================================
-- TABELA: veiculo
-- Frota de veículos da empresa
-- =============================================================
CREATE TABLE itapemirim.veiculo (
    veiculo_id      SERIAL PRIMARY KEY,
    modelo          VARCHAR(50),
    placa           VARCHAR(10) UNIQUE,
    capacidade      INT,
    ano_fabricacao  INT
);

COMMENT ON TABLE itapemirim.veiculo IS 'Frota de ônibus e veículos da empresa';
COMMENT ON COLUMN itapemirim.veiculo.veiculo_id IS 'Identificador único do veículo';
COMMENT ON COLUMN itapemirim.veiculo.modelo IS 'Modelo do veículo (ex: Marcopolo Paradiso)';
COMMENT ON COLUMN itapemirim.veiculo.placa IS 'Placa do veículo, única no sistema';
COMMENT ON COLUMN itapemirim.veiculo.capacidade IS 'Número de assentos disponíveis no veículo';
COMMENT ON COLUMN itapemirim.veiculo.ano_fabricacao IS 'Ano de fabricação do veículo';

-- =============================================================
-- TABELA: abastecimento
-- Registro de abastecimentos da frota
-- =============================================================
CREATE TABLE itapemirim.abastecimento (
    abastecimento_id  SERIAL PRIMARY KEY,
    veiculo_id        INT REFERENCES itapemirim.veiculo(veiculo_id),
    data              DATE,
    quantidade_litros DECIMAL(10,2),
    valor_total       DECIMAL(10,2)
);

COMMENT ON TABLE itapemirim.abastecimento IS 'Histórico de abastecimentos realizados nos veículos da frota';
COMMENT ON COLUMN itapemirim.abastecimento.abastecimento_id IS 'Identificador único do abastecimento';
COMMENT ON COLUMN itapemirim.abastecimento.veiculo_id IS 'FK para o veículo abastecido';
COMMENT ON COLUMN itapemirim.abastecimento.data IS 'Data em que o abastecimento foi realizado';
COMMENT ON COLUMN itapemirim.abastecimento.quantidade_litros IS 'Quantidade de combustível em litros';
COMMENT ON COLUMN itapemirim.abastecimento.valor_total IS 'Valor total pago no abastecimento';

-- =============================================================
-- TABELA: manutencao
-- Registro de manutenções realizadas nos veículos
-- =============================================================
CREATE TABLE itapemirim.manutencao (
    manutencao_id   SERIAL PRIMARY KEY,
    veiculo_id      INT REFERENCES itapemirim.veiculo(veiculo_id),
    tipo_manutencao VARCHAR(50),
    custo           DECIMAL(10,2),
    data            DATE,
    descricao       TEXT
);

COMMENT ON TABLE itapemirim.manutencao IS 'Registro de manutenções preventivas e corretivas dos veículos';
COMMENT ON COLUMN itapemirim.manutencao.manutencao_id IS 'Identificador único da manutenção';
COMMENT ON COLUMN itapemirim.manutencao.veiculo_id IS 'FK para o veículo que passou pela manutenção';
COMMENT ON COLUMN itapemirim.manutencao.tipo_manutencao IS 'Tipo de manutenção (ex: preventiva, corretiva)';
COMMENT ON COLUMN itapemirim.manutencao.custo IS 'Custo total da manutenção em reais';
COMMENT ON COLUMN itapemirim.manutencao.data IS 'Data em que a manutenção foi realizada';
COMMENT ON COLUMN itapemirim.manutencao.descricao IS 'Descrição detalhada do serviço realizado';

-- =============================================================
-- TABELA: linha
-- Rotas operadas pela empresa
-- =============================================================
CREATE TABLE itapemirim.linha (
    linha_id        SERIAL PRIMARY KEY,
    nome_linha      VARCHAR(50),
    origem          VARCHAR(50),
    destino         VARCHAR(50),
    quilometragem   DECIMAL(10,2),
    tempo_estimado  TIME
);

COMMENT ON TABLE itapemirim.linha IS 'Linhas/rotas de transporte operadas pela Itapemirim';
COMMENT ON COLUMN itapemirim.linha.linha_id IS 'Identificador único da linha';
COMMENT ON COLUMN itapemirim.linha.nome_linha IS 'Nome comercial da linha (ex: Linha SP-RJ)';
COMMENT ON COLUMN itapemirim.linha.origem IS 'Cidade de origem da rota';
COMMENT ON COLUMN itapemirim.linha.destino IS 'Cidade de destino da rota';
COMMENT ON COLUMN itapemirim.linha.quilometragem IS 'Distância total da rota em quilômetros';
COMMENT ON COLUMN itapemirim.linha.tempo_estimado IS 'Tempo médio estimado para percorrer a rota';

-- =============================================================
-- TABELA: passageiro
-- Clientes que compram passagens
-- =============================================================
CREATE TABLE itapemirim.passageiro (
    passageiro_id SERIAL PRIMARY KEY,
    nome          VARCHAR(50),
    cpf           VARCHAR(14) UNIQUE NOT NULL,
    email         VARCHAR(100),
    telefone      VARCHAR(20)
);

COMMENT ON TABLE itapemirim.passageiro IS 'Clientes cadastrados que realizam compras de passagens';
COMMENT ON COLUMN itapemirim.passageiro.passageiro_id IS 'Identificador único do passageiro';
COMMENT ON COLUMN itapemirim.passageiro.nome IS 'Nome completo do passageiro';
COMMENT ON COLUMN itapemirim.passageiro.cpf IS 'CPF do passageiro, único e obrigatório';
COMMENT ON COLUMN itapemirim.passageiro.email IS 'Endereço de e-mail para contato';
COMMENT ON COLUMN itapemirim.passageiro.telefone IS 'Número de telefone para contato';

-- =============================================================
-- TABELA: viagem
-- Viagens programadas e realizadas
-- =============================================================
CREATE TABLE itapemirim.viagem (
    viagem_id   SERIAL PRIMARY KEY,
    veiculo_id  INT REFERENCES itapemirim.veiculo(veiculo_id),
    motorista_id INT REFERENCES itapemirim.motorista(motorista_id),
    linha_id    INT REFERENCES itapemirim.linha(linha_id),
    data        DATE,
    horario     TIME
);

COMMENT ON TABLE itapemirim.viagem IS 'Viagens programadas, associando veículo, motorista e linha';
COMMENT ON COLUMN itapemirim.viagem.viagem_id IS 'Identificador único da viagem';
COMMENT ON COLUMN itapemirim.viagem.veiculo_id IS 'FK para o veículo utilizado na viagem';
COMMENT ON COLUMN itapemirim.viagem.motorista_id IS 'FK para o motorista responsável pela viagem';
COMMENT ON COLUMN itapemirim.viagem.linha_id IS 'FK para a linha/rota da viagem';
COMMENT ON COLUMN itapemirim.viagem.data IS 'Data de realização da viagem';
COMMENT ON COLUMN itapemirim.viagem.horario IS 'Horário de partida da viagem';

-- =============================================================
-- TABELA: venda_passagem
-- Tabela associativa N:M entre passageiro e viagem
-- =============================================================
CREATE TABLE itapemirim.venda_passagem (
    venda_id    SERIAL PRIMARY KEY,
    passageiro_id INT REFERENCES itapemirim.passageiro(passageiro_id),
    viagem_id   INT REFERENCES itapemirim.viagem(viagem_id),
    poltrona_id INT,
    valor_tarifa DECIMAL(10,2),
    pagamento_id INT,
    status      VARCHAR(20),
    data        DATE
);

COMMENT ON TABLE itapemirim.venda_passagem IS 'Tabela associativa N:M entre passageiro e viagem — registra compras de passagens';
COMMENT ON COLUMN itapemirim.venda_passagem.venda_id IS 'Identificador único da venda';
COMMENT ON COLUMN itapemirim.venda_passagem.passageiro_id IS 'FK para o passageiro comprador';
COMMENT ON COLUMN itapemirim.venda_passagem.viagem_id IS 'FK para a viagem associada à passagem';
COMMENT ON COLUMN itapemirim.venda_passagem.poltrona_id IS 'Número da poltrona reservada no veículo';
COMMENT ON COLUMN itapemirim.venda_passagem.valor_tarifa IS 'Valor pago pela passagem em reais';
COMMENT ON COLUMN itapemirim.venda_passagem.pagamento_id IS 'Referência ao método/registro de pagamento';
COMMENT ON COLUMN itapemirim.venda_passagem.status IS 'Status da passagem (ex: confirmado, cancelado)';
COMMENT ON COLUMN itapemirim.venda_passagem.data IS 'Data da compra da passagem';

-- =============================================================
-- TABELA: escala_motorista
-- Escala de trabalho dos motoristas por viagem
-- =============================================================
CREATE TABLE itapemirim.escala_motorista (
    escala_id   SERIAL PRIMARY KEY,
    motorista_id INT REFERENCES itapemirim.motorista(motorista_id),
    viagem_id   INT REFERENCES itapemirim.viagem(viagem_id),
    data_escala DATE,
    carga_horaria TIME
);

COMMENT ON TABLE itapemirim.escala_motorista IS 'Escala de trabalho dos motoristas, associando cada um às suas viagens';
COMMENT ON COLUMN itapemirim.escala_motorista.escala_id IS 'Identificador único da escala';
COMMENT ON COLUMN itapemirim.escala_motorista.motorista_id IS 'FK para o motorista escalado';
COMMENT ON COLUMN itapemirim.escala_motorista.viagem_id IS 'FK para a viagem correspondente';
COMMENT ON COLUMN itapemirim.escala_motorista.data_escala IS 'Data da escala de trabalho';
COMMENT ON COLUMN itapemirim.escala_motorista.carga_horaria IS 'Carga horária prevista para a escala';
