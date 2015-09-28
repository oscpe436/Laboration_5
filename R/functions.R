
#https://www.kolada.se/?_p=index/API
# http://www.scb.se/sv_/Hitta-statistik/Regional-statistik-och-kartor/Regionala-indelningar/Lan-och-kommuner/Lan-och-kommuner-i-kodnummerordning/



# response <- GET("http://api.kolada.se/v2/ou?title=skola&municipality=0580")
# a <- GET("http://api.kolada.se/v2/data/kpi/Ns00090/municipality/0580/year/2")


GetKolada <- function(kpi_id, municipalities, years=""){

  #   browser()
  stopifnot(is.character(kpi_id), is.character(municipalities))
  #   stopifnot(sum(sapply(municipalities, FUN = function(x) !x %in% munic_code[,1]))==0)

  munic2 <- paste(municipalities, collapse=",")
  kpi_t2 <- paste(kpi_id, collapse=",")

  if(identical(years, "")) year2 <- "" else {
    stopifnot(sum(is.na(as.numeric(years))) == 0)
    year2 <- paste("/year/", paste(years, collapse=","), sep="")
  }

  url <- paste("http://api.kolada.se/v2/data/kpi/", kpi_t2, "/municipality/", munic2, year2, sep="")
  response <- httr::GET(url)


  stopifnot(httr::status_code(response)>=200 & httr::status_code(response)<300)
  stopifnot(httr::content(response)$count>0)

  Kolada_list <- httr::content(response)$values
  n <- length(Kolada_list)

  kpi <- character(n)
  munip <- character(n)
  year <- numeric(n)
  female_value <- numeric(n)
  male_value <- numeric(n)
  tot_value <- numeric(n)

  for(i in 1:n){
    list_obj <- Kolada_list[[i]]
    kpi[i] <- list_obj$kpi
    munip[i] <- list_obj$municipality
    year[i] <- list_obj$period

    if(length(list_obj$values)==3){
      female_value[i] <- ifelse(is.null(list_obj$values[[1]]$value), NA, list_obj$values[[1]]$value)
      male_value[i] <- ifelse(is.null(list_obj$values[[2]]$value), NA, list_obj$values[[2]]$value)
      tot_value[i] <- ifelse(is.null(list_obj$values[[3]]$value), NA, list_obj$values[[3]]$value)
    }else{
      female_value[i] <- NA
      male_value[i] <- NA
      tot_value[i] <- ifelse(is.null(list_obj$values[[1]]$value), NA, list_obj$values[[1]]$value)
    }
    #     print(i)
  }

  Kolada_df <- data.frame(kpi, municipality=munip, year, female=female_value, male=male_value, total=tot_value)

  return(Kolada_df)

}

