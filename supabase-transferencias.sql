-- =====================================================================
-- Historico de TRANSFERENCIAS de departamento das maquinas.
-- Cada vez que uma maquina muda de departamento, guarda de -> para, quem e quando.
-- O departamento ATUAL continua em hardware_inventory.department.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

create table if not exists transferencias (
  id uuid primary key default gen_random_uuid(),
  computer_name text,
  computer_label text,
  de_departamento text,
  para_departamento text,
  responsavel text,
  observacao text,
  created_at timestamptz default now()
);

create index if not exists idx_transferencias_maquina on transferencias (computer_name, created_at desc);

alter table transferencias enable row level security;
drop policy if exists "transferencias_select" on transferencias;
create policy "transferencias_select" on transferencias for select to authenticated using (true);
drop policy if exists "transferencias_insert" on transferencias;
create policy "transferencias_insert" on transferencias for insert to authenticated with check (true);
