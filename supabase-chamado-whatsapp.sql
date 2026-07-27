-- =====================================================================
-- Marca se a pessoa OPTOU por receber avisos do chamado no WhatsApp.
-- So quando isto for TRUE o painel mostra o botao "Avisar no WhatsApp".
-- Rode no Supabase > SQL Editor.
-- =====================================================================

alter table chamados add column if not exists avisar_whatsapp boolean default false;
