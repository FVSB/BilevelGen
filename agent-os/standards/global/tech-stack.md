# Tech Stack

## Backend (Servidor)

- Julia 1.10+ con HTTP.jl (servidor REST puerto 8080)
- Symbolics.jl para cálculo simbólico de gradientes
- JSON3.jl para serialización/deserialización
- XLSX.jl + DataFrames.jl para exportar resultados
- ArgParse.jl para argumentos CLI
- LinearAlgebra (stdlib)

## Frontend (Cliente)

- Python 3.12 con Streamlit 1.41+
- SymPy para validación de expresiones matemáticas
- Pandas para lectura del XLSX de resultados
- Requests para comunicación HTTP con el servidor Julia

## Comunicación

- REST API: POST /generate (JSON → XLSX binario)
- GET /hola (health check)

## Entorno

- Variables de entorno: API_URL, API_HOST, API_PORT, RESPONSE_PATH
- .env en client/ para el cliente Python
