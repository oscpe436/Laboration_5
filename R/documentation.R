
#' Kolada data
#' 
#' Thsis is a function that extract data from Kolada API and return the data in a data frame
#' @param kpi Key indicator, must start witn "N" and be following by 5 digits
#' @param municipalities must be string and correspond to a real municipalities code in Sweden.
#' @param years if year is unsued in the function all yeas values are returned  otherwise extracting specific years can be done.
#' @examples GetKolada(kpi_id = "N00090", municipalities = "0580")
#' GetKolada(kpi_id = "N00090", municipalities = "0580", year = "2013")
#' GetKolada(kpi_id = c("N00090", "N00041"), municipalities = c("0580", "0180"), year = 2010:2014)
#' @return A data frame with 6 columns.
"GetKolada"


#' KoladaR package
#' 
#' Contains the function GetKolada that extracts data using the Kolada API.
#' @examples GetKolada(kpi_id = "N00090", municipalities = "0580")
#' @name KoladaR
#' @docType package
#' @seealso The GetKolada function: \link{GetKolada}.
#' @references Home page of the Kolada (in swedish): \url{https://www.kolada.se/}.
#'
#' Documentation page for the Kolada API (in swedish): \url{http://www.kolada.se/appspecific/rka/download/api/Kolada-API-test.html}.
#' @source Kolada, see homepage.
"GetKolada"
