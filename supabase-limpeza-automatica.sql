-- =====================================================================
-- LIMPEZA AUTOMATICA (retencao) - mantem o banco leve
-- =====================================================================
-- Apaga sozinho, todo dia:
--   * telemetria (hardware_performance_history) com mais de 30 dias
--   * alertas (hardware_performance_alerts) com mais de 90 dias
--
-- COMO USAR NO SUPABASE:
-- 1) Painel do Supabase > Database > Extensions > habilite "pg_cron".
--    (ou apenas rode o CREATE EXTENSION abaixo, se o seu projeto permitir)
-- 2) Cole este arquivo em SQL Editor e rode uma vez. Pronto, roda sozinho.
--
-- Para ver os jobs agendados:  select * from cron.job;
-- Para remover um job:         select cron.unschedule('nome_do_job');
-- =====================================================================

create extension if not exists pg_cron;

-- Telemetria: guarda 30 dias (roda todo dia as 03:00 UTC)
select cron.schedule(
  'limpar_history_30d',
  '0 3 * * *',
  $$ delete from hardware_performance_history where sampled_at < now() - interval '30 days'; $$
);

-- Alertas: guarda 90 dias (roda todo dia as 03:10 UTC)
select cron.schedule(
  'limpar_alertas_90d',
  '10 3 * * *',
  $$ delete from hardware_performance_alerts where started_at < now() - interval '90 days'; $$
);
