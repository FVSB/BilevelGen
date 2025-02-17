# Importa la función preview de SymPy
from sympy import preview

# Configuración inicial
preambule=r"\DeclareMathOperator*{\argmin}{argmin} % Define el operador argmin"
latex_equation = r"""

  \begin{equation}  
    \begin{matrix}
    & \displaystyle \min_{x} \; \inf_{y \in S(x)} F(x, y) \\& g_i(x, y)\leq 0,\;i=1,\ldots,q, \\
    & \text{con } S(x) = \displaystyle \min_y \left\{ f(x, y) \mid v(x, y) \leq 0 \right\}
    \end{matrix}
    \end{equation}
   

"""
# Ecuación LaTeX
output_file = "latex_equation.svg"  # Nombre del archivo de salida

try:
    # Renderiza y guarda la imagen
    preview(
        latex_equation,
        output="svg",               # Formato de salida (puede ser "png", "pdf", "svg", etc.)
        filename=output_file,       # Nombre del archivo de salida
        viewer="file",              # Guarda el archivo en lugar de abrirlo
        euler=True,                # Desactiva la fuente Euler
        preambule=preambule,
        #dvioptions=["-T", "tight"]  # Ajusta el recorte de la imagen
    )
    print(f"La imagen ha sido guardada como '{output_file}'.")
except Exception as e:
    print("Ocurrió un error al renderizar la ecuación:")
    print(e)