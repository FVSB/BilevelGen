---
title: "Un Generador de Problemas Prueba para Optimización Binivel"
author: "Francisco Vicente Suárez Bellón"
format: 
  revealjs:
    theme: simple
    transition: slide
    incremental: true
    preview-links: auto
execute:
  echo: false
  warning: false
---

## Introducción

> _"En matemáticas no entiendes las cosas. Solo te acostumbras a ellas."_ — John von Neumann

La optimización binivel es un área fundamental en investigación operativa y teoría de juegos. Este trabajo propone un generador de problemas binivel cuyos puntos estacionarios tienen propiedades específicas.

---

## Objetivos

### General
Desarrollar un generador de problemas binivel para evaluar algoritmos MPEC.

### Específicos
1. Garantizar factibilidad y estacionariedad en puntos dados.
2. Evaluar el desempeño de algoritmos en problemas modificados.
3. Analizar resultados experimentales en problemas lineales, cuadráticos y no convexos.

---

## Marco Teórico

### Problema de Optimización Binivel

El problema general se define como:

$$
\begin{aligned}
\min_{x} & \quad F(x, y) \\
\text{s.a.} & \quad x \in T, \\
& \quad y \in S(x) = \arg\min_y \{f(x, y) \mid (x, y) \in M_0, y \in H(x)\}.
\end{aligned}
$$

---

### Transformación KKT

Reemplazando el problema del nivel inferior por sus condiciones KKT:

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

- **Débilmente Estacionario**:
  $$
  \nabla f(z^*) + \sum \mu_i \nabla g_i(z^*) - \sum [\beta_j \nabla G_j(z^*) + \gamma_j \nabla H_j(z^*)] = 0.
  $$

- **C-Estacionario**:
  $$
  \beta_j \gamma_j \geq 0, \quad \forall j \in J_{GH}.
  $$

- **M-Estacionario**:
  $$
  \beta_j > 0, \gamma_j > 0 \quad \text{o} \quad \beta_j \gamma_j = 0, \quad \forall j \in J_{GH}.
  $$

- **Fuertemente Estacionario**:
  $$
  \beta_j \geq 0, \gamma_j \geq 0, \quad \forall j \in J_{GH}.
  $$

---

## Metodología

### Fases del Proceso

1. Obtención de puntos mínimos iniciales.
2. Modificación de problemas originales para garantizar estacionariedad.
3. Evaluación de algoritmos en problemas modificados.

### Métodos de Reformulación

- **Big-M**:
  $$
  v_j(x, y) \geq -M_p(1 - \delta_j), \quad \lambda_j \leq M_d \delta_j, \quad \delta_j \in \{0, 1\}.
  $$

- **SOS1**:
  $$
  [s_j; \lambda_j] \in \text{SOS1}, \quad \text{donde } SOS1 = \{(a, b) \in \mathbb{R} : a, b \geq 0, ab = 0\}.
  $$

- **ProductMode**:
  $$
  v_j(x, y) \cdot \lambda_j \leq t, \quad t > 0.
  $$

---

## Implementación

### Estructura del Código

- Uso de macros para definir variables y funciones objetivo.
- Generación automática de restricciones y multiplicadores.
- API e interfaz gráfica desarrollada en Julia y Python.

### Exportación de Resultados

- Archivos `.xlsx` con detalles completos de cada problema generado.

---

## Resultados Experimentales

### Problemas Lineales

- Mejora en algunos casos con Big-M.
- ProductMode tiende a encontrar óptimos locales.

### Problemas Cuadráticos

- Comportamiento similar entre métodos.
- Mayor robustez en puntos fuertemente estacionarios.

### Problemas No Convexos

- Dificultades en hallar mejoras significativas.
- Coincidencia de variables del nivel superior en puntos óptimos.

---

## Conclusiones y Trabajo Futuro

### Conclusiones

- El generador permite evaluar el desempeño de algoritmos en problemas específicos.
- Los problemas no convexos presentan mayores desafíos estructurales.

### Trabajo Futuro

1. Ampliar la experimentación a más categorías de problemas.
2. Investigar criterios de parada basados en puntos estacionarios.
3. Desarrollar una interfaz gráfica más intuitiva.

---

## ¡Gracias por su atención!

- **Contacto**:
  - GitHub: [github.com/FVSB/Tesis](https://github.com/FVSB/Tesis)
  - Email: [tu_correo@uh.cu](mailto:tu_correo@uh.cu)
