-- 1) Converte "Reserva" (e variações de vazio) para SEM departamento (NULL).
--    Assim some o departamento "Reserva" do filtro; tudo fica em "Sem departamento" (estoque).
update public.hardware_inventory
set department = null
where department in ('Reserva', '', 'Sem departamento');

-- 2) Máquina sem departamento = estoque/reserva, sem colaborador.
--    Limpa o nome do responsável das máquinas que estão sem departamento.
update public.hardware_inventory
set responsible_name = null
where department is null;
