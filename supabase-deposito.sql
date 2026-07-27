-- =====================================================================
-- DEPOSITO DE HARDWARE (estoque com entrada e saida)
-- =====================================================================
-- Duas tabelas: os itens (com a quantidade atual) e as movimentacoes
-- (cada entrada/saida). Um gatilho atualiza a quantidade automaticamente.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

create table if not exists deposito_itens (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  categoria text not null,
  quantidade int not null default 0,
  created_at timestamptz default now()
);

create table if not exists deposito_movimentacoes (
  id uuid primary key default gen_random_uuid(),
  item_id uuid references deposito_itens(id) on delete cascade,
  tipo text not null check (tipo in ('entrada','saida')),
  quantidade int not null check (quantidade > 0),
  responsavel text,
  observacao text,
  created_at timestamptz default now()
);

create index if not exists idx_deposito_mov_item on deposito_movimentacoes (item_id, created_at desc);

-- Ajusta o estoque do item a cada movimentacao inserida.
create or replace function aplicar_movimentacao_deposito()
returns trigger language plpgsql as $$
begin
  if new.tipo = 'entrada' then
    update deposito_itens set quantidade = quantidade + new.quantidade where id = new.item_id;
  else
    update deposito_itens set quantidade = greatest(0, quantidade - new.quantidade) where id = new.item_id;
  end if;
  return new;
end $$;

drop trigger if exists trg_mov_deposito on deposito_movimentacoes;
create trigger trg_mov_deposito
after insert on deposito_movimentacoes
for each row execute function aplicar_movimentacao_deposito();

alter table deposito_itens enable row level security;
alter table deposito_movimentacoes enable row level security;

-- Acesso apenas para usuario autenticado (painel).
drop policy if exists "deposito_itens_select" on deposito_itens;
create policy "deposito_itens_select" on deposito_itens for select to authenticated using (true);
drop policy if exists "deposito_itens_insert" on deposito_itens;
create policy "deposito_itens_insert" on deposito_itens for insert to authenticated with check (true);
drop policy if exists "deposito_itens_update" on deposito_itens;
create policy "deposito_itens_update" on deposito_itens for update to authenticated using (true) with check (true);
drop policy if exists "deposito_itens_delete" on deposito_itens;
create policy "deposito_itens_delete" on deposito_itens for delete to authenticated using (true);

drop policy if exists "deposito_mov_select" on deposito_movimentacoes;
create policy "deposito_mov_select" on deposito_movimentacoes for select to authenticated using (true);
drop policy if exists "deposito_mov_insert" on deposito_movimentacoes;
create policy "deposito_mov_insert" on deposito_movimentacoes for insert to authenticated with check (true);
