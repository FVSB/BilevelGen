#!/usr/bin/env bash
set -e

# Cargar variables de entorno desde client/.env si existe
if [ -f "client/.env" ]; then
    export $(grep -v '^#' client/.env | xargs)
fi

# Valor por defecto
API_URL="${API_URL:-http://127.0.0.1:8080/generate}"

echo "Iniciando cliente Streamlit..."
echo "  API_URL: $API_URL"

cd client
streamlit run index.py
