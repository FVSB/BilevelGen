# config.jl - Configuración del servidor desde variables de entorno
#
# Variables soportadas:
#   API_HOST     — IP donde escucha el servidor (default: 127.0.0.1)
#   API_PORT     — Puerto del servidor (default: 8080)
#   RESPONSE_PATH — Path base para archivos de respuesta (default: response/test__)

const SERVER_HOST = get(ENV, "API_HOST", "127.0.0.1")
const SERVER_PORT = parse(Int, get(ENV, "API_PORT", "8080"))
const RESPONSE_PATH = get(ENV, "RESPONSE_PATH", "response/test__")
