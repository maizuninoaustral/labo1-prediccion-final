suppressMessages(library(data.table))
b <- "/home/ds/buckets/b1/exp"
a <- fread(file.path(b, "WF9900", "prediccion.txt"))
c <- fread(file.path(b, "WF9901", "prediccion.txt"))
setkey(a, numero_de_cliente); setkey(c, numero_de_cliente)
stopifnot(identical(a$numero_de_cliente, c$numero_de_cliente))
pa <- grep("^prob_[0-9]+$", names(a), value = TRUE)
pc <- grep("^prob_[0-9]+$", names(c), value = TRUE)
ma <- as.matrix(a[, ..pa]); mc <- as.matrix(c[, ..pc])
mezcla <- (rowSums(ma) + rowSums(mc)) / (ncol(ma) + ncol(mc))
dir.create(file.path(b, "BLEND"), showWarnings = FALSE)
guardar <- function(p, nombre, cortes) {
  o <- order(-p)
  for (k in cortes) {
    pred <- integer(length(p)); pred[o[1:k]] <- 1L
    fwrite(data.table(numero_de_cliente = a$numero_de_cliente, Predicted = pred),
           file.path(b, "BLEND", sprintf("%s_%d.csv", nombre, k)))
  }
}
guardar(mezcla, "KA9900_9901_blend28", seq(9500, 11500, by = 500))
guardar(rowMeans(mc), "KA9901_s12", c(10000, 10500, 11000))
cat("modelos 9900:", ncol(ma), " modelos 9901:", ncol(mc), " OK\n")
