-- =====================================================================
-- COLETORES BLOQUEADOS (rejeitar maquinas nao autorizadas)
-- =====================================================================
-- O proxy (api/coletor.js) passa a rejeitar os dados de qualquer maquina
-- cujo computer_name esteja nesta lista. O botao "Bloquear" no painel
-- adiciona a maquina aqui.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

create table if not exists coletores_bloqueados (
  computer_name text primary key,
  motivo text,
  created_at timestamptz default now()
);

alter table coletores_bloqueados enable row level security;

drop policy if exists "coletores_bloq_select" on coletores_bloqueados;
create policy "coletores_bloq_select" on coletores_bloqueados for select to authenticated using (true);
drop policy if exists "coletores_bloq_insert" on coletores_bloqueados;
create policy "coletores_bloq_insert" on coletores_bloqueados for insert to authenticated with check (true);
drop policy if exists "coletores_bloq_delete" on coletores_bloqueados;
create policy "coletores_bloq_delete" on coletores_bloqueados for delete to authenticated using (true);

-- ---------------------------------------------------------------------
-- Para DESBLOQUEAR uma maquina (troque o nome):
-- delete from coletores_bloqueados where computer_name = 'JOHN-PC';
--
-- Para VER as bloqueadas:
-- select * from coletores_bloqueados order by created_at desc;
-- ---------------------------------------------------------------------
