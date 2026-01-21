library(tidyr)

ubi <- function(caracter, cadena){ # Función para obtener la ubicación de un caracter en específico
  which(strsplit(cadena, "")[[1]] == caracter)
}

f_NA <- function(framedata, cambio){ # Con esta función se reemplazan los NA de un dataframe
  for (j in 1:ncol(framedata)) {
    for (i in 1:nrow(framedata)) {
      if (is.na(framedata[i,j])) { framedata[i,j] <- cambio }
    }
  }
  return(framedata)
}

f_confronta <- function(recortados, cuadros){
  a_recor <- list.files(path = recortados)
  a_cuadr <- list.files(path = cuadros)
  resultado <- NULL; confronta <- NULL
  for (i in 1:length(a_recor)) {
    recortado <- readxl::read_excel(paste(recortados, a_recor[i], sep = "/"), sheet = "CUADRO", skip = 8,
                                    col_names = c("A","B","C","D","E","F","G","H","I","J","K")) %>% as.data.frame()
    recortado <- recortado[!is.na(recortado$C),]
    
    cuadro <- readxl::read_excel(paste(cuadros, a_cuadr[i], sep = "/"), sheet = "CUADRO", skip = 8,
                                 col_names = c("A","B","C","D","E","F","x1","x2","x3","x4","x5","G","H","I","x6",
                                               "x7","J","K","x8","x9","x10","x11","x12","x13","x14","x15"))
    cuadro <- cuadro[,c(1:6,12:14,17,18)] %>% as.data.frame()
    if (is.na(cuadro$E[1])) { cuadro$E <- cuadro$C; cuadro$`F` <- cuadro$D }
    cuadro <- cuadro[!is.na(cuadro$C),]
    
    dif <- f_NA(recortado, 0) == f_NA(cuadro, 0)
    aux2 <- ifelse((nrow(dif) * ncol(dif)) == sum(dif), 0, i)
    
    for (j in 1:ncol(dif)) {
      for (k in 1:nrow(dif)) {
        if (dif[k,j] == "TRUE") { dif[k,j] <- "." }
      }
    }
    aux1 <- list(cbind(recortado, dif, cuadro)); names(aux1) <- substring(a_recor[i], 1, ubi("-", a_recor[i]) - 1)
    
    resultado <- c(resultado, aux2)
    confronta <- c(confronta, aux1)
  }
  
  if (sum(resultado) == 0) {
    veredicto <- "La información de los archivos recortados es CORRECTA."
  } else {
    veredicto <- paste("Los siguientes indicadores presentan diferencias:", 
                       paste(a_recor[resultado != 0], collapse = " ~ "), sep = " ~ ")
  }
  return(list(I = veredicto, II = confronta))
}


