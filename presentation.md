---
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
marp: true
backgroundImage: url('https://marp.app/assets/hero-background.jpg')'
---

# Un generador de problemas prueba para evaluar la calidad de la solución de los algoritmos de problemas de optimización de dos niveles

**Autor**: Francisco Vicente Suárez Bellón  
**Tutora**: Dra. C. Gemayqzel Bouza Allende  
**Universidad de La Habana**  
**Facultad de Matemática y Computación**

---

- Introducción 
  - Que es un bilevel
  - Son utiles los bilevel
  - Son dificiles


---

## Introducción

 - Los problemas de optimización binivel son fundamentales.  



  - Es difícil garantizar soluciones óptimas globales en problemas binivel.  
  - Necesidad de herramientas para evaluar el rendimiento de algoritmos en problemas específicos.  

---


## Problema de optimización Binivel

**Definición formal**:  
$$
\DeclareMathOperator*{\argmin}{argmin} % Define el operador argmin
  \begin{equation}  
    \begin{matrix}
    & \displaystyle \min_{x} \; F(x, y) \\& g_i(x, y)\leq 0,\;i=1,\ldots,q, \\
    & \text{con } S(x) = \displaystyle \argmin_y \left\{ f(x, y) \mid v(x, y) \leq 0 \right\}
    \end{matrix}
    \end{equation}
   

$$
---

**Características**:  
- Dos niveles jerárquicos: líder (nivel superior) y seguidor (nivel inferior).  
- Interdependencia entre las decisiones del líder y el seguidor.  
---
## Objetivo  
  - Desarrollar un generador de problemas binivel con puntos estacionarios controlados para evaluar algoritmos de optimización.

---
## Enfoque KKT

- **Transformación del problema**:  
  - Reemplazar el problema del nivel inferior por las condiciones de Karush-Kuhn-Tucker (KKT).  
  - Resultado: Un problema MPEC (Mathematical Program with Equilibrium Constraints).  

**Restricciones de complementariedad**:  
$$
G_j(z) \geq 0, H_j(z) \geq 0, G_j(z)H_j(z) = 0.
$$
---

## Problema reformulado a un MPEC
$$
 \begin{equation}   
            \begin{array}{l}
                \underset{\substack{x, y, \lambda_j}}{\min} \quad F(x, y)\\
                s.a \left\{ 
                \begin{array}{l}
                    g_i(x, y) \leq 0, i=1\ldots q,\\
                    \nabla_{y} f(x, y) + \sum_{j=1}^{s} \nabla_{y} v_j(x, y) \lambda_j = 0, \\
                    v_j(x, y) \leq 0, j=1\ldots s,\\
                    v_j(x, y)\lambda_j = 0, j=1\ldots s, \\
                    \lambda_j \geq 0, j=1\ldots s.\\
                \end{array}\right.
            \end{array}
            \label{eq:KKT_Optimista}
        \end{equation}
     
$$
---


**Tipos de puntos estacionarios**:  
- Para:
$$

\alpha=0  \quad \text{ó} \quad \alpha \neq 0
$$
- Fuertemente estacionario, M-estacionario, C-estacionario.

---

## Contribución Principal

- **Generador de problemas**:  
  - Permite crear problemas binivel con puntos estacionarios específicos (controlados).  
  - Facilita la evaluación del rendimiento de algoritmos en problemas con características conocidas.  

**Ventajas**:  
- Control sobre el tipo de punto estacionario 

- Flexibilidad para generar problemas lineales, cuadráticos y no convexos.  

---

## Metodología

**Pasos del generador**:  
1. Entrada: Punto inicial y tipo de estacionariedad deseada.  
2. Modificación del problema original para cumplir con las condiciones requeridas.  
3. Validación de factibilidad y estacionariedad.  

**Herramientas utilizadas**:  
- Lenguaje de programación Julia.  
- Bibliotecas: JuMP, BilevelJuMP, Symbolics, LinearAlgebra.  

---

## Experimentación

- **Problemas seleccionados**:  
  - Lineales, cuadráticos y no convexos.  
  - Ejemplos extraídos de la literatura especializada.  

- **Métodos evaluados**:  
  - Big-M, SOS1, ProductMode.  

- **Resultados clave**:  
  - Mejora en algunos casos respecto al punto inicial.  
  - Dificultades en problemas no convexos.  
  - Tendencia a encontrar óptimos locales cercanos al punto estacionario inicial.  

---

## Conclusiones

- **Logros alcanzados**:  
  - Desarrollo de un algoritmo eficiente para generar problemas binivel con puntos estacionarios controlados.  
  - Evaluación del desempeño de algoritmos en problemas específicos.  

- **Contribución práctica**:  
  - Herramienta útil para investigadores en optimización binivel. 

---

- ## Trabajo futuro 
  - Ampliar la experimentación a más problemas.  
  - Desarrollar interfaces gráficas para facilitar el uso del generador.  

---

## ¿Preguntas?