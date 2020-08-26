library(ggplot2)
library(tidyr)

#"total" in excel is "subtotal" under comfirmed cases = discharged + isolated + deceased 
# for e.g: subtotal = 427 in table 1 and 2 https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030 
# "new" in excel is not newly-found isolated cases (424), instead
# "new" in excel = "newly comifirmed" in table 2, is a sum of discharged + isolated + deceased

data <- read.csv("Covid19_KCDC_Geo.csv")
summary(data)
summary(data$location)
data$ID <- as.factor(data$ID)
summary(data$ID)
data$level <- rep(NA, 1114)

# add column level, city vs. province
for (i in 1:1114) {
           ifelse(data$ID[i]==1 || data$ID[i]==4 || data$ID[i]==5 || data$ID[i]==7 || 
                  data$ID[i]==11 || data$ID[i]==15 || data$ID[i]==16 ||data$ID[i]==17, 
                  data$level[i] <- "city", data$level[i] <- "province")
                  }

data$level <- as.factor(data$level)
summary(data$level)

# convert to date object
data$date <- as.Date(data$date)


# delete observations with time=16:00, as most obs w/ time= 0:00 and 
# it's closer to 9:00.
data1 <- data[data$time!= "16:00", ]

# delete observations from Airport
data2 <- data1[data1$ID!=0, ]
row.names(data2) <- 1:1020

# create a column to represent difference between row i and i-1
data2$diff <- c(NA, diff(data2$total))

# check if new (newly confirmed) is equal to diff in total
dv <- which(data2$new!= data2$diff)
dv # rows where new != diff, a few cases 
# [1]   5   6  69 190 191 219 245 249 250 305 425 485 486 491 785 786 905 906
# check these rows 
# not verified w/ KCDC website yet as of 08-25-2020, 
# it needs to check 6 notices (3 notices * 2 days) on KCDC for each occasion 
# consider use column diff for sensitivity test
dr <- data2[dv, ]


###plot to check for if values looks correct
p <- ggplot(data2, aes(x=date, y=total)) + 
  geom_line() +
  facet_wrap(~ID)
p

p1 <- ggplot(data2, aes(x=date, y=new)) + 
  geom_line() +
  facet_wrap(~ID)
p1
########check if total is non-decreasing
nd <-which(diff(data2$total)<0)
nd
# [1]  13  17 249 258 297 304 374 785 793
# the above 9 rows were checked and found to be conformed with original data source on KCDC
# so those days w/ new <0 are inherent errors from the original data source
# for one row listed above (17) from 2020-03-09 in Busan, 
# we can see total decreased to 96 from 97,
# check CDC website we found this note: "There was one deceased case in Busan, 
# but the local government in charge of the case changed from Busan to Gyeongbuk"
# (https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030&act=view&list_no=366490&tag=&nPage=33)
# This kind of mistake affects the day the mistake taken place 
# and the day it was corrected but dose NOT affect days in-between
# since we don't know when is the day the mistake happen, it won't be able to be corrected.


####### Check for NA
summary(data2$new)
summary(data2$total)
kna <- which(is.na(data2$total)) #every location missing 2-21 to 2-23

###### create t*i maxtrix for sts object
data3<-data2[ ,c(2,3,6)]
obs1 <- spread(data3, location, new)
saveRDS(obs1, file="obs1.RDS" )

