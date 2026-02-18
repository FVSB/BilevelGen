"""
build_sysimage.jl — Crea una sysimage de Julia con PackageCompiler.

Reduce el tiempo de arranque del servidor de ~60s a ~5s.

Uso:
    julia build_sysimage.jl

Luego iniciar el servidor con:
    julia --sysimage build/tesis.so def_problem/api.jl   # Linux/Mac
    julia --sysimage build/tesis.dll def_problem/api.jl  # Windows
"""

using Pkg
Pkg.add("PackageCompiler")
using PackageCompiler

mkpath("build")

# Extensión correcta según el SO
sysimage_ext = Sys.iswindows() ? "dll" : "so"
sysimage_path = "build/tesis.$sysimage_ext"

println("Creando sysimage en $sysimage_path ...")
println("Esto puede tardar varios minutos la primera vez.")

create_sysimage(
    [:HTTP, :JSON3, :XLSX, :DataFrames, :ArgParse, :Symbolics, :LinearAlgebra, :Random],
    sysimage_path = sysimage_path,
    precompile_execution_file = "def_problem/precompile_server.jl"
)

println("")
println("Sysimage creada en: $sysimage_path")
println("")
println("Para usar:")
println("  julia --sysimage $sysimage_path def_problem/api.jl")
