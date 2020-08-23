library(ggplot2)

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
                  data$level[i] <- "city", data$level[i] <- "province")}
data$level <- as.factor(data$level)
summary(data$level)

# convert to date object
data$date <- as.Date(data$date)


# delete observations before 2020-02-25
data1 <- data[data$date >= "2020-02-25", ]

# delete observations from Airport
data2 <- data1[data1$ID!=0, ]
row.names(data2) <- 1:952
data2$diff <- c(NA, diff(data2$total))

# check if new (newly confirmed) is equal to diff in total
dv <- which(data2$new!= data2$diff)
dv # rows where new != diff
# [1]   1   2  57  61 113 169 174 175 203 225 229 230 281 337 393 449 450 455
# [19] 505 561 617 673 729 730 785 841 842 897

# check these rows
dr <- data2[dv, ]

###plot to check for if values looks correct
p <- ggplot(data3, aes(x=date, y=total)) + 
  geom_line() +
  facet_wrap(~ID)
p

########check if total is non-decreasing
x1 <-data3[data3$ID==1, ]
which(diff(x1$total)<0)

# from 2020-03-09, we can see total decreased to 96,
# check CDC website we found this note:
#" *There was one deceased case in Busan, 
# but the local government in charge of the case changed from Busan to Gyeongbuk."
# on (https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030&act=view&list_no=366490&tag=&nPage=33)
