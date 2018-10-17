library(dplyr)
library(ggplot2)
library(ggmap)
library(sp)
library(sf)
library(stringr)
library(maptools)
`%!in%` <- Negate(`%in%`) 
load("Experiments/Lost Letter/data/WA_tract_2010.RData")
load("Experiments/Lost Letter/data/lost_letter_tract_122117.RData")


letter_tracts <- c("00100", "01000", "10100", "10200", "10300", "10500", "10600", 
                   "10800", "10900", "01100", "11101", "11102", "11200", "11300", 
                   "11500", "11600", "11700", "11800", "11900", "01200", "12000", 
                   "12100", "01300", "01400", "01500", "01600", "01800", "01900", 
                   "00200", "02000", "02100", "02200", "02400", "02500", "02600", 
                   "02700", "02800", "02900", "00300", "03000", "03100", "03200", 
                   "03300", "03400", "03500", "03600", "03800", "03900", "04000", 
                   "00401", "00402", "04100", "04200", "04400", "04500", "04600", 
                   "04700", "04800", "04900", "00500", "05000", "05100", "05200", 
                   "05301", "05400", "05600", "05700", "05801", "05802", "05900", 
                   "00600", "06000", "06100", "06200", "06300", "06400", "06500", 
                   "06600", "06700", "06800", "06900", "00700", "07000", "07100", 
                   "07200", "07300", "07500", "07600", "07700", "07800", "07900", 
                   "00800", "08001", "08002", "08100", "08200", "08300", "08400", 
                   "08500", "08600", "08700", "08800", "08900", "00900", "09000", 
                   "09100", "09200", "09400", "09500", "09600", "09701", "09702", 
                   "09800", "09900", "10001", "10401", "10701", "11001", "11401", 
                   "01701", "04301", "07401", "10002", "10402", "10702", "11002", 
                   "11402", "01702", "04302", "07402")

mailbox_tracts <- c("02700", "08900", "09200", "06800", "07500", "09100", "02800", 
                   "00100", "10002", "10300", "10402", "10600", "02600", "05600", 
                   "06100", "06300", "07402", "07800", "09000", "09701")
  
littering_tracts <- c("00100", "01701", "02600", "04700", "06800", "07100", "07500", 
                      "08900", "09100", "09701", "10402", "11402")

ggplot(letter_tract_data, aes(fill=`Any Dropped`)) + geom_sf() + coord_sf(crs = "+proj=longlat +datum=WGS84", datum=NA) + get_map()

# KC_tract_2010 <- elide(WA_tract_2010[WA_tract_2010@data$NHGISCTY=="0330",], rotate=-16)
KC_tract_2010 <- elide(WA_tract_2010[WA_tract_2010@data$COUNTYFP10=="033",], rotate=-16)
seattle_tracts <- st_as_sf(KC_tract_2010[as.numeric(str_sub(KC_tract_2010@data$GISJOIN, -5,-1)) %in% 100:12100, "GISJOIN"]) %>%
  mutate(tract = str_sub(GISJOIN, -5,-1)) %>%
  mutate(mailbox = tract %in% mailbox_tracts,
         littering = tract %in% littering_tracts,
         lost_letter = tract %in% letter_tracts) %>%
  mutate(Experiment = case_when(
    mailbox==TRUE & littering==TRUE ~ "Mailbox, Littering",
    mailbox==TRUE ~ "Mailbox",
    littering==TRUE ~ "Littering",
    lost_letter==FALSE ~ "No Letters",
    TRUE ~ "Only Letters"
  )) %>%
  mutate(Experiment = forcats::fct_relevel(Experiment, "Mailbox, Littering", "Mailbox", "Littering", "Only Letters", "No Letters"))



ggplot(seattle_tracts, aes(fill=Experiment)) + geom_sf(size=0.1) + coord_sf(datum=NA) +
  scale_fill_manual(values = c("Mailbox, Littering"="#342c5c", "Mailbox"="#458490", "Littering"="#905145", "No Letters"="white", "Only Letters"="#cbd3a3")) +
  theme_minimal(base_size = 20)

ggsave("./Presentations/SocSem_102618/img/experiment_map.svg")
  