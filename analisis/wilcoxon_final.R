# Analisis estadistico de la prediccion final (Labo 1 - Analista Senior)
# Datos: puntaje PUBLICO de Kaggle (ganancia en millones), un envio por semilla.
# Las mismas semillas se usan en todas las comparaciones (misma semilla primigenia 137531).

# ---- Parte 1: receta final (9900) vs workflow original (9800), corte 10500 ----
base_9800_s1_8   <- c(427.164, 421.581, 434.164, 429.164, 437.414, 440.414, 460.081, 447.581)
nuevo_9900_s1_8  <- c(451.164, 459.164, 445.498, 461.164, 448.498, 449.998, 458.664, 455.414)
nuevo_9900_s9_16 <- c(448.581, 452.664, 434.914, 441.581, 455.581, 449.248, 454.331, 432.164)

cat("\n== Test 1: pareado por semilla, 9900 vs 9800 (semillas 1-8) ==\n")
print(wilcox.test(nuevo_9900_s1_8, base_9800_s1_8, paired = TRUE,
                  alternative = "greater", conf.level = 0.95))
cat("Diferencia media:", round(mean(nuevo_9900_s1_8 - base_9800_s1_8), 1),
    "M | semillas donde gana:", sum(nuevo_9900_s1_8 > base_9800_s1_8), "de 8\n")

cat("\n== Test 2: semillas nuevas 9-16 de 9900 vs 9800 (no pareado) ==\n")
print(wilcox.test(nuevo_9900_s9_16, base_9800_s1_8, paired = FALSE,
                  alternative = "greater", conf.level = 0.95))

cat("\n== Test 3: las 16 semillas de 9900 vs 9800 (no pareado) ==\n")
print(wilcox.test(c(nuevo_9900_s1_8, nuevo_9900_s9_16), base_9800_s1_8, paired = FALSE,
                  alternative = "greater", conf.level = 0.95))

# ---- Parte 2: eleccion del corte (9900, semillas 1-8, pareado) ----
corte_10000 <- c(448.498, 451.748, 440.331, 454.248, 447.914, 445.081, 444.248, 458.164)
corte_10500 <- nuevo_9900_s1_8
corte_11000 <- c(449.914, 455.581, 445.914, 451.248, 443.248, 450.748, 449.914, 449.081)

cat("\n== Corte: 10500 vs 10000 ==\n")
print(wilcox.test(corte_10500, corte_10000, paired = TRUE, alternative = "greater"))
cat("\n== Corte: 10500 vs 11000 ==\n")
print(wilcox.test(corte_10500, corte_11000, paired = TRUE, alternative = "greater"))
cat("\n== Corte: 10000 vs 11000 (control) ==\n")
print(wilcox.test(corte_10000, corte_11000, paired = TRUE, alternative = "two.sided"))
