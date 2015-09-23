
#https://www.kolada.se/?_p=index/API
# http://www.scb.se/sv_/Hitta-statistik/Regional-statistik-och-kartor/Regionala-indelningar/Lan-och-kommuner/Lan-och-kommuner-i-kodnummerordning/



# response <- GET("http://api.kolada.se/v2/ou?title=skola&municipality=0580")



#N00041 skattesats
#N00090 sjukfrv
#N00105  standardkostn kollekt.trf



# a <- GET("http://api.kolada.se/v2/data/kpi/Ns00090/municipality/0580/year/2")
# status_code(a)
# content(a)



GetKolada <- function(kpi_type, municipalities, year=""){
  
  #   browser()
  stopifnot(is.character(kpi_type), is.character(municipalities))
  stopifnot(sum(sapply(municipalities, FUN = function(x) !x %in% munic_code[,1]))==0)    
  
  munic2 <- paste(municipalities, collapse=",")  
  kpi_t2 <- paste(kpi_type, collapse=",")
  
  if(identical(year, "")) year2 <- "" else {
    stopifnot(sum(is.na(as.numeric(year))) == 0)
    year2 <- paste("/year/", paste(year, collapse=","), sep="")
  }  
  
  url <- paste("http://api.kolada.se/v2/data/kpi/", kpi_t2, "/municipality/", munic2, year2, sep="")
  response <- GET(url)
  
  stopifnot(status_code(response)>=200 & status_code(response)<300)
  stopifnot(content(response)$count>0)
  
  Kolada_list <- content(response)$values
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
  
  Kolada_df <- data.frame(kpi, municipality=munip, year, female_value, male_value, tot_value)
  
  return(Kolada_df)
  
}



a <- GetKolada("N00090", "0580")
a <- GetKolada("N00090", c("0580", "0180"))
a <- GetKolada("N00041", "0580")
a <- GetKolada(c("N00090", "N00041"), c("0580", "0180"))
a <- GetKolada("N00090", "0580", 2013)
a <- GetKolada("N00090", "0580", 2010:2014)
a <- GetKolada(c("N00090", "N00041"), c("0580", "0180"), "2013")
a <- GetKolada("N00105", "0580")



