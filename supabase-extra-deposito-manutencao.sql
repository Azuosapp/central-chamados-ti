-- =====================================================================
-- EXTRAS: condicao no deposito (Novo/Usado) e departamento na manutencao
-- =====================================================================
-- Rode no Supabase > SQL Editor.
-- =====================================================================

-- Deposito: diferenciar pecas novas x usadas
alter table deposito_itens add column if not exists condicao text default 'Novo';

-- Manutencao: guardar o departamento da maquina (diferencia Computador 01, 02, 03)
alter table manutencoes add column if not exists computer_department text;
