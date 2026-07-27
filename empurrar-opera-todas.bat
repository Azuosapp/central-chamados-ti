@echo off
title Empurrar bloqueio do Opera - Grupo Azuos
color 0B
echo ==================================================
echo    EMPURRAR BLOQUEIO DO OPERA - GRUPO AZUOS
echo ==================================================
echo.
echo Coloque NESTA MESMA PASTA:
echo   - psexec.exe   (baixe o "PsTools" da Sysinternals/Microsoft)
echo   - bloquear-opera-local.bat
echo   - maquinas.txt  (um NOME DE COMPUTADOR por linha)
echo.
echo As maquinas precisam estar ligadas, na mesma rede, com a conta
echo de administrador local ativa e o compartilhamento de rede (SMB) liberado.
echo.
set /p ADMINUSER=Usuario administrador local das maquinas:
echo.
echo (Vai pedir a SENHA do administrador em seguida.)
echo.
psexec @maquinas.txt -u %ADMINUSER% -h -c -f -accepteula bloquear-opera-local.bat
echo.
echo ==================================================
echo Concluido.
echo Veja acima o resultado de cada maquina:
echo   - "error code 0"  = deu certo
echo   - offline / senha / firewall = precisa verificar aquela maquina
echo ==================================================
pause
