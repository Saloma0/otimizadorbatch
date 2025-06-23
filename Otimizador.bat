@echo off
setlocal enabledelayedexpansion

:: Configurações iniciais
title Otimizador de Sistema Avancado
color 0A
mode con: cols=80 lines=30

:: Verificar se está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Este programa requer privilégios de administrador.
    echo Por favor, execute como administrador.
    pause
    exit /b
)

:menu
cls
echo ========================================================
echo            OTIMIZADOR DE SISTEMA AVANCADO
echo ========================================================
echo [1] Ativar Windows (KMS)
echo [2] Limpeza Avançada de Disco
echo [3] Limpar Pastas Temporárias
echo [4] Limpar Lixeira
echo [5] Reiniciar/Desligar PC
echo [6] Seguranca do Sistema
echo [7] Testar Velocidade da Internet
echo [8] AtualizaÁões do Windows
echo [9] Gerenciar Inicializacao
echo [A] OtimizaÁão Completa
echo [B] Otimizar Windows 7 e 8
echo [D] Suporte no Discord
echo [S] ConfiguraÁões
echo [Q] Sair
echo ========================================================
set /p choice=Escolha uma opÁão (1-9, A, B, D, S ou Q): 

if /i "%choice%"=="1" goto ativar_windows
if /i "%choice%"=="2" goto limpar_disco
if /i "%choice%"=="3" goto limpar_temp
if /i "%choice%"=="4" goto limpar_lixeira
if /i "%choice%"=="5" goto reiniciar_pc
if /i "%choice%"=="6" goto seguranca
if /i "%choice%"=="7" goto testar_velocidade
if /i "%choice%"=="8" goto verificar_atualizacoes
if /i "%choice%"=="9" goto gerenciar_inicializacao
if /i "%choice%"=="a" goto otimizacao_completa
if /i "%choice%"=="b" goto otimizar_windows_7_8
if /i "%choice%"=="d" goto discord
if /i "%choice%"=="s" goto configuracoes
if /i "%choice%"=="q" goto sair

:: Se nenhuma opÁão vÁlida foi selecionada
echo Opcao invalida! Por favor, tente novamente.
pause
goto menu

:ativar_windows
cls
echo ========================================================
echo            ATIVA«√O DO WINDOWS (KMS)
echo ========================================================
echo [1] Ativar Windows 10/11
echo [2] Ativar Office
echo [3] Verificar status de ativaÁão
echo [Q] Voltar ao menu
echo ========================================================
set /p choice=Escolha uma opÁão:

if /i "%choice%"=="1" (
    echo Ativando Windows...
    cscript //nologo %windir%\system32\slmgr.vbs /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99 >nul
    cscript //nologo %windir%\system32\slmgr.vbs /skms kms8.msguides.com >nul
    cscript //nologo %windir%\system32\slmgr.vbs /ato >nul
    echo Windows ativado com sucesso!
    pause
    goto ativar_windows
)
if /i "%choice%"=="2" (
    echo Ativando Office...
    cd /d "%ProgramFiles(x86)%\Microsoft Office\Office16"
    cscript ospp.vbs /sethst:kms8.msguides.com
    cscript ospp.vbs /act
    echo Office ativado com sucesso!
    pause
    goto ativar_windows
)
if /i "%choice%"=="3" (
    echo Verificando status de ativaÁão...
    cscript //nologo %windir%\system32\slmgr.vbs /xpr
    pause
    goto ativar_windows
)
if /i "%choice%"=="q" goto menu
goto ativar_windows

:limpar_disco
cls
echo ========================================================
echo            LIMPEZA AVAN«ADA DE DISCO
echo ========================================================
echo [1] Limpeza bÁsica
echo [2] Limpeza completa (incluindo system32)
echo [3] Limpar arquivos de atualizaÁões antigas
echo [Q] Voltar ao menu
echo ========================================================
set /p choice=Escolha uma opÁão:

if /i "%choice%"=="1" (
    echo Executando limpeza bÁsica de disco...
    cleanmgr /sagerun:1
    echo Limpeza concluÝda!
    pause
    goto limpar_disco
)
if /i "%choice%"=="2" (
    echo Executando limpeza completa...
    cleanmgr /sagerun:1
    Dism /online /Cleanup-Image /StartComponentCleanup
    Dism /online /Cleanup-Image /SPSuperseded
    echo Limpeza completa concluÝda!
    pause
    goto limpar_disco
)
if /i "%choice%"=="3" (
    echo Limpando arquivos de atualizaÁões antigas...
    Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase
    echo Limpeza concluÝda!
    pause
    goto limpar_disco
)
if /i "%choice%"=="q" goto menu
goto limpar_disco

:limpar_temp
cls
echo Limpando Pastas TemporÁrias...
echo Por favor aguarde, isso pode levar alguns minutos...

set folders="%temp%" "%windir%\temp" "%systemroot%\Prefetch" "%localappdata%\temp"
for %%f in (%folders%) do (
    if exist %%f (
        echo Limpando %%f...
        del /s /f /q "%%f\*" >nul
        for /d %%d in ("%%f\*") do rd /s /q "%%d" >nul 2>&1
    )
)

echo Limpando cache do DNS...
ipconfig /flushdns >nul

echo Limpeza concluÝda com sucesso!
pause
goto menu

:limpar_lixeira
cls
echo Deseja realmente limpar a lixeira? [S/N]
set /p choice=

if /i "%choice%"=="S" (
    echo Limpando a Lixeira...
    PowerShell -NoProfile -Command Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    echo Lixeira limpa com sucesso!
) else (
    echo OperaÁão cancelada.
)
pause
goto menu

:reiniciar_pc
cls
echo ========================================================
echo            REINICIAR/DESLIGAR PC
echo ========================================================
echo [1] Reiniciar agora
echo [2] Desligar agora
echo [3] Reiniciar apµs 1 minuto
echo [4] Cancelar reiniciaÁão agendada
echo [Q] Voltar ao menu
echo ========================================================
set /p choice=Escolha uma opÁão:

if /i "%choice%"=="1" (
    shutdown /r /t 0
    goto sair
)
if /i "%choice%"=="2" (
    shutdown /s /t 0
    goto sair
)
if /i "%choice%"=="3" (
    shutdown /r /t 60
    echo O computador serÁ reiniciado em 1 minuto.
    pause
    goto reiniciar_pc
)
if /i "%choice%"=="4" (
    shutdown /a
    echo ReiniciaÁão agendada cancelada.
    pause
    goto reiniciar_pc
)
if /i "%choice%"=="q" goto menu
goto reiniciar_pc

:seguranca
cls
echo ========================================================
echo            SEGURAN«A DO SISTEMA
echo ========================================================
echo [1] Executar MRT (RemoÁão de Malware)
echo [2] Verificar integridade do sistema
echo [3] Verificar arquivos corrompidos
echo [4] Verificar discos
echo [Q] Voltar ao menu
echo ========================================================
set /p choice=Escolha uma opÁão:

if /i "%choice%"=="1" (
    echo Executando Ferramenta de RemoÁão de Malware...
    mrt
    pause
    goto seguranca
)
if /i "%choice%"=="2" (
    echo Verificando integridade do sistema...
    sfc /scannow
    echo VerificaÁão concluÝda!
    pause
    goto seguranca
)
if /i "%choice%"=="3" (
    echo Verificando arquivos corrompidos...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo VerificaÁão concluÝda!
    pause
    goto seguranca
)
if /i "%choice%"=="4" (
    echo Verificando discos...
    chkdsk /f /r
    echo VerificaÁão agendada para o prµximo reinÝcio.
    pause
    goto seguranca
)
if /i "%choice%"=="q" goto menu
goto seguranca

:testar_velocidade
cls
echo Testando velocidade da internet...
echo Abrindo SpeedTest...
start "" "https://www.speedtest.net/pt"
echo Caso o site nÆo abra automaticamente, acesse: https://www.speedtest.net/pt
pause
goto menu

:verificar_atualizacoes
cls
echo Verificando atualizaÁões do Windows...
echo Abrindo Windows Update...
start ms-settings:windowsupdate
echo Caso nÆo abra automaticamente, vÁ para ConfiguraÁões > AtualizaÁão e SeguranÁa
pause
goto menu

:gerenciar_inicializacao
cls
echo Abrindo Gerenciador de Tarefas (InicializaÁão)...
taskmgr /0 /startup
echo Caso nÆo abra automaticamente, pressione Ctrl+Shift+Esc e vÁ para a aba Inicializar
pause
goto menu

:otimizacao_completa
cls
echo ========================================================
echo            OTIMIZA«√O COMPLETA DO SISTEMA
echo ========================================================
echo Esta operaÁão realizarÁ as seguintes aÁões:
echo 1. Limpeza de disco
echo 2. Limpeza de arquivos temporÁrios
echo 3. Limpeza da lixeira
echo 4. DesfragmentaÁão de disco (HDD apenas)
echo 5. VerificaÁão de arquivos do sistema
echo 6. VerificaÁão de atualizaÁões
echo.
echo Deseja continuar? [S/N]
set /p choice=

if /i "%choice%"=="S" (
    echo Iniciando otimizaÁão completa...
    
    echo Etapa 1/6: Limpeza de disco...
    cleanmgr /sagerun:1
    
    echo Etapa 2/6: Limpeza de arquivos temporÁrios...
    call :limpar_temp
    
    echo Etapa 3/6: Limpeza da lixeira...
    PowerShell -NoProfile -Command Clear-RecycleBin -Force
    
    echo Etapa 4/6: DesfragmentaÁão de disco...
    defrag C: /O /U /V
    
    echo Etapa 5/6: VerificaÁão de arquivos do sistema...
    sfc /scannow
    
    echo Etapa 6/6: VerificaÁão de atualizaÁões...
    start ms-settings:windowsupdate
    
    echo OtimizaÁão completa concluÝda!
) else (
    echo OperaÁão cancelada.
)
pause
goto menu

:discord
cls
start "" "https://discord.gg/g9gJcGe6dx"
echo Abrindo o servidor do Discord...
echo Caso nÆo abra automaticamente, acesse: https://discord.gg/g9gJcGe6dx
pause
goto menu

:configuracoes
cls
echo ========================================================
echo            CONFIGURA«√ES DO OTIMIZADOR
echo ========================================================
echo [1] Verificar versão
echo [2] Atualizar script
echo [3] Criar atalho na Ãrea de trabalho
echo [Q] Voltar ao menu
echo ========================================================
set /p choice=Escolha uma opÁão:

if /i "%choice%"=="1" (
    echo Versão 2.0 - Otimizador de Sistema Avançado
    pause
    goto configuracoes
)
if /i "%choice%"=="2" (
    echo Verificando atualizaÁões...
    powershell -command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/seurepositorio/otimizador/main/otimizador.bat' -OutFile '%~f0'"
    echo Script atualizado! Reinicie o programa.
    pause
    exit
)
if /i "%choice%"=="3" (
    echo Criando atalho na Ãrea de trabalho...
    set SCRIPT_PATH=%~f0
    set SHORTCUT_PATH=%USERPROFILE%\Desktop\Otimizador.lnk
    powershell -command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT_PATH%'); $s.TargetPath = '%SCRIPT_PATH%'; $s.WorkingDirectory = '%~dp0'; $s.Save()"
    echo Atalho criado com sucesso!
    pause
    goto configuracoes
)
if /i "%choice%"=="q" goto menu
goto configuracoes

:otimizar_windows_7_8
cls
echo =========================================================
echo          OTIMIZAR WINDOWS 7 E 8
echo =========================================================
echo [1] Limpar Disco Rígido
echo [2] Limpar Pastas Temporárias
echo [3] Limpar Lixeira
echo [4] Defragmentar Disco
echo [5] Verificar Atualizações do Windows
echo [6] Ativar Windows
echo [Q] Voltar ao Menu Principal
echo =========================================================
set /p choice=Escolha uma opção (1-5 ou Q): 

if /i "%choice%"=="1" goto limpar_disco_7_8
if /i "%choice%"=="2" goto limpar_temp_7_8
if /i "%choice%"=="3" goto limpar_lixeira_7_8
if /i "%choice%"=="4" goto defragmentar_disco
if /i "%choice%"=="5" goto verificar_atualizacoes_7_8
if /i "%choice%"=="6" goto ativar_windows_7_8
if /i "%choice%"=="q" goto menu
goto otimizar_windows_7_8

:limpar_disco_7_8
cls
echo Limpando o Disco Rígido...
cleanmgr /sagerun:1
echo Limpeza do disco concluída.
pause
goto otimizar_windows_7_8

:limpar_temp_7_8
cls
echo Limpando Pastas Temporárias...
del /s /f /q "%temp%\*"
del /s /f /q "%windir%\Temp\*"
echo Pastas temporárias limpas.
pause
goto otimizar_windows_7_8

:limpar_lixeira_7_8
cls
echo Limpando a Lixeira...
PowerShell -NoProfile -Command Clear-RecycleBin -Confirm:$false
echo Lixeira limpa.
pause
goto otimizar_windows_7_8

:defragmentar_disco
cls
echo Defragmentando o Disco Rígido...
defrag C: /O /V
echo Defragmentação concluída.
pause
goto otimizar_windows_7_8

:verificar_atualizacoes_7_8
cls
echo Verificando atualizações do Windows...
start %windir%\System32\wusa.exe
echo Verificação de atualizações concluída.
pause
goto otimizar_windows_7_8

:ativar_windows_7_8
cls
echo Isto foi retirado na ultima atualizacao...
pause
goto otimizar_windows_7_8

:sair
exit
