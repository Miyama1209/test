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