-- =====================================================================
-- LIMPAR DADOS DE TESTE — Central de Chamados TI
-- =====================================================================
-- ⚠️  ATENCAO: o Supabase (plano free) NAO tem backup. Isto e IRREVERSIVEL.
-- Se tiver qualquer duvida, antes exporte pelo painel ("Baixar relatorio").
--
-- Rode as partes SEPARADAMENTE (selecione o bloco e clique em Run),
-- conforme o que voce quer apagar.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PARTE 1 (RECOMENDADA): apaga TODOS os chamados
-- e REINICIA a numeracao — o proximo chamado volta a ser CH-0001.
-- ---------------------------------------------------------------------
truncate table chamados restart identity;


-- ---------------------------------------------------------------------
-- PARTE 2 (OPCIONAL): apaga o inventario e a telemetria das maquinas.
--
-- ⚠️  Rode SOMENTE se NENHUMA maquina de verdade ja estiver cadastrada.
--     Se o "Computador 01" (ou qualquer outro) for uma maquina real que
--     voce quer manter, NAO rode este bloco.
-- ---------------------------------------------------------------------
-- truncate table hardware_live_status;
-- truncate table hardware_performance_history restart identity;
-- truncate table hardware_performance_alerts;
-- truncate table hardware_inventory;
-- truncate table network_alerts;
