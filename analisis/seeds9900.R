suppressMessages(library(data.table))
base <- "/home/ds/buckets/b1/exp/WF9900"
d <- fread(file.path(base, "prediccion.txt"))
dir.create(file.path(base, "seeds"), showWarnings = FALSE)
ps <- grep("^prob_[0-9]+$", names(d), value = TRUE)
for (p in ps) {
  i <- sub("prob_", "", p)
  o <- order(-d[[p]])
  for (k in c(10500)) {
    pred <- integer(nrow(d)); pred[o[1:k]] <- 1L
    fwrite(data.table(numero_de_cliente = d$numero_de_cliente, Predicted = pred),
           file.path(base, "seeds", sprintf("KA9900seed_s%s_%d.csv", i, k)))
  }
}
cat(length(ps), "semillas OK\n")
