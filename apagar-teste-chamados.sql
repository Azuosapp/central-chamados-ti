-- =====================================================================
-- Apaga os chamados de teste CH-0004 e CH-0005 e faz o PROXIMO chamado
-- voltar a ser CH-0004 (reinicia a numeracao a partir do maior id restante).
-- Rode no Supabase > SQL Editor.  ATENCAO: exclusao nao pode ser desfeita.
-- =====================================================================

delete from chamados where id in (4, 5);

-- Reinicia a sequencia: proximo id = (maior id restante) + 1  =>  como sobra ate o 3, o proximo vira 4.
select setval(pg_get_serial_sequence('chamados', 'id'), (select max(id) from chamados), true);
