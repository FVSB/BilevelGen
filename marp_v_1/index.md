---
marp: true
theme: default
author: Francisco Vicente Suárez Bellón
transition: drop
paginate: true
lang: es
header: "Universidad de La Habana - Facultad de Matemática y Computación"
footer: "Francisco Vicente Suárez Bellón | Tesis de Licenciatura en Ciencia de la Computación"
backgroundImage: url('https://marp.app/assets/hero-background.jpg')
---

# Un generador de problemas prueba para evaluar la calidad de la solución de los algoritmos de problemas de optimización de dos niveles

---

## Índice

1. Introducción
2. Objetivos
3. Marco Teórico
5. Resultados
6. Conclusiones y Trabajo Futuro

---

# 1. Introducción

- **Contexto**: Optimización binivel como herramienta clave en investigación operativa y teoría de juegos.
- **Problema**: Dificultad inherente en resolver problemas binivel debido a su naturaleza jerárquica y no convexa.
- **Contribución**: Generador de problemas con puntos estacionarios específicos para evaluar algoritmos MPEC.

---
## Principales usos de los problemas binivel en la literatura:
- Mercado Eléctrico (Aussel 2018)
- Ecoparques industriales (Ramos 2016)
- Ajuste de hiperparámetros en entrenamiento de redes neuronales (Dempe 2020)

---
## Los problemas binivel  son complejos computacionalmente:

-  *NP-Hard* (Dempe 2020)
- *ΣP2-hard* (Cerulli 2016)

---

# 2. Objetivos
---
- **Objetivo General**:
  - Desarrollar un generador de problemas binivel que permita estudiar el comportamiento de algoritmos conocidos.
- **Objetivos Específicos**:
  - Garantizar la factibilidad y estacionariedad en puntos dados.
  - Evaluar el desempeño de algoritmos en problemas modificados.
  - Analizar resultados experimentales en problemas lineales, cuadráticos y no convexos.

---

# 3. Marco Teórico
---
### Problema de Optimización Binivel

El problema general de optimización binivel se define como:

$$
\begin{aligned}
\min_{x} & \quad F(x, y) \\
\text{s.a.} & \quad x \in T, \\
& \quad y \in S(x) = \arg\min_y \{f(x, y) \mid (x, y) \in M_0, y \in H(x)\}.
\end{aligned}
$$
--- 
### Transformación KKT

Reemplazando el problema del nivel inferior por sus condiciones KKT, obtenemos:

$$
\begin{aligned}
\min_{x, y, \lambda_j} & \quad F(x, y) \\
\text{s.a.} & \quad g_i(x, y) \leq 0, \quad i = 1, \dots, q, \\
& \quad \nabla_y f(x, y) + \sum_{j=1}^s \nabla_y v_j(x, y) \lambda_j = 0, \\
& \quad v_j(x, y) \leq 0, \quad j = 1, \dots, s, \\
& \quad \lambda_j \geq 0, \quad j = 1, \dots, s, \\
& \quad v_j(x, y) \lambda_j = 0, \quad j = 1, \dots, s.
\end{aligned}
$$
---
### Tipos de Puntos Estacionarios


- **C-Estacionario**:

- **M-Estacionario**:


- **Fuertemente Estacionario**:

### Valores del Multiplicador   alpha
- $$\alpha=0  $$
- $$\alpha \neq 0$$
  
 

---

# 4. Metodología
---
### Fases del Proceso

1. Seleccionar del ambiente computacional
2. Crear un generador de problemas pruebas
3. Experimentar con problemas prueba
4. Analizar los resultados
---

## Seleccionar un ambiente computacional

- Lenguaje de programación:
  1. Rápido y eficiente computacionalmente.
  2. Fácil de utilizar en ambientes matemáticos.
  3. Bibliotecas para optimización no lineal y binivel.

--- 
## Generador del problema

- Entrada:
  1. Un problema de optimización binivel
  2. Un punto, el cual se desea que dicho problema sea estacionario
  3. Elección del tipo de la clase de estacionariedad seleccionada.

- Salida: 
  1. Problema perturbado donde el punto seleccionado es estacionario de la clase seleccionada

---
## Experimentar con problemas prueba

- Selección de problemas con estructura variada 
 1. Lineales
 2. Cuadráticos
 3. No Convexos

- Generación de problemas perturbados en cada clase de estacionariedad 

- Analizar los puntos óptimos que el ambiente computacional halla de cada problema perturbado.





---
# 5. Resultados

--- 
### Ambiente Computacional:
- Lenguaje de programación: 
  1. **Julia**
- Bibliotecas:
  1. Symbolics 
  2. LinearAlgebra

- Bibliotecas para hallar óptimos:
  1. BilevelJuMP
  2. JuMP

---
### Generador de problemas Binivel 
**Dado**:
- Problema de optimización binivel
  1. Conjunto de índices activos.
- Punto a requerir a ser estacionario.
  1. Conocer el tipo de estacionariedad requerida.


--- 
#### Pasos para la generación
1. Transformaciones:
  - Restricciones activas del nivel inferior y hacer factibles.
  - Hallar el kkt del nivel inferior y modificar la función objetivo del nivel inferior.
  - Garantizar la factibilidad del punto.
  - Realizar el KKT del MPEC y posteriormente modificar la función objetivo del Líder.

---

### Transformaciones en el nivel inferior:
- Las restricciones activas : 
$$\hat{v_j}=v_{j}(z_{est})+ ({\vec{b_j}}^T)\cdot (y_1,y_2,\dots,y_m).$$

- Garantizar que en el punto en  $\hat{v_j}$ es factible.
  $$v_{j}^{\star}(x,y)=v_{j}(x,y)+ ({\vec{b_j}}^T)\cdot (y_1,y_2,\dots,y_m)+c_j^v
  $$

- Modificar la función objetivo: 
$$f^{\star}(x,y)=f(x,y)+\vec{bf}y$$

--- 


### Transformaciones en el nivel superior.
- Garantizar que el punto es factible en $g_{i}$:
 $$g_{i}^{\star}(x,y)=g_{i}(x,y)+c_i^g,$$

- Modificar la función objetivo:
 $$F^{\star}(x,y)=F(x,y)+\vec{BF}(x,y)^T.$$

---

#### Salida del generador:
La salida del generador son las funciones:
- $F^{\star}(x,y)$
- $f^{\star}(x,y)$
- $g_1^{\star}(x,y),\ldots,g_q^{\star}(x,y)$
- $v_1^{\star}(x,y),\ldots,v_s^{\star}(x,y)$


--- 

### Experimentar con problemas prueba

1. Seleccionar 5 problemas de cada tipo:
    - Lineales
    - Cuadráticos
    - No Convexos

2. Cada problema crear 4 problemas perturbados del tipo:
  - C-Estacionario.
  - M-Estacionario.
  - Fuertemente-Estacionario.
  - $\alpha=0$
---
3. Computar con los algoritmos de Julia los mínimos por cada problemas perturbado:
  - Lineales y Cuadráticos:
    Se uso BilevelJuMP:
    - Big-M (100,100)  (HiGHS)
    - ProductMode (Ipopt)
    - SOS1 (SCIP)
  - No Convexos:
    - Reformulación KKT en JuMP (Ipopt)
  
---
4. Comparar los resultados obtenidos:
- Valor de la función objetivo evaluada en el punto estacionario inicial vs el punto óptimo computado por los métodos anteriores.
- Velocidad del método