
# Controlla che i pacchetti necessari siano installati
if(!require(comuniTI) || !require(tidy2spatial) || !require(ggswissmaps)){
  if(!require(devtools)) install.packages("devtools")
}

if(!require(comuniTI)) devtools::install_github("gibonet/comuniTI")
if(!require(tidy2spatial)) devtools::install_github("gibonet/tidy2spatial")
if(!require(ggswissmaps)) install.packages("ggswissmaps")

library(comuniTI)
library(tidy2spatial)
library(ggswissmaps)

# Carico la lista storicizzata dei comuni ticinesi
data("comuniTI")

str(comuniTI)
comuniTI$municipalityLongName

# Estraggo la lista dei comuni all'1.1.2015
c15 <- comuni_stato(comuniTI, data.rif = "2015-01-01")
dim(c15)

# Tengo solo le colonne con il codice e il nome del comune e il codice del 
# distretto (storicizzato)
c15 <- c15[ , c("municipalityId", "municipalityLongName", "districtHistId")]
head(c15)

# Ordino i dati secondo il codice del comune
c15 <- c15[order(c15$municipalityId), ]

# Carico la lista storicizzata dei distretti
data("distrettiTI")
str(distrettiTI)

# E aggiungo i dati dei distretti ai comuni
c15 <- merge(c15, distrettiTI, by = "districtHistId", sort = FALSE)
str(c15)

# Esporto c15 (con comuni e distretti) in un file csv
write.table(c15, file = "data/c15.csv", sep = ";", na = "", row.names = FALSE)

# Da continuare:
# - comuni al 10.04.2016
# - armonizzare comuni 2015-2016 (da 135 a 130)
# - mappa confini comuni 2015
# - creare i confini 2016? Ev. provare con solo una fusione.
