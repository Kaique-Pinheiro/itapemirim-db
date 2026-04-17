# Regras de Transformação — Modelo ER para Relacional

## Contexto

Este documento descreve as decisões de modelagem tomadas durante a transformação do Diagrama Entidade-Relacionamento (ER) para o Modelo Relacional do sistema de gestão de transporte rodoviário da Itapemirim.

---

## Regra 1 — Relacionamento 1:N

**Estrutura transformada:** Relacionamento entre `departamento` e `funcionario`

**Justificativa:** Um departamento pode ter muitos funcionários, mas cada funcionário pertence a apenas um departamento. Em relacionamentos 1:N, a chave estrangeira é inserida na tabela do lado N — neste caso, `funcionario`.

| Estado | Descrição |
|--------|-----------|
| ER | Relacionamento `trabalha_em` entre DEPARTAMENTO (1) e FUNCIONÁRIO (N) |
| Relacional | Tabela `funcionario` recebe a coluna `departamento_id` como chave estrangeira |

**Impacto:** Nenhuma tabela intermediária foi necessária.

---

## Regra 2 — Especialização/Generalização (Herança)

**Estrutura transformada:** Hierarquia de `funcionario` em `motorista` e `gerente`

**Justificativa:** As subentidades herdam a chave primária da superentidade (`funcionario_id`) e armazenam apenas seus atributos específicos. A especialização é total e disjunta — todo motorista e gerente é obrigatoriamente um funcionário.

| Estado | Descrição |
|--------|-----------|
| ER | Entidade `funcionario` especializada em `motorista` (cnh, ano_experiencia) e `gerente` |
| Relacional | `motorista(motorista_id PK, funcionario_id FK, cnh, ano_experiencia)` |

**Impacto:** Criadas tabelas filhas com relacionamento 1:1 com `funcionario`, compartilhando o mesmo identificador como FK.

---

## Regra 3 — Relacionamento N:M

**Estrutura transformada:** Relacionamento entre `passageiro` e `viagem`

**Justificativa:** Um passageiro pode comprar várias passagens e cada viagem pode ter vários passageiros — caracterizando N:M. Relacionamentos N:M exigem uma tabela associativa com chaves estrangeiras para ambas as entidades.

| Estado | Descrição |
|--------|-----------|
| ER | Relacionamento N:M `compra` entre `passageiro` e `viagem` |
| Relacional | Tabela `venda_passagem(venda_id PK, passageiro_id FK, viagem_id FK, data, ...)` |

**Impacto:** Criação da tabela associativa `venda_passagem` com chave primária própria e chaves estrangeiras para `passageiro` e `viagem`. A tabela também armazena atributos do relacionamento: `valor_tarifa`, `poltrona_id` e `status`.
