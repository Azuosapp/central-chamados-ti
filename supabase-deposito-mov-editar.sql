-- =====================================================================
-- Permite EDITAR a observacao/responsavel de uma movimentacao do deposito.
-- (A regra atual so deixava inserir. Isso nao mexe no estoque - o gatilho
--  de estoque so roda no INSERT, nunca no UPDATE.)
-- Rode no Supabase > SQL Editor.
-- =====================================================================

drop policy if exists "deposito_mov_update" on deposito_movimentacoes;
create policy "deposito_mov_update" on deposito_movimentacoes
  for update to authenticated using (true) with check (true);
