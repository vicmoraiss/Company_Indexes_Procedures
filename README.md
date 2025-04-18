# 📘 Projeto de Otimização e Manipulação de Dados com SQL

Este projeto tem como objetivo aplicar boas práticas de otimização em banco de dados relacionais por meio da **criação de índices** e do uso de **procedures** para manipulação de dados. O cenário base utilizado envolve informações de uma empresa fictícia com departamentos e funcionários, além de contextos adicionais como universidade e e-commerce.

## 📌 Parte 1 – Criação de Índices

Nesta etapa, foram criados índices com base em consultas SQL específicas, a fim de melhorar a performance nas buscas por dados. 

### 🧠 Critérios Considerados para Criação de Índices

- Frequência de acesso aos dados (consultas mais recorrentes)
- Relevância das colunas no contexto das queries
- Avaliação do impacto do índice na performance geral

⚠️ *Lembre-se: índices são importantes para acelerar buscas, mas seu uso excessivo pode afetar negativamente operações de escrita (inserção/atualização/remoção).*

### 🔎 Consultas e Índices Criados

1. **Qual o departamento com maior número de pessoas?**
   - Query: `SELECT department, COUNT(*) FROM employees GROUP BY department ORDER BY COUNT(*) DESC LIMIT 1;`
   - Índice sugerido: `CREATE INDEX idx_department ON employees(department);`
   - Motivo: A coluna `department` é usada em agrupamento e ordenação.

2. **Quais são os departamentos por cidade?**
   - Query: `SELECT city, department FROM employees GROUP BY city, department;`
   - Índice sugerido: `CREATE INDEX idx_city_department ON employees(city, department);`
   - Motivo: Ambas as colunas são usadas em agrupamentos.

3. **Relação de empregados por departamento**
   - Query: `SELECT department, employee_name FROM employees ORDER BY department;`
   - Índice sugerido: `CREATE INDEX idx_department_emp ON employees(department);`
   - Motivo: A ordenação por departamento beneficia-se do índice.

Os índices foram criados usando `CREATE INDEX` ou `ALTER TABLE`, conforme a necessidade.

## ⚙️ Parte 2 – Procedures para Manipulação de Dados

Foram desenvolvidas **procedures parametrizadas** para inserção, atualização e exclusão de registros, utilizando estruturas condicionais com base em uma variável de controle.

### ✅ Requisitos Implementados

- Uso de `CASE` ou `IF` para decidir entre `INSERT`, `UPDATE` ou `DELETE`.
- Recebimento de variáveis como parâmetros para manipulação dos dados.
- Suporte para múltiplos cenários (Universidade e E-commerce).

Exemplo de chamada da procedure:

```sql
CALL gerenciar_dados(1, 'João', 'TI', NULL);
-- 1: Inserir funcionário João no departamento TI
