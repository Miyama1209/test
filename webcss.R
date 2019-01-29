library(rvest)
library(janitor)
library(tidyverse)
library(lubridate)
wp <- "http://en.wikipedia.org/wiki/Men%27s_100_metres_world_record_progression"
m100 <- wp %>% read_html()
m100

m100 %>% 
  html_nodes("#mw-content-text > div > table:nth-child(8)") %>%
  html_table(fill=TRUE)

pre_iaaf <- 
  m100 %>% 
  html_nodes("#mw-content-text > div > table:nth-child(8)") %>%
  html_table(fill=TRUE)
class(pre_iaaf)

pre_iaaf <-
  pre_iaaf %>%
  bind_rows() %>%
  as_tibble()
pre_iaaf

pre_iaaf <-
  pre_iaaf %>%
  clean_names()
pre_iaaf

pre_iaaf <-
  pre_iaaf %>%
  mutate(athlete = ifelse(is.na(as.numeric(athlete)), athlete, lag(athlete)))

pre_iaaf <-
  pre_iaaf %>%
  mutate(date = mdy(date))
pre_iaaf


iaaf_76 <-
  m100 %>%
  html_nodes("#mw-content-text > div > table:nth-child(14)") %>%
  html_table(fill=TRUE)
  
iaaf_76 <-
  iaaf_76 %>%
  bind_rows() %>%
  as_tibble() %>%
  clean_names()

iaaf_76 <-
  iaaf_76 %>%
  mutate(athlete = ifelse(athlete=="", lag(athlete), athlete)) %>%
  mutate(date = mdy(date)) 

iaaf_76 %>%
  mutate(date = ifelse(is.na(date), lag(date), date))

iaaf_76 <-
  iaaf_76 %>%
  mutate(date = if_else(is.na(date), lag(date), date))
iaaf_76
