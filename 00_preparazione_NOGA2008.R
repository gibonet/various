library(XLConnect)
library(dplyr)

# download della lista completa dei codici NOGA 2008
url_noga <- "https://www.bfs.admin.ch/bfsstatic/dam/assets/262597/master"
# nome_noga <- basename(url_noga)
nome_noga <- "do-i-00.04-noga-03.xls"

download.file(url_noga, destfile = nome_noga, mode = "wb")
# Da quando l'Ust ha pubblicato il nuovo portale, non si può più scaricare
# il file 'in automatico', ma bisogna farlo manualmente. Lo si può fare
# copiando l'url qui sopra e incollandolo in un browser.


# Importazione dei titoli dal file excel
wb <- loadWorkbook("do-i-00.04-noga-03.xls")

noga08 <- readWorksheet(wb, sheet = "Titoli corti 2008", endRow = 1791)
str(noga08)

colnames(noga08) <- c("sezioni", "codici", "titoli_corti")
str(noga08)


# Ed estraggo la lista di interesse in base alla lunghezza della colonna 'codici'
noga08 <- noga08 %>% mutate(l = nchar(codici))
noga08 <- as_data_frame(noga08)

# Esporto in csv e in rda (la lista completa della nomenclatura NOGA 2008)
gibr::export(noga08, name = "data/noga08.csv")
save(noga08, file = "data/noga08.rda")
# load("data/noga08.rda")

table(noga08$l)

# Codici a 1 digit (sezioni)
# In questo caso il codice univoco è nella colonna 'sezioni' (e non 'codici')
noga08_sezioni <- noga08 %>% filter(l == 1)
nrow(noga08_sezioni) == length(unique(noga08_sezioni$sezioni))  # deve dare TRUE

# E li esporto in csv e in rda
gibr::export(noga08_sezioni, name = "data/noga08_sezioni.csv")
save(noga08_sezioni, file = "data/noga08_sezioni.rda")



# Codici a 2 digit
noga082 <- noga08 %>% filter(l == 2)
nrow(noga082) == length(unique(noga082$codici))  # deve dare TRUE

# E li esporto in csv e in rda
gibr::export(noga082, name = "data/noga082.csv")
save(noga082, file = "data/noga082.rda")



# Codici a 3 digit
noga083 <- noga08 %>% filter(l == 3)
nrow(noga083) == length(unique(noga083$codici))  # deve dare TRUE

# E li esporto in csv e in rda
gibr::export(noga083, name = "data/noga083.csv")
save(noga083, file = "data/noga083.rda")



# Codici a 4 digit
noga084 <- noga08 %>% filter(l == 4)
nrow(noga084) == length(unique(noga084$codici))  # deve dare TRUE

# E li esporto in csv e in rda
gibr::export(noga084, name = "data/noga084.csv")
save(noga084, file = "data/noga084.rda")



# Codici a 6 digit
noga086 <- noga08 %>% filter(l == 6)
nrow(noga086) == length(unique(noga086$codici))  # deve dare TRUE

# E li esporto in csv e in rda
gibr::export(noga086, name = "data/noga086.csv")
save(noga086, file = "data/noga086.rda")
