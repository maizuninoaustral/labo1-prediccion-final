# Resultados (puntaje PUBLICO de Kaggle, millones)

El leaderboard publico usa ~30% de los clientes de test; el puntaje final se calcula sobre el otro 70%.
Por eso no elegimos el mejor puntaje publico, sino la opcion mas consistente entre semillas y cortes.

## 1. Receta final (9900) vs workflow original (9800), corte 10500
Misma semilla primigenia (137531); cambian solo la ponderacion temporal y los hiperparametros fijos.

| Comparacion | Diferencia | Semillas a favor | p (Wilcoxon, una cola) |
|---|---|---|---|
| Pareado, semillas 1-8 | +16,5 M | 7 de 8 | 0,0078 |
| Semillas nuevas 9-16 vs 9800 (no pareado) | +8,9 M | - | 0,052 |
| 16 semillas de 9900 vs 9800 (no pareado) | - | - | 0,0066 |

Lectura: la receta mejora al original. El efecto realista es de +9 a +13 M por semilla
(las primeras 8 semillas fueron algo favorables). Con 8 semillas el test tiene potencia limitada.

## 2. Ensamblar semillas
Promedio de una semilla suelta (16 semillas, corte 10500): 449,9 (rango 432-461).
Ensamble de 16 semillas: 458,7. Replica independiente 9901 (12 modelos, otra semilla primigenia): 459,1.
Blend de los 28 modelos (9900 + 9901): 462,4.

## 3. Corte (9900, semillas 1-8, pareado)
| Corte | Media de 8 semillas |
|---|---|
| 10000 | 448,8 |
| 10500 | 453,7 |
| 11000 | 449,5 |

| Comparacion | Diferencia | Semillas a favor | p |
|---|---|---|---|
| 10500 vs 10000 | +4,9 M | 7 de 8 | 0,020 |
| 10500 vs 11000 | +4,2 M | 6 de 8 | 0,020 |
| 10000 vs 11000 | -0,7 M | 3 de 8 | 0,73 |

## 4. Ideas descartadas
| Experimento | Ensamble en 10500 | Decision |
|---|---|---|
| 9910 (variables historicas, ventana 9) | 436,3 | descartado (-22 M vs 9900) |
| 9912 (variables de conteo) | 442,6 | descartado (-16 M vs 9900) |
| 9920 (peso minimo 0,05) | - | no se completo (limite de computo); hipotesis sin probar |

## 5. Entrega final
`KA9900_9901_blend28_10500.csv`: promedio de las probabilidades de 28 modelos (16 de 9900 + 12 de 9901), top 10500 clientes. Puntaje publico 462,414.

## Limitaciones
- Todo se mide sobre el leaderboard publico (30%); el privado puede diferir.
- El puntaje 462,4 es el mejor de su serie de cortes, asi que esta algo inflado.
- Las semillas 4-8 de 9900 en el corte 10500 se tomaron de 9805 (misma receta); se verifico que las semillas 1, 2 y 3 dan exactamente el mismo puntaje.
- El corte se evaluo solo con 8 semillas.
