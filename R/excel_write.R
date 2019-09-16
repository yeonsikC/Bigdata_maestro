# Data Frame을 Excel File로 저장
library(readxl)
library(dplyr)

no <- c('1', '2', '3', '4', '5')
na <- c('hong', 'kim', 'lee', 'park', 'nam')
s <- c(90, 50, 70, 60, 80)

df <- data.frame(number = no, name = na, subject = s)
str(df)
dim(df)
head(df)
head(df)
tail(df)

#에러가 날 수 있음
install.packages('xlsx')
install.packages('rJava')

library(xlsx)
library(rJava)

write.xlsx(df,
           file = "C:/Workspace/R/excel_write.xlsx",
           sheetName = "new",
           col.names = T,
           row.names = F,
           append = T)

#다른 방법
install.packages("writexl")
library(writexl)
write_xlsx(df, path="C:/Workspace/R/excel_write.xlsx")
