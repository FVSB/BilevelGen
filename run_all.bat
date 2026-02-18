@echo off
setlocal

echo ============================================
echo  Generador de Problemas Binivel - Tesis
echo ============================================

REM Cargar variables de entorno desde .env si existe
if exist ".env" (
    for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
        set "%%A=%%B"
    )
)

if not defined API_HOST set API_HOST=127.0.0.1
if not defined API_PORT set API_PORT=8080

echo.
echo [1/2] Iniciando servidor Julia en background...
echo       IP: %API_HOST%, Puerto: %API_PORT%
start "Julia Server" cmd /k "julia def_problem/api.jl --ip %API_HOST% --port %API_PORT%"

echo.
echo [2/2] Esperando 30 segundos para que Julia cargue...
timeout /t 30 /nobreak

echo.
echo Iniciando cliente Streamlit...
call run_client.bat
