@echo off
setlocal

REM Cargar variables de entorno desde client/.env si existe
if exist "client\.env" (
    for /f "usebackq tokens=1,* delims==" %%A in ("client\.env") do (
        set "%%A=%%B"
    )
)

REM Valor por defecto
if not defined API_URL set API_URL=http://127.0.0.1:8080/generate

echo Iniciando cliente Streamlit...
echo   API_URL: %API_URL%

cd client
streamlit run index.py
