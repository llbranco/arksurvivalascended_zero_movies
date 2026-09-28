@echo off
setlocal enabledelayedexpansion

REM ------------------------------------------------------------
REM Script para substituir todos os arquivos .bk2 de uma pasta
REM pelo arquivo dummy.bk2 baixado do GitHub.
REM ------------------------------------------------------------

set "DUMMY_URL=https://raw.githubusercontent.com/llbranco/arksurvivalascended_zero_movies/main/dummy.bk2"
set "DUMMY_FILE=dummy.bk2"

echo Baixando %DUMMY_FILE% ...

REM Usa curl (nativo no Windows 10/11). -L segue redirecionamentos.
curl -L -o "%DUMMY_FILE%" "%DUMMY_URL%"

REM Verifica se o download foi bem-sucedido
if not exist "%DUMMY_FILE%" (
    echo ERRO: Falha ao baixar %DUMMY_FILE%.
    exit /b 1
)

REM Verifica se o arquivo nao esta vazio (tamanho 0)
for %%A in ("%DUMMY_FILE%") do set "DUMMY_SIZE=%%~zA"
if "%DUMMY_SIZE%"=="0" (
    echo ERRO: %DUMMY_FILE% esta vazio.
    exit /b 1
)

echo Substituindo todos os arquivos .bk2 na pasta atual...

REM Percorre todos os .bk2 no diretorio atual
for %%F in (*.bk2) do (
    REM Nao sobrescreve o proprio dummy
    if /I not "%%F"=="%DUMMY_FILE%" (
        copy /Y "%DUMMY_FILE%" "%%F" >nul
        echo   -^> %%F substituido
    )
)

echo Concluido. Todos os .bk2 foram substituidos pelo dummy.
endlocal
pause
