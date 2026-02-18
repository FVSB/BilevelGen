#!/usr/bin/env bash
set -e

# Cargar variables de entorno desde .env si existe
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Valores por defecto
API_HOST="${API_HOST:-127.0.0.1}"
API_PORT="${API_PORT:-8080}"
RESPONSE_PATH="${RESPONSE_PATH:-response/test__}"

echo "Iniciando servidor Julia..."
echo "  IP:     $API_HOST"
echo "  Puerto: $API_PORT"

julia def_problem/api.jl --ip "$API_HOST" --port "$API_PORT"
