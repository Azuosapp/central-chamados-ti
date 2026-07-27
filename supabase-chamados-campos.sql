-- =====================================================================
-- CAMPOS NOVOS DE CHAMADO + PERMISSAO DE EXCLUIR (Painel do TI)
-- =====================================================================
-- Adiciona prioridade, contato do solicitante, responsavel do TI e a data
-- de resolucao (para o indicador de tempo medio). Tambem cria a policy que
-- permite o painel (autenticado) excluir chamados.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

alter table chamados add column if not exists prioridade text default 'Média';
alter table chamados add column if not exists contato text;
alter table chamados add column if not exists responsavel text;
alter table chamados add column if not exists atendimento_em timestamptz;
alter table chamados add column if not exists resolvido_em timestamptz;

-- Excluir chamado: somente usuario autenticado (painel).
drop policy if exists "chamados_delete_autenticado" on chamados;
create policy "chamados_delete_autenticado"
  on chamados for delete
  to authenticated
  using (true);
