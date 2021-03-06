% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TideTable.R
\name{TideTable}
\alias{TideTable}
\title{Computes a tide table}
\usage{
TideTable(
  dataInput,
  otz = 1,
  hwi = "99:99",
  sharp_hwi = TRUE,
  asdate,
  astime,
  aedate,
  aetime,
  ssdate,
  sstime,
  sedate,
  setime,
  stz = 1
)
}
\arguments{
\item{dataInput}{A data frame with the columns observation_date, observation_time, high_or_low_water and height. See attached data for correct formats.}

\item{otz}{The time zone of the observations}

\item{hwi}{The average of all intervals between the Moon's transit (upper or lower) over the Greenwich meridian and the following high or low waters for all phases of the Moon is known as mean high water lunitidal interval and is abbreviated to high              water interval (hwi). Please only supply a value, when you are sure. Otherwise leave the default value "99:99" untouched.            hwi is then computed for you.}

\item{sharp_hwi}{Default is TRUE, which results in a sharp hwi computation. Set on FALSE if you analyze shorter time intervals and EstimateTmhwi function returns NA.}

\item{asdate}{A string indication the date you want the analysis to start with. Format: "yyyy/mm/dd".}

\item{astime}{A string indicating the time you want the analysis to start with. Format: "hh:mm:ss"}

\item{aedate}{A string indication the date you want the analysis to end with. Format: "yyyy/mm/dd".}

\item{aetime}{A string indicating the time you want the analysis to end with. Format: "hh:mm:ss"}

\item{ssdate}{Synthesis start date. This indicates the date you want your tide table to start with. Format: See above}

\item{sstime}{Synthesis start time. The starting time for your tide table. Format: See above}

\item{sedate}{Synthesis end date. Format: See above}

\item{setime}{Synthesis end time. Format: See above}

\item{stz}{Dummy for later extension to modify target time zone.}
}
\value{
Returns a list with elements of the analysis, fitting and the tide table for given data 
\item{c.table}{The complete synthesis data as a data.table object}
\item{tide.table}{The tide table as a data.table object}
\item{lm.coeff}{Coefficients for the eight fitted linear models used in the synthesis}
\item{diff.analyse}{Time in days spanning the analysis}
\item{i.analyse}{How many different cases where used in the analysis}
}
\description{
Takes a data frame as input with date time, high water and height information and returns a tide table
}
\examples{
TideTable(dataInput = observation, asdate = "1991/01/01", 
astime = "12:00:00", 
aedate = "1992/01/01", aetime = "12:00:00", ssdate = "1991/01/01", 
sstime = "00:00:00", sedate = "1991/01/31", setime = "21:00:00")

}
\references{
Horn, W. (1960) Some Recent Approaches to Tidal Problems. Int. Hydrogr. Rev. 37(2), 65-84

Godin, Gabriel (1972) The Analysis of Tides. Toronto, 264pp

\url{https://www.bsh.de/DE/PUBLIKATIONEN/_Anlagen/Downloads/Meer_und_Umwelt/Berichte-des-BSH/Berichte-des-BSH_50_de.pdf?__blob=publicationFile&v=13/}

\url{https://doi.org/10.5194/os-15-1363-2019}
}
