#!/usr/bin/env bash
set -e

echo "============================================"
echo " Build cliente Python con PyInstaller"
echo "============================================"
echo ""
echo "ADVERTENCIA: Streamlit + PyInstaller tienen compatibilidad limitada."
echo "Se recomienda usar Docker (docker-compose up) o run_client.sh en su lugar."
echo ""

# Verificar que pyinstaller esté instalado
if ! command -v pyinstaller &>/dev/null; then
    echo "Instalando PyInstaller..."
    pip install pyinstaller
fi

echo "Construyendo ejecutable..."
cd client
pyinstaller --onefile --name "cliente_binivel" --add-data "*.py:." index.py

echo ""
echo "Ejecutable generado en: client/dist/cliente_binivel"
echo ""
echo "Para ejecutar:"
echo "  ./client/dist/cliente_binivel"
