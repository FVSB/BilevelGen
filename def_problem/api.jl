using HTTP
using JSON3
using XLSX
using DataFrames
using ArgParse
include("config.jl")
include("solver.jl")
include("serialize_date.jl")

# Schema JSON esperado en POST /generate:
# {
#   "vars": {"leader": ["x_1"], "follower": ["y_1"]},
#   "objective_function": {"leader": "...", "follower": "..."},
#   "restrictions": {
#     "leader": [{"expresion":"...","restriction_type":"LtEq","active_index_type":"Normal","miu":0.0}],
#     "follower": [{"expresion":"...","restriction_type":"LtEq","active_index_type":"J_0_LP_v","lambda":0.1,"beta":0.5,"gamma":0.0}]
#   },
#   "is_alpha_zero": false,
#   "alpha_vec": [0.3],
#   "point": {"x_1": 1.0, "y_1": 0.8}
# }

function _to_def_restrictions(restrictions_vec, is_leader::Bool)
    response::Vector{Def_Restriction} = Vector{Def_Restriction}()
    for res in restrictions_vec
        expr = res["expresion"]
        restriction_type_set = to_restriction_set_type(res["active_index_type"])
        restriction_type = to_restriction_type(res["restriction_type"])
        __miu = 0
        __lambda = 0
        __beta = 0
        __gamma = 0
        if is_leader
            __miu = res["miu"]
        else
            __lambda = res["lambda"]
            __beta = res["beta"]
            __gamma = res["gamma"]
        end
        temp = Def_Restriction_init(expr, restriction_type_set, restriction_type, is_leader, __miu, __beta, __lambda, __gamma)
        push!(response, temp)
    end
    if isempty(response)
        return nothing
    end
    return response
end

function _get_restrictions(request)
    restrictions = request["restrictions"]
    leader_restrictions = restrictions["leader"]
    follower_restrictions = restrictions["follower"]
    leader_solve = _to_def_restrictions(leader_restrictions, true)
    follower_solve = _to_def_restrictions(follower_restrictions, false)
    return leader_solve, follower_solve
end

function _to_dict_point(request, x_s_vars, y_s_vars)
    point = request["point"]
    dic = Dict()
    for x in x_s_vars
        dic[x] = point[x]
    end
    for y in y_s_vars
        dic[y] = point[y]
    end
    return dic
end

function to_vector_from_json(vec_json, is_string::Bool)
    if is_string
        res = Vector{String}()
    else
        res = Vector()
    end
    for val in vec_json
        push!(res, val)
    end
    return res
end

function solver_problem(request, file_name::String)
    vars = request["vars"]
    leader_vars = to_vector_from_json(vars["leader"], true)
    follower_vars = to_vector_from_json(vars["follower"], true)
    objectives = request["objective_function"]
    leader_obj = objectives["leader"]
    follower_obj = objectives["follower"]
    leader_restrictions, follower_restrictions = _get_restrictions(request)
    is_alpha_zero = request["is_alpha_zero"]
    alpha_vec = to_vector_from_json(request["alpha_vec"], false)
    if is_alpha_zero
        alpha_vec = zeros(length(follower_vars))
    end
    point = _to_dict_point(request, leader_vars, follower_vars)

    opt_problem = Fix_Restrictions(leader_obj, leader_restrictions, follower_obj, follower_restrictions, point, leader_vars, follower_vars, alpha_vec, is_alpha_zero)

    BF_vector = Make_BF(opt_problem, leader_vars, follower_vars, alpha_vec)
    return serialize_Experiment(opt_problem, alpha_vec, BF_vector, leader_vars, follower_vars, file_name, is_alpha_zero)
end

function handle_request(req::HTTP.Request)
    body = String(req.body)

    if req.target == "/hola" && req.method == "GET"
        response = Dict("message" => "Hola! Esta es la subdireccion /hola")
        return HTTP.Response(200, JSON3.write(response))
    elseif req.method == "POST" && req.target == "/generate"
        try
            data = JSON3.read(body)
            xlsx_data, filename = solver_problem(data, RESPONSE_PATH)
            return HTTP.Response(
                200,
                [
                    "Content-Type" => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                    "Content-Disposition" => "attachment; filename=$filename"
                ],
                xlsx_data
            )
        catch e
            @error "Error al procesar solicitud /generate" exception=(e, catch_backtrace())
            return HTTP.Response(400, "Error en el formato JSON o al procesar el problema")
        end
    else
        return HTTP.Response(404, "Ruta no encontrada")
    end
end

function parse_arguments()
    settings = ArgParseSettings(
        description = "Servidor HTTP - Generador de Problemas Binivel",
        version = "1.0",
        add_help = true
    )

    @add_arg_table! settings begin
        "--ip", "-i"
            help = "Direccion IP para escuchar (o variable de entorno API_HOST)"
            default = SERVER_HOST
        "--port", "-p"
            help = "Puerto para el servidor (o variable de entorno API_PORT)"
            arg_type = Int
            default = SERVER_PORT
    end

    return parse_args(settings)
end

function main()
    args = parse_arguments()

    println("Iniciando servidor en:")
    println("  IP:     $(args["ip"])")
    println("  Puerto: $(args["port"])")

    server = HTTP.serve(handle_request, args["ip"], args["port"])
    println("Servidor activo en http://$(args["ip"]):$(args["port"])")

    try
        wait(server)
    catch e
        e isa InterruptException || rethrow(e)
        println("Servidor detenido")
    end
end

main()
