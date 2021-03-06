#' Synthesizes a tide table
#' @description Synthesizes a tide table, built with BuildTT().
#' @references \url{https://www.bsh.de/DE/PUBLIKATIONEN/_Anlagen/Downloads/Meer_und_Umwelt/Berichte-des-BSH/Berichte-des-BSH_50_de.pdf?__blob=publicationFile&v=13/}
#' @references \url{https://doi.org/10.5194/os-15-1363-2019}
#' @param tmodel The model you built with BuildTT()
#' @param ssdate Start date of the synthesis. Format: "yyyy/mm/dd"
#' @param sstime Start time of the synthesis Format: "hh:mm:ss".
#' @param sedate End date of the synthesis. Format: "yyyy/mm/dd"
#' @param setime End time of the synthesis. Format: "hh:mm:ss"
#' @return Returns a tide table as a data.table, which is identical to c.table computed with TideTable().
#' @examples 
#' \dontrun{SynTT(tmodel = tt_model, ssdate = "1991/01/01", 
#' sstime = "12:00:00", sedate = "1992/01/01", setime = "12:00:00")}
#' @export


SynTT <- function(tmodel = NULL, ssdate, sstime, sedate, setime) {
  
  stopifnot(class(tmodel) == "tidetable")
  
  chron.origin <- chron(dates. = "1900/01/01", 
                        times. = "00:00:00",
                        format = c(dates = "y/m/d", times = "h:m:s"),
                        out.format = c(dates = "y/m/d", times = "h:m:s"))
  #retrieving objects
  otz     <- tmodel[["otz"]]
  omega_t <- tmodel[["omega_t"]]
  tm24    <- tmodel[["tm24"]]
  tplus   <- tmodel[["tplus"]]
  tmhwi   <- tmodel[["tmhwi"]]
  fitting.coef <- tmodel[["fitting.coef"]]
  
  #Synthesis period
  ssdate.time <- chron(dates. = ssdate,
                       times. = sstime,
                       format = c(dates = "y/m/d", times = "h:m:s"),
                       out.format = c(dates = "y/m/d", times = "h:m:s")) - chron.origin
  sedate.time <- chron(dates. = sedate,
                       times. = setime,
                       format = c(dates = "y/m/d", times = "h:m:s"),
                       out.format = c(dates = "y/m/d", times = "h:m:s")) - chron.origin
  #NumCulm Synthesis
  start.nummculm  <- NumCulm(t = ssdate.time, tmhwi = tmhwi)
  end.nummculm    <- NumCulm(t = sedate.time, tmhwi = tmhwi)
  
  time1        <- vector(mode = "double")
  height       <- vector(mode = "double")
  afunc        <- vector(mode = "double")
  coeff        <- vector(mode = "double")
  st.transit   <- vector(mode = "double")
  
  time.height  <- matrix(0.0, ncol = 6,
                         nrow = ((end.nummculm[["numm"]] - start.nummculm[["numm"]] + 1) * 4))
  
  m  <- 0L
  ii <- 0L
  stz24 <- otz / 24
  for (i in start.nummculm[["numm"]] : end.nummculm[["numm"]]) {
    ii <- ii + 1L
    afunc <- ComputeAfunc(xi = i, omega = omega_t)[[3]] #optimize?
    for (k in 1 : 4) {
      m <- m + 1L
      for (l in c("stunden.transit", "height")) {        
        coeff <- fitting.coef[[k]][[l]]
        summe <- coeff %*% afunc
        
        if (l == "stunden.transit") {
          st.transit <- summe
          tmmt.numm     <- i * tm24 + tplus
          time1      <- (tmmt.numm + summe / 24 + stz24)
          
        }
        else {
          height <- summe
        }   
      }
      if (k == 1 | k == 3){
        ihn <- 1
      } else {
        ihn <- 0
      }
      if (k == 1 | k == 2) {
        trans <- 1
      } else {
        trans <- 0
      }
      
      time.height[m, ] <- c(time1, ihn, trans, height,
                            st.transit, ii)
    }
  }
  date_time       <- NULL
  prediction_date <- NULL
  prediction_time <- NULL
  V1              <- NULL
  time.height <- as.data.table(time.height)
  
  time.height[ , date_time := format(chron(dates. = V1, 
                                          origin. = c(month = 1, day = 1, year = 1900)),
                                    "%Y/%m/%d %H:%M:%S" )]
  time.height[, c("prediction_date", "prediction_time") := tstrsplit(date_time, split = " ")]
  
  setnames(time.height, c("V6","V5","V4","V3","V2", "V1"), 
           c("i", "st.transit", "height", "upper_or_lower_transit",
             "high_or_low_water", "transit"))
  
  time.height[, date_time := NULL]
  setcolorder(time.height, c("transit",
                             "prediction_date",
                             "prediction_time",
                             "high_or_low_water",
                             "upper_or_lower_transit",
                             "height",
                             "st.transit",
                             "i"))
  return(time.height)
  
}