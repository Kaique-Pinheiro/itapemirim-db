-- =============================================================
-- SISTEMA DE GESTÃO DE TRANSPORTE RODOVIÁRIO - ITAPEMIRIM
-- Script 03: Consultas Analíticas SQL
-- =============================================================

-- -------------------------------------------------------------
-- CONSULTA 1: Viagens realizadas em um determinado mês
-- Relevância: Permite entender a frequência operacional da frota
-- e identificar os horários mais utilizados.
-- -------------------------------------------------------------
SELECT
    v.viagem_id,
    v.data,
    v.horario,
    veiculo.modelo,
    linha.origem,
    linha.destino
FROM itapemirim.viagem v
JOIN itapemirim.veiculo ON v.veiculo_id = veiculo.veiculo_id
JOIN itapemirim.linha   ON v.linha_id   = linha.linha_id
WHERE v.data BETWEEN '2024-03-01' AND '2024-03-31'
ORDER BY v.data, v.horario;

-- -------------------------------------------------------------
-- CONSULTA 2: Média de tarifa por linha
-- Relevância: Auxilia a gestão na análise de precificação
-- e rentabilidade por rota.
-- -------------------------------------------------------------
SELECT
    l.nome_linha,
    AVG(vp.valor_tarifa) AS media_tarifa
FROM itapemirim.venda_passagem vp
JOIN itapemirim.viagem v ON vp.viagem_id = v.viagem_id
JOIN itapemirim.linha  l ON v.linha_id   = l.linha_id
GROUP BY l.nome_linha
ORDER BY media_tarifa DESC;

-- -------------------------------------------------------------
-- CONSULTA 3: Passageiros que mais compraram em 2024
-- Relevância: Identifica clientes frequentes para
-- campanhas de fidelização.
-- -------------------------------------------------------------
SELECT
    p.nome,
    COUNT(vp.venda_id) AS total_compras
FROM itapemirim.passageiro p
JOIN itapemirim.venda_passagem vp ON p.passageiro_id = vp.passageiro_id
WHERE vp.data BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY p.nome
HAVING COUNT(vp.venda_id) > 3
ORDER BY total_compras DESC;

-- -------------------------------------------------------------
-- CONSULTA 4: Custo total de manutenção por veículo
-- Relevância: Permite identificar veículos com maior custo
-- operacional e planejar substituições da frota.
-- -------------------------------------------------------------
SELECT
    v.modelo,
    v.placa,
    COUNT(m.manutencao_id)  AS total_manutencoes,
    SUM(m.custo)            AS custo_total,
    AVG(m.custo)            AS custo_medio
FROM itapemirim.veiculo v
LEFT JOIN itapemirim.manutencao m ON v.veiculo_id = m.veiculo_id
GROUP BY v.modelo, v.placa
ORDER BY custo_total DESC NULLS LAST;

-- -------------------------------------------------------------
-- CONSULTA 5: Ocupação por viagem
-- Relevância: Indica o aproveitamento da capacidade dos veículos,
-- essencial para decisões de precificação dinâmica.
-- -------------------------------------------------------------
SELECT
    v.viagem_id,
    v.data,
    l.nome_linha,
    ve.capacidade,
    COUNT(vp.venda_id)                                          AS passageiros_embarcados,
    ROUND(COUNT(vp.venda_id)::DECIMAL / ve.capacidade * 100, 2) AS taxa_ocupacao_pct
FROM itapemirim.viagem v
JOIN itapemirim.linha          l  ON v.linha_id   = l.linha_id
JOIN itapemirim.veiculo        ve ON v.veiculo_id  = ve.veiculo_id
LEFT JOIN itapemirim.venda_passagem vp ON v.viagem_id = vp.viagem_id
GROUP BY v.viagem_id, v.data, l.nome_linha, ve.capacidade
ORDER BY taxa_ocupacao_pct DESC;
