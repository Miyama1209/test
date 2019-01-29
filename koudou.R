4 %in% 1:10
4 %in% 5:10
'%ni$' <- Negate('%in%')
1 == 2
1 != 2
a <- 10+5
a
?solve

df <- data.frame(x = 1:2, y=3:4)
df
mt <- as.matrix(df)
mt
class(df)
typeof(df)
str(df)
View(df)

lm(y~x)
# this is invalid since in the global environment, y and x do not exist.
lm(y~x, data = df)


df2 <- data.frame(x = rnorm(10), y = runif(10))
df2

your_vector <- c(1, 2, 5)
your_vector

library(dplyr)

stats::filter(1:10, rep(1, 2))

rnorm(n = 100, mean = 0, sd = 1)


a <- 1:10
a[4]
a[c(4,6)]
a[c(4:6)]

my_list <- list(a = "Hello?", b = c(1,2,3), c = data.frame(x = 1:5, y=6:10))
my_list
my_list[[1]][1]
my_list[[3]]$x[2]
my_list$a
lm(df$y ~ df$x)


a <- "Hello"
b <- "World"
rm(a,b)

#dplyr box
mpg %>%
  filter(manufacturer=="audi") %>%
  group_by(model) %>%
  summarise(hwy_mean = mean(hwy))

#filter: select rows
starwars %>%
  filter(species == "Human", height >= 190)

starwars %>%
  filter(grepl("Skywalker", name))

starwars %>%
  filter(is.na(height))

starwars %>%
  filter(!is.na(height))

#arrange: reorder
starwars %>%
  arrange(birth_year)

starwars %>%
  arrange(desc(birth_year))

#select: columns?
starwars %>%
  select(name:skin_color, species, -height)

starwars %>%
  select(alias=name, crib=homeworld, sex=gender)

starwars %>%
  select(name, contains("color"))

starwars %>%
  select(species, homeworld, everything())

#mutate: create new columns
starwars %>%
  select(name, birth_year) %>%
  mutate(dog_years = birth_year * 7) %>%
  mutate(comment = paste0(name, " is ", dog_years, " in dog years."))

starwars %>%
  select(name, birth_year) %>%
  mutate(dog_years = birth_year * 7, comment = paste0(name, " is ", dog_years, " in dog years."))

starwars %>%
  select(name, height) %>%
  filter(name %in% c("Luke Skywalker", "Anakin Skywalker")) %>%
  mutate(tall1 = height > 180) %>%
  mutate(tall2 = ifelse(height > 180, "Tall", "Short"))

starwars %>%
  group_by(species, gender) %>%
  summarise(mean_height = mean(height, na.rm = T))

starwars %>%
  group_by(species, gender) %>%
  summarise_if(is.numeric, funs(avg=mean), na.rm=T) %>%
  head(5)

starwars %>% slice(c(1,5))#subset rows by position

starwars %>% filter(gender=="female") %>% pull(height)
 
starwars %>% count(species)

fun <- starwars %>% group_by(species) %>% mutate(num = n())

library(nycflights13)
flights
planes

left_join(flights, planes) %>%
  select(year, month, day, dep_time, arr_time, carrier, flight, tailnum, type, model)

left_join(flights, planes %>% rename(year_built=year), by="tailnum" ) %>%
  select(year, month, day, dep_time, arr_time, carrier, flight, tailnum, year_built)

left_join(flights,  planes, by = "tailnum") %>%
  select(contains("year"), month, day, dep_time, arr_time, carrier, flight, tailnum, type, model) %>%
  head(3)

#tidyr box

stocks <- data.frame(time = as.Date('2009-01-01') + 0:1,
                     X=rnorm(2, 0, 1),
                     Y=rnorm(2, 0, 2),
                     Z=rnorm(2, 0, 4))
stocks

tidy_stocks <- stocks %>% gather(key=stock, value=price, -time)
tidy_stocks

tidy_stocks %>% spread(stock, price)
tidy_stocks %>% spread(time, price)

economists <- data.frame(name = c("Adam.Smith", "Paul.Samuelson", "Milton.Friedman"))

economists %>% separate(name, 
                        c("first_name", "last_name"),
                        sep=".")

jobs <- data.frame(
  name = c("Jack", "Jill"),
  occupation = c("Homemaker", "Philosopher, Philanthropist, Troublemaker") 
) 
jobs

jobs %>% separate_rows(occupation)

gdp <- data.frame(yr=rep(2016, times=4),
                  mnth=rep(1, times=4),
                  dy=1:4,
                  gdp=rnorm(4, mean=100, sd=2))
gdp
gdp %>% unite(date, c("yr", "mnth", "dy"), sep="-")
gdp_u <- gdp %>% unite(date, c("yr", "mnth", "dy"), sep="-") %>% as_tibble()
gdp_u
library(lubridate)
gdp_u %>% mutate(date = ymd(date))
