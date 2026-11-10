@echo off
setlocal enabledelayedexpansion

:: ------------------------------------------------------------
:: Substitui recursivamente todos os .bk2 em Mods, Saved/Cache/Movies
:: e Content/Movies pelo dummy.bk2 baixado do GitHub.
:: Caminhos resolvidos a partir da pasta do script.
:: o script PRECISA estar na pasta ShooterGame/Content/Movies/
:: ------------------------------------------------------------

set "DUMMY_URL=https://raw.githubusercontent.com/llbranco/arksurvivalascended_zero_movies/main/dummy.bk2"
set "DUMMY_FILE=dummy.bk2"

REM Pasta do script (termina com \)
set "SCRIPT_DIR=%~dp0"

REM Caminhos-alvo relativos ao SCRIPT_DIR (assumindo .../ShooterGame/Content/Movies/)
set "DIR_CONTENT_MOVIES=%SCRIPT_DIR%"
set "DIR_MODS=%SCRIPT_DIR%..\..\..\Binaries\Win64\ShooterGame\Mods"
set "DIR_SAVED_MOVIES=%SCRIPT_DIR%..\..\..\Saved\Cache\Movies"

REM Baixa o dummy na pasta do script
pushd "%SCRIPT_DIR%"
echo Baixando %DUMMY_FILE% ...
curl -L -o "%DUMMY_FILE%" "%DUMMY_URL%"

if not exist "%DUMMY_FILE%" (
    echo ERRO: Falha ao baixar %DUMMY_FILE%.
    popd
    exit /b 1
)

for %%A in ("%DUMMY_FILE%") do set "DUMMY_SIZE=%%~zA"
if "%DUMMY_SIZE%"=="0" (
    echo ERRO: %DUMMY_FILE% esta vazio.
    popd
    exit /b 1
)

set "DUMMY_PATH=%SCRIPT_DIR%%DUMMY_FILE%"

echo Substituindo todos os arquivos .bk2...

call :replace_in "%DIR_CONTENT_MOVIES%"
call :replace_in "%DIR_MODS%"
call :replace_in "%DIR_SAVED_MOVIES%"

echo Concluido. Todos os .bk2 foram substituidos pelo dummy.
popd
endlocal
pause
exit /b 0

:replace_in
set "TARGET_DIR=%~1"
if not exist "%TARGET_DIR%\" (
    echo AVISO: pasta nao encontrada, pulando: %TARGET_DIR%
    goto :eof
)
for /r "%TARGET_DIR%" %%F in (*.bk2) do (
    if /I not "%%~nxF"=="%DUMMY_FILE%" (
        copy /Y "%DUMMY_PATH%" "%%F" >nul
        echo   -^> %%F substituido
    )
)
goto :eof
