% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/documentation.R
\name{GetKolada}
\alias{GetKolada}
\title{Kolada data}
\usage{
GetKolada(kpi_id, municipalities, years = "")
}
\arguments{
\item{kpi_id}{Key indicator, must start witn "N" and be following by 5 digits}

\item{municipalities}{must be string and correspond to a real municipalities code in Sweden.}

\item{years}{if year is unsued in the function all yeas values are returned  otherwise extracting specific years can be done.}
}
\value{
A data frame with 6 columns.
}
\description{
Thsis is a function that extract data from Kolada API and return the data in a data frame
}
\examples{
GetKolada(kpi_id = "N00090", municipalities = "0580")
GetKolada(kpi_id = "N00090", municipalities = "0580", years = "2013")
GetKolada(kpi_id = c("N00090", "N00041"), municipalities = c("0580", "0180"), years = 2010:2014)
}

