% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BuildTT.R
\name{BuildTT}
\alias{BuildTT}
\title{Builds a TideTable model}
\usage{
BuildTT(
  dataInput,
  otz = 1,
  asdate,
  astime,
  aedate,
  aetime,
  hwi = "99:99",
  sharp_hwi = TRUE
)
}
\arguments{
\item{dataInput}{the data frame with observation date, observation time and height.}

\item{otz}{time zone of the observations. Default is 1 (UTC + 1)}

\item{asdate}{The start date.Format: "yyyy/mm/dd"}

\item{astime}{The start time. Format: "hh:mm:ss"}

\item{aedate}{The end date. Format: "yyyy/mm/dd"}

\item{aetime}{The end time. Format: "hh:mm:ss"}

\item{hwi}{The high water interval. Format: "hh::mm"}

\item{sharp_hwi}{should the hwi computation be sharp? Default is TRUE}
}
\value{
Returns a object of class "tidetable" which contains following elements:
\item{fitting.coeff}{Coefficients for the eight fitted linear models used in the synthesis}
\item{diff.analyse}{Time in days spanning the analysis}
\item{omega_t}{Return value of FindOmega()}
\item{tm24}{Internal constant}
\item{tplus}{Internal constant}
\item{tmhwi}{Mean high water interval}
}
\description{
Builds a TideTable model of class "tidetable".
}
\examples{
BuildTT(dataInput = observation, asdate = "1991/01/01", 
astime ="12:00:00", aedate = "1992/01/01", aetime = "12:00:00")
}
\references{
\url{https://www.bsh.de/DE/PUBLIKATIONEN/_Anlagen/Downloads/Meer_und_Umwelt/Berichte-des-BSH/Berichte-des-BSH_50_de.pdf?__blob=publicationFile&v=13/}

\url{https://doi.org/10.5194/os-15-1363-2019}
}
