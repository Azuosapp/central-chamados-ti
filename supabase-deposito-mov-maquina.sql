-- =====================================================================
-- Liga a movimentacao do deposito a uma MAQUINA (para onde a peca foi/veio).
-- Assim, no inventario, o historico da maquina mostra as pecas do deposito.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

alter table deposito_movimentacoes add column if not exists computer_name text;
alter table deposito_movimentacoes add column if not exists computer_label text;
