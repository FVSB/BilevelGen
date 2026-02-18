@echo off
setlocal

echo ============================================
echo  Build cliente Python con PyInstaller
echo ============================================
echo.
echo ADVERTENCIA: Streamlit + PyInstaller tienen compatibilidad limitada.
echo Se recomienda usar Docker (docker-compose up) o run_client.bat en su lugar.
echo.

REM Verificar que pyinstaller esté instalado
where pyinstaller >nul 2>&1
if errorlevel 1 (
    echo Instalando PyInstaller...
    pip install pyinstaller
)

echo Construyendo ejecutable...
cd client
pyinstaller --onefile --name "cliente_binivel" --add-data "*.py;." index.py

echo.
echo Ejecutable generado en: client\dist\cliente_binivel.exe
echo.
echo Para ejecutar:
echo   client\dist\cliente_binivel.exe
