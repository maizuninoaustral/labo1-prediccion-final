# Prediccion final - Labo 1 BA 2026 (Analista Sr)

Competencia: `labo-1-ba-2026-analista-sr`. Modelo: LightGBM en R. Base: `PredFinal/z739_final_senior.ipynb`.

## Que cambia respecto del z739 original
1. **Ponderacion temporal**: peso de observacion de LightGBM de 0,2 (mes mas viejo) a 1 (mas reciente), lineal en el mes. No se usa como variable.
2. **Hiperparametros fijos** tomados de la mejor Bayesian Optimization previa (experimento 9504); la BO se apaga (`correr_BO <- FALSE`).
3. **Semillerio de 16 semillas** (`PARAM$FT$semillerio`), promedio de las probabilidades.
4. Cortes de envio de 9000 a 12500 de a 500; se quita el envio automatico a Kaggle.
5. Correccion de nombres de columnas de deriva del dolar, y `mes_indice`/pesos excluidos de las variables.

## Contenido
- `z739_final_senior.ipynb`: experimento 9900 (semilla primigenia 137531, 16 semillas).
- `replica_9901/`: misma receta con otra semilla primigenia (314159) y 12 semillas.
- `descartados/`: variables historicas (9910) y de conteo (9912), probadas y descartadas.
- `analisis/seeds9900.R`: genera un CSV de Kaggle por semilla (top-k por `prob_i`). Corte 10500; los CSV de 10000 y 11000 se generaron cambiando `k` en este mismo script.
- `analisis/blend.R`: promedia las probabilidades de los 28 modelos (16 de 9900 + 12 de 9901) y genera los CSV del blend en cortes de 9500 a 11500.
- `analisis/wilcoxon_final.R`: tests de Wilcoxon sobre los puntajes publicos de Kaggle.
- `RESULTADOS.md`: tablas y conclusiones.

## Como se eligio el envio
Cada semilla se sube sola a Kaggle y se comparan las distribuciones con Wilcoxon pareado
(`wilcox.test(nuevo, base, paired = TRUE, alternative = "greater")`). El envio final es el
**promedio de 28 modelos (9900 + 9901) con corte en 10500**, elegido por consistencia entre semillas
y no por el puntaje publico mas alto. Detalles en `RESULTADOS.md`.

## Como reproducir
1. Ejecutar el notebook (o el script equivalente) con los parametros indicados; deja una carpeta por experimento con `prediccion.txt`
   (`numero_de_cliente`, `prob` y `prob_1..prob_k`) y los CSV de `kaggle/`.
2. Por semilla: `analisis/seeds9900.R`. Para el blend: `analisis/blend.R` (promedia las columnas `prob_i` de 9900 y 9901 y toma los clientes con mayor promedio como `Predicted = 1`; el envio final es el corte 10500).
3. Los scripts de `analisis/` tienen rutas de nuestra VM (`/home/ds/buckets/b1/exp/...`); ajustar `base`/`b` al reproducir. Las rutas del notebook usan `/content/buckets/...`; en nuestra VM se ejecuto con `/home/ds/buckets/...`.
