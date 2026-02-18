# CLAUDE.md — Instrucciones para Claude Code

## Descripción del Proyecto

**Generador de Problemas de Optimización Binivel** (Tesis de Matemáticas/Optimización).

Sistema para generar problemas binivel con puntos estacionarios controlados (C-Estacionario, M-Estacionario, Fuertemente-Estacionario). Arquitectura cliente-servidor:

- **Backend**: Servidor HTTP en Julia (puerto 8080) — lógica matemática + API REST
- **Frontend**: Cliente Streamlit en Python (puerto 8501) — interfaz de usuario web

## Archivos Clave

```
def_problem/
├── api.jl                    # Entrypoint del servidor HTTP (ArgParse, HTTP.jl)
├── config.jl                 # Configuración desde variables de entorno
├── solver.jl                 # Make_BF — cálculo del vector BF del líder
├── fix_restrictions.jl       # Fix_Restrictions, compute_bj — lógica central
├── serialize_date.jl         # Serialización a XLSX (DataFrames.jl)
├── parser.jl                 # parse_expression, extract_variable_names
├── utils.jl                  # get_rand, eval_point, substitute_point_in_vector
├── MiModulo.jl               # Interfaz de alto nivel para uso programático
├── model.jl                  # OptimizationModel, GeneratorModel, Set* functions
└── structs/
    ├── restriction_types.jl  # Enums: RestrictionType, RestrictionSetType
    ├── functions.jl          # Structs: Func, Restriction_Func
    ├── optimization_problem.jl  # Struct: Optimization_Problem
    ├── def_restrictions.jl   # Struct: Def_Restriction
    └── structs_declaration.jl   # Problem, OptimizationModel, structs

client/
├── index.py    # App Streamlit completa (clase Page)
└── utils.py    # ProblemShow, expresion_a_latex, get_multiplicadores_*
```

## Flujo de Datos

```
Usuario (Streamlit) → POST /generate → Julia API
  → Fix_Restrictions → Make_BF → serialize_Experiment
  → XLSX binario → Streamlit muestra resultado en LaTeX + descarga
```

## Comandos

```bash
# Servidor Julia
julia def_problem/api.jl
julia def_problem/api.jl --ip 0.0.0.0 --port 8080

# Cliente Streamlit
cd client && streamlit run index.py

# Windows (scripts de lanzamiento)
run_server.bat
run_client.bat
run_all.bat     # Ambos

# Docker
docker-compose up --build

# Dependencias Julia
julia install_dependecies.jl

# Dependencias Python
pip install -r requirements.txt
```

## Schema JSON — POST /generate

```json
{
  "vars": {"leader": ["x_1"], "follower": ["y_1"]},
  "objective_function": {"leader": "x_1^2 + y_1", "follower": "y_1^2 + x_1"},
  "restrictions": {
    "leader": [{"expresion":"x_1+y_1==0","restriction_type":"Eq","active_index_type":"Normal","miu":0}],
    "follower": [{"expresion":"y_1<=1","restriction_type":"LtEq","active_index_type":"J_0_LP_v","lambda":0.1,"beta":0.5,"gamma":0.0}]
  },
  "is_alpha_zero": false,
  "alpha_vec": [0.3],
  "point": {"x_1": 1.0, "y_1": 0.8}
}
```

## Variables de Entorno

| Variable | Default | Uso |
|---|---|---|
| `API_HOST` | `127.0.0.1` | IP donde escucha el servidor Julia |
| `API_PORT` | `8080` | Puerto del servidor Julia |
| `RESPONSE_PATH` | `response/test__` | Path para archivos temporales |
| `API_URL` | `http://127.0.0.1:8080/generate` | URL que usa el cliente Python |

## Convenciones — NO TOCAR

- **`experiment/`** — Experimentos de investigación completados. NUNCA modificar.
- **`Base.show` en structs** — No son debug, son métodos de visualización de Julia.
- **`@warn` en fix_restrictions.jl** — Son advertencias intencionales sobre correcciones automáticas.
- **`fix_multiplicator` comentado (línea 247 fix_restrictions.jl)** — Desactivado por decisión matemática.
- **`#module MiModulo` comentado** — Intencional, no descomentar sin reestructurar con `Project.toml`.

## Tipos de Restricciones (RestrictionSetType)

| Tipo | Descripción |
|---|---|
| `Normal` | Sin restricción activa en el índice |
| `J_0_g` | Activa en el nivel superior (líder) |
| `J_0_LP_v` | Activa en seguidor con lambda positivo |
| `J_0_L0_v` | Activa en seguidor con lambda cero |
| `J_Ne_L0_v` | Negativa en seguidor con lambda cero |

## Agent-OS

Este proyecto usa Agent-OS para gestión de estándares:

```bash
/discover-standards   # Extraer patrones del código como estándares
/inject-standards     # Inyectar estándares relevantes al contexto
/shape-spec           # Planificar features (en plan mode)
/plan-product         # Documentar visión del producto
```

Estándares en: `agent-os/standards/`
