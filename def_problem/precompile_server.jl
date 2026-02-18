using HTTP
using JSON3
using XLSX
using DataFrames
using ArgParse
using Symbolics
using LinearAlgebra
using Random

# Warmup para PackageCompiler.
# NO incluir api.jl porque llama a main() y arrancaría el servidor.
# Solo cargar los paquetes es suficiente para precompilar.
