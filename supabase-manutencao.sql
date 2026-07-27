-- =====================================================================
-- MANUTENCAO DOS COMPUTADORES (historico do que foi feito)
-- =====================================================================
-- Cada registro guarda: qual computador, tipo (preventiva, troca de peca,
-- etc.), o que foi feito, quem fez e a data. Pelo historico da para ver
-- quais maquinas sao mexidas com frequencia e precisam ser trocadas.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

create table if not exists manutencoes (
  id uuid primary key default gen_random_uuid(),
  computer_name text,
  computer_label text,
  tipo text not null default 'Preventiva',
  descricao text,
  responsavel text,
  data timestamptz default now(),
  created_at timestamptz default now()
);

create index if not exists idx_manutencoes_data on manutencoes (data desc);

alter table manutencoes enable row level security;

drop policy if exists "manutencoes_select" on manutencoes;
create policy "manutencoes_select" on manutencoes for select to authenticated using (true);
drop policy if exists "manutencoes_insert" on manutencoes;
create policy "manutencoes_insert" on manutencoes for insert to authenticated with check (true);
drop policy if exists "manutencoes_update" on manutencoes;
create policy "manutencoes_update" on manutencoes for update to authenticated using (true) with check (true);
drop policy if exists "manutencoes_delete" on manutencoes;
create policy "manutencoes_delete" on manutencoes for delete to authenticated using (true);
