@echo off
setlocal

REM Cargar variables de entorno desde .env si existe
if exist ".env" (
    for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
        set "%%A=%%B"
    )
)

REM Valores por defecto si no vienen del .env
if not defined API_HOST set API_HOST=127.0.0.1
if not defined API_PORT set API_PORT=8080
if not defined RESPONSE_PATH set RESPONSE_PATH=response/test__

echo Iniciando servidor Julia...
echo   IP:     %API_HOST%
echo   Puerto: %API_PORT%

julia def_problem/api.jl --ip %API_HOST% --port %API_PORT%
