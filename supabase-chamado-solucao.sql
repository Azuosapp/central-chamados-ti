-- =====================================================================
-- Campo para o TI registrar O QUE FOI FEITO para resolver o chamado.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

alter table chamados add column if not exists solucao text;
