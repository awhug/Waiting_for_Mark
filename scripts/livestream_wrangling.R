library(lubridate)
library(here)
library(jsonlite)

# Import json file
mmg <- fromJSON(here("Waiting_for_Mark/data/youtube_data.json"),
                flatten = TRUE)

# Convert data
mmg <- do.call(rbind, mmg)
mmg <- dplyr::mutate_all(as.data.frame(mmg), ymd_hms, tz = "Australia/Perth")
mmg$source <- "youtube"
mmg$url <- paste0("https://www.youtube.com/watch?v=", rownames(mmg))

# Mend scheduled start times - as per @whattimemark twitter account
mmg[5,  3] <- "2021-05-06 12:45:00"
mmg[12, 3] <- "2021-04-27 09:00:00"
mmg[14, 3] <- "2021-04-25 13:15:00"
mmg[20, 3] <- "2021-02-01 11:30:00"

# Calculate difference in times
mmg$diff <- as.vector(with(mmg, difftime(actualStartTime, scheduledStartTime, units = "mins")))
