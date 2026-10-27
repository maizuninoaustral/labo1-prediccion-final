# Informe: predicción final (Labo 1 BA 2026, Analista Sr)

## 1. Objetivo y criterio de decisión
El objetivo es maximizar la ganancia económica en Kaggle. Como el leaderboard público usa ~30% de los clientes y el puntaje final se calcula sobre el otro 70%, un puntaje público alto puede deberse al azar. Por eso no elegí el archivo con el puntaje más alto: elegí la opción que rinde mejor **de forma sistemática**, midiendo con varias semillas y comparando con Wilcoxon pareado (α = 0,05).

## 2. Punto de partida y cambios
Partí del workflow de predicción final (`z739_final_senior.ipynb`) y le apliqué las recomendaciones del grupo:
1. Ponderación temporal: peso de observación de 0,2 (mes más viejo) a 1 (más reciente), lineal en el mes. No se usa como variable.
2. Hiperparámetros fijos tomados de la mejor búsqueda bayesiana previa (experimento 9504), sin repetir la búsqueda.
3. Semillerío de 16 semillas, promediando las probabilidades.
4. Cortes de envío de 9000 a 12500; sin envío automático a Kaggle.
El resto del pipeline quedó idéntico al original.

## 3. Hipótesis y resultados
**H1. La receta modificada (9900) supera al workflow original (9800).**
Mismas semillas, corte 10500, Wilcoxon pareado de una cola: 7 de 8 semillas a favor, +16,5 M de media, p = 0,0078. Con 8 semillas nuevas (9 a 16) la ventaja es de +8,9 M (p = 0,052, borde de significancia, con poca potencia). Las 16 semillas contra el original: p = 0,0066. Conclusión: la receta mejora al original; el efecto realista ronda +9 a +13 M por semilla.

**H2. Ensamblar semillas reduce el ruido.**
Una semilla suelta rinde en promedio 449,9 M (rango 432 a 461). El ensamble de 16 semillas rinde 458,7 M. Una réplica independiente (9901, otra semilla primigenia, 12 modelos) da 459,1 M, y el blend de los 28 modelos, 462,4 M.

**H3. El corte óptimo es ~10500 clientes.**
Con las mismas 8 semillas: 10500 rinde 453,7 M de media, contra 448,8 M para 10000 y 449,5 M para 11000. 10500 gana a 10000 en 7 de 8 semillas (p = 0,020) y a 11000 en 6 de 8 (p = 0,020). Entre 10000 y 11000 no hay diferencia (p = 0,73).

**Ideas probadas y descartadas.**
Variables históricas (ventana 9): ensamble de 436,3 M. Variables de conteo: 442,6 M. Ambas quedan ~16 a 22 M por debajo de la receta final, por lo que no se incorporaron. El experimento con peso mínimo 0,05 (9920) no se completó por falta de tiempo de cómputo, y su hipótesis queda sin probar.

## 4. Entrega final
`KA9900_9901_blend28_10500.csv`: promedio de las probabilidades de 28 modelos (16 de 9900 y 12 de 9901), con los 10500 clientes de mayor probabilidad. Puntaje público: 462,414 M. Se eligió por consistencia entre semillas y cortes, no por ser el puntaje público más alto.

## 5. Limitaciones
- Todo se midió sobre el leaderboard público (30%); el resultado privado puede diferir y reordenar posiciones cercanas.
- El 462,4 es el mejor de su serie de cortes, por lo que está algo inflado; espero un valor menor en el privado.
- El corte se evaluó con 8 semillas.
- Las semillas 4 a 8 del 9900 en 10500 se tomaron del experimento 9805 (misma receta); verifiqué que las semillas 1, 2 y 3 reproducen exactamente los mismos puntajes.
- Tuve acceso a muchos envíos (>170), por lo que un puntaje alto aislado tiene más chances de ser azar. Por eso la decisión se apoya en promedios y tests y no en el máximo.

## 6. Reproducibilidad
Notebook, scripts (`analisis/seeds9900.R`, `analisis/blend.R`, `analisis/wilcoxon_final.R`), réplica y experimentos descartados están en este repositorio. Detalle numérico en `RESULTADOS.md`.
