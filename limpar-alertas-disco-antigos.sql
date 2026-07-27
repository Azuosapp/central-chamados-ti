-- =====================================================================
-- LIMPAR alertas antigos de DISCO (baseados em uso/leitura - ruido)
-- =====================================================================
-- Remove os alertas de "Disco 100%" que vinham do disco OCUPADO lendo/gravando.
-- Esses tinham threshold 98. Os NOVOS alertas de disco cheio usam threshold 90,
-- entao NAO sao afetados por esta limpeza.
--
-- Rode no Supabase > SQL Editor.
-- =====================================================================

-- 1) (Opcional) Ver quantos serao apagados antes:
select count(*) as alertas_disco_antigos
from hardware_performance_alerts
where metric = 'Disco' and coalesce(threshold, 98) >= 95;

-- 2) Apagar os alertas antigos de disco (uso/leitura):
delete from hardware_performance_alerts
where metric = 'Disco' and coalesce(threshold, 98) >= 95;
