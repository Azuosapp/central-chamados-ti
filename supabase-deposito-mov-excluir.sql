-- =====================================================================
-- Permite EXCLUIR uma movimentacao do deposito DESFAZENDO o efeito no estoque.
-- (Se foi uma ENTRADA de 1, ao apagar tira 1 de volta; se foi SAIDA de 1, devolve 1.)
-- Rode no Supabase > SQL Editor.
-- =====================================================================

-- Gatilho: ao apagar uma movimentacao, reverte o estoque.
create or replace function reverter_movimentacao_deposito()
returns trigger language plpgsql as $$
begin
  if old.tipo = 'entrada' then
    update deposito_itens set quantidade = greatest(0, quantidade - old.quantidade) where id = old.item_id;
  elsif old.tipo = 'saida' then
    update deposito_itens set quantidade = quantidade + old.quantidade where id = old.item_id;
  end if;
  return old;
end; $$;

drop trigger if exists trg_mov_deposito_del on deposito_movimentacoes;
create trigger trg_mov_deposito_del
after delete on deposito_movimentacoes
for each row execute function reverter_movimentacao_deposito();

-- Permite apagar movimentacao (a regra atual so deixava inserir/editar).
drop policy if exists "deposito_mov_delete" on deposito_movimentacoes;
create policy "deposito_mov_delete" on deposito_movimentacoes
  for delete to authenticated using (true);
