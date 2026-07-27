-- =====================================================================
-- ARQUIVAR MAQUINAS (remover do painel sem apagar os dados)
-- =====================================================================
-- Adiciona a coluna "arquivado". O botao "Remover" no painel marca
-- arquivado = true; a maquina some do painel mas os dados continuam no banco
-- (nada e destruido, entao e reversivel mesmo se a senha vazar).
-- Rode no Supabase > SQL Editor.
-- =====================================================================

alter table hardware_inventory add column if not exists arquivado boolean default false;

-- ---------------------------------------------------------------------
-- Para RESTAURAR uma maquina arquivada (troque o nome do computador):
-- update hardware_inventory set arquivado = false
--   where computer_name = 'DESKTOP-XXXXXXX';
--
-- Para VER as maquinas arquivadas:
-- select computer_name, display_name, department
--   from hardware_inventory where arquivado = true;
-- ---------------------------------------------------------------------
