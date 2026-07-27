@echo off
title Bloquear Opera - Grupo Azuos

:: Pede permissao de administrador sozinho (UAC)
net session >nul 2>&1
if %errorlevel% neq 0 (
  echo Solicitando permissao de administrador...
  powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)

color 0B
echo ==================================================
echo     BLOQUEAR NAVEGADOR OPERA - GRUPO AZUOS
echo ==================================================
echo.

echo Fechando o Opera (se estiver aberto)...
taskkill /f /im opera.exe >nul 2>&1

echo Removendo Opera / Opera GX de todos os perfis...
for /d %%U in ("C:\Users\*") do (
  rmdir /s /q "%%U\AppData\Local\Programs\Opera" >nul 2>&1
  rmdir /s /q "%%U\AppData\Local\Programs\Opera GX" >nul 2>&1
  rmdir /s /q "%%U\AppData\Roaming\Opera Software" >nul 2>&1
  rmdir /s /q "%%U\AppData\Local\Opera Software" >nul 2>&1
  del /f /q "%%U\Desktop\Opera*.lnk" >nul 2>&1
  del /f /q "%%U\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Opera*.lnk" >nul 2>&1
)
rmdir /s /q "C:\Program Files\Opera" >nul 2>&1
rmdir /s /q "C:\Program Files (x86)\Opera" >nul 2>&1
del /f /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Opera*.lnk" >nul 2>&1
del /f /q "C:\Users\Public\Desktop\Opera*.lnk" >nul 2>&1

echo Bloqueando a execucao (impede abrir mesmo reinstalando)...
for %%E in (opera.exe OperaSetup.exe OperaGXSetup.exe Opera_Setup.exe OperaGX_Setup.exe) do (
  reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%E" /v Debugger /t REG_SZ /d "C:\Windows\System32\systray.exe" /f >nul 2>&1
)

echo.
echo ==================================================
echo  PRONTO! Opera removido e bloqueado nesta maquina.
echo  (nao abre mais, mesmo se reinstalar)
echo ==================================================
echo.
echo Para DESBLOQUEAR no futuro, rode como admin:
echo   reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\opera.exe" /f
echo.
pause
