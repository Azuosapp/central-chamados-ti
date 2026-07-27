-- =====================================================================
-- Permite o formulario PUBLICO enviar o PRINT do erro para o bucket
-- "chamados-prints" e qualquer um visualizar a imagem (leitura publica).
-- Sem isto, abrir chamado COM print da erro de RLS.
-- Escopo: SO o bucket chamados-prints. Nada mais e exposto.
-- Rode no Supabase > SQL Editor.
-- =====================================================================

-- Envio da imagem (upload) pelo formulario publico:
drop policy if exists "chamados_prints_insert" on storage.objects;
create policy "chamados_prints_insert" on storage.objects
  for insert to anon, authenticated
  with check (bucket_id = 'chamados-prints');

-- Leitura publica da imagem (para aparecer no painel):
drop policy if exists "chamados_prints_read" on storage.objects;
create policy "chamados_prints_read" on storage.objects
  for select to anon, authenticated
  using (bucket_id = 'chamados-prints');
