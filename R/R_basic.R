sex <- factor("m", c("m", "f"))
sex
nlevels(sex)
levels(sex)
levels(sex)[1]
levels(sex)[2]
sex
levels(sex) <- c("male", "female")
sex
data.frame(sex)

#factor는 범주를 지정하는것. 순서는 안정해줌.
#ordered는 순서가 지정됨.
ordered(c("a","b","c"))
factor(c("a","b","c"),ordered=T)

seq(1, 10, 2)
x<- seq_len(5)
names(x) <- c("one","two")
names(x)[2]
nrow(x)
NROW(x)

2 %in% x #포함되어있는지 유무 확인
6 %in% x
union(c('a','b'),c('a','d')) #합집합
intersect( c( 'a','b','c'), c('a','d')) #교집합
setdiff(c('a','b','c'),c('a','d')) #차집합

seq(1,5)
seq(1,20,3)
1:5
rep(1:2,6)
rep(1:2,each=5)

y <- matrix(c(1:9),nrow=3, byrow=T)
y <- matrix(c(1:9),ncol=3)

d <- data.frame(matrix(c(1,2,3,4), ncol=2))
str(d)
colnames(d) <- c("X","Y")
d
str(d)
#전체를 괄호로 씌우면 출력결과가 바로 나옴
(dl <- data.frame(list(x=c(1,2), y=c(3,4))))
str(dl)
dim(dl)
x <- c('m','f')
class(x)
x1 <- as.factor(x)
class(x1)

score2 <- data.frame(name = c('hong', 'kim', 'lee'),
                     kor = c(50,90,70),
                     eng = c(50,90,70))
rownames(score2) <- c('hong','kim','lee')
score2
s <- score2[,2:3]
if(s$kor[1] > 50){
  print(T)
}else{
  print(F)
}

s$grade <- ifelse(sum(s$kor)<50,"pass","fail")
s$sum <- s$kor + s$eng

sum=0
for(i in seq(2,100,2)){
  sum = sum+i
}
sum
for(i in s[1,]){
  print(i)
}
d <- data.frame(n=c('a','b','c'),
                k=c(50,90,70),
                e=c(50,90,70))
for(i in d){
 print(i) 
}
str(d)

library(dplyr)
library(ggplot2)
library()
mpg <- data.frame(mpg) #ggplot2에 포함되어있는 data
str(mpg)
dim(mpg) #data(행), 변수개수
View(mpg)

library(readxl)
data <- read_xlsx("C:/workspace/R/excel_data.xlsx")
data <- read_xlsx("C:/workspace/R/excel_data.xlsx", sheet=2)
data <- read.table("C:/workspace/R/txt_data.txt", header=T)
data <- read.table("C:/workspace/R/txt_data.txt", header=T, skip=1)
data <- read.table("C:/workspace/R/txt_data.txt", header=T, nrows=1)
data <- read.table("C:/workspace/R/txt_data2.txt", header=T)
data <- read.table("C:/workspace/R/csv_data.csv", header=T, sep=',')
data <- read.csv("C:/workspace/R/csv_data.csv", header=T)

data <- read_excel("C:/workspace/R/excel_data.xlsx", col_names = T) # 'col_names' = 'header'
data <- read.csv("C:/workspace/R/csv_data.csv", stringsAsFactors = T)
str(data)

write.csv(data,file ="C:/workspace/R/r_to_csv.csv")
save(data,file ="C:/workspace/R/r_to_csv2.csv")
save(data,file ="C:/workspace/R/r_to_rda.rda") # 깨짐 : binary파일이라. ; rda : R 전용파일
data <- load("C:/workspace/R/r_to_rda.rda")
str(data)

data <- read.csv("C:/workspace/R/SURFACE_ASOS_133_MI_2019-06_2019-06_2019.csv")
str(data)
dim(data)
head(data)
tail(data)

ls(data)
names(data)
summary(data)

10%%3
10%/%3
10/3

library(dplyr)
filter(data, Price>=15.5) # 원하는 조건의 데이터셋 쉽게 생성
arrange(data, Price) #Price을 기준으로 한 오름차순 정렬.
arrange(data, desc(Price)) #Price를 기준으로 한 내림차순 정렬.
arrange(data, Price, desc(Quantity)) #Price기준 오름차순 정렬 후, 동순위끼리 Quantity기준 내림차순.
select(data, itemName, Price, Quantity) #원하는 변수만 뽑아냄.
data2 <- select(data, itemName, Price, Quantity)
filter(data2, itemName=="tv")

# %>% : 파이프 - 중간연결도구
select(data, itemName, Price, Quantity) %>%
  filter(Price==2)

data %>%
  select(itemName, Price, Quantity) %>%
  filter(Price==2)

rename(data, Name = itemName, No = itemNo)

temp <- data
temp<-temp[-1,]
subset(temp,select=-Quantity) #원하는 변수 삭제


data <- read.csv("C:/workspace/R/SURFACE_ASOS_133_MI_2019-06_2019-06_2019.csv")
names(data)
head(data)
data2 <- data[,-c(1,10,11)]
names(data2)
data2 <- rename(data2, time = 일시, temp=기온..C.,
       rain_mm = 누적강수량.mm., dire_wind = 풍향.deg., speed_wind=풍속.m.s.,
       atm_pressure=현지기압.hPa., sea_pressure=해면기압.hPa., wetness=습도...)
head(data2)

data3 <- mutate(data2, multi = speed_wind*atm_pressure) # 변수 추가시 사용.
names(data2)
head(data3)
data4 <- mutate(data3, rank = rank(temp))
head(data4)
stem(head(data3,50)$dire_wind) #줄기 잎 그림

x<-c(1:10)
boxplot(1:24)

library(ggplot2)
dev.off() # invalid graphics state 이 에러날 때 바로 해결됨.
ggplot(data = mpg, aes(x=displ,y=hwy))+ geom_point() # scatterplot
df <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
df
ggplot(data=df, aes(x=drv,y=mean_hwy))+geom_col() # boxplot

id <- 1:10
sex <- c("f","m","f","m","m","f","f","f","m","f")
age <- c(50,40,28,50,27,23,56,47,20,38)
area <- c("서울","경기","제주","서울","서울","서울","경기","서울","인천","경기")
amt17 <- c(1300000, 450000, 275000, 400000, 845000, 42900, 150000, 570000, 930000, 520000)
y17_cnt <- c(50,25,10,8,30,1,2,10,4,17)
amt16 <- c(100000, 700000, 50000, 125000, 760000, 300000, 130000, 400000, 250000, 550000)
y16_cnt <- c(40,30,5,3,28,6,2,7,2,16)
data <- data.frame(id,sex,age,area,amt17,y17_cnt,amt16,y16_cnt)
data <- rename(data, y17_amt = amt17, y16_amt = amt16)
str(data)
boxplot(data$age~data$sex)
data$amt <- sum(data$y17_amt, data$y16_amt)
# data <- mutate(data, amt=y17_amt+y16_amt)
data$cnt <- sum(data$y17_cnt, data$y16_cnt) 
data <- mutate(data, avg_amt = amt/cnt)
data <- mutate(data, age50_yn = ifelse(age>=50,"Y","N"))
#오류 발생! why? 함수 안에는 제어문 x (???)
#data <- mutate(data, age_gr10 = if(age>=50){"A1.50++"})
###################################3############### dplyr 핵심
#age_gr10이라는 변수 생성. ifelse를 통한 조건문 활용.
data <- mutate(data, age_gr10 = ifelse(age>=50,"A1.50++",
               ifelse(age>=40,"A2.4049",
               ifelse(age>=30,"A3.3039",
               ifelse(age>=20,"A4.2029", "A5.0019")))))
#원하는 데이터 출력 및 변수제거
select(data, id)
select(data, id, area, y17_cnt)
select(data, -area)
select(data, -c(area, y17_cnt))
#원하는 데이터값에 있는 경우 출력
filter(data, area=="서울")
filter(data, area=="서울", y17_cnt>=10)
#내림차순 및 오름차순
arrange(data, age) #오름차순
arrange(data, desc(age)) #내림차순
arrange(data, age, desc(y17_cnt))
#원하는 요약값 생성
data %>% summarise(tot_y17_amt = sum(y17_amt))
data %>% summarise(tot_y16_amt = sum(y16_amt))
#빈도수 확인
table(data$sex)
table(data$age50_yn)
table(data$age_gr10)
#지역별 합계를 나타냄
data %>%
  group_by(area) %>% #area변수로 그룹을 나눔.
  summarise(sum_y17_amt = sum(y17_amt))

data %>%
  group_by(age50_yn) %>%
    summarise(sum_y17_amt = sum(y17_amt),
              avg_y17_amt = mean(y17_amt))

#boxplot
str(airquality)
ggplot(airquality, aes(x=Day, y=Temp)) + #aes : 축 이름
  geom_point(size = 3, color = "red") #산점도

ggplot(airquality, aes(x=Day, y=Temp)) +
  geom_line(color = "blue") #꺾은선 그래프

ggplot(airquality, aes(x=Day, y=Temp)) +
  geom_point(size = 3, color = "75") +
  geom_line(color = "77")

str(mtcars)
#factor함수를 사용하여 빈도수 0인 값을 제외하고 나타냄
ggplot(mtcars, aes(x=factor(cyl)))+
  geom_bar(width = 0.5, color='77') #막대그래프 #width : 막대 두께

ggplot(mtcars, aes(x=factor(cyl)))+
  geom_bar(aes(fill = factor(gear)))+ # 누적막대그래프

ggplot(mtcars, aes(x=factor(cyl)))+
  geom_bar(aes(fill = factor(gear)))+
  coord_polar() #썬버스트형식.

ggplot(mtcars, aes(x=factor(cyl)))+
  geom_bar(aes(fill = factor(gear)))+
  coord_polar(theta = "y") # 썬버스트차트를 원그래프로 나타냄.

ggplot(airquality, aes(x=Day, y=Temp, group=Day))+
  geom_boxplot() #날짜별 온도 boxplot.

ggplot(airquality, aes(Temp))+
  geom_histogram(binwidth=1) #온도 histogram, binwidth : 해상도크기

str(economics)
dim(economics)
head(economics)

#intercept : y절편, slope : 기울기 (회귀식으로 얻음)
ggplot(economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_abline(intercept = 12.18671, slope = -00.0005444)

#수평선을 지정해줌(psavert변수의 평균으로)
ggplot(economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_hline(yintercept = mean(economics$psavert))

#psavert : 저축률
xinter <- filter(economics, #psavert가최소일 때의 날짜
                 psavert == min(economics$psavert))$date
#수직선 지정.
ggplot(economics, aes(x=date, y=psavert))+
  geom_line()+
  geom_vline(xintercept=xinter)

##########################################결측값 이상치 제거
id <- 1:12
class <- c(1,1,1,1,NA,2,2,2,3,3,3,3)
english <-c(98,87,86,98,80,89,90,NA,98,98,99999,85)
science <-c(50,60,78,56,65,NA,45,99999,15,45,65,32)
data <- data.frame(id,class,english,science)

is.na(data) # 값 하나하나 결측치인지 확인
table(is.na(data)) # 결측치 수 확인
table(is.na(data$id)) # 변수별 결측치 수 확인
table(is.na(data$english))
table(is.na(data$science))

sum(data$english)

data %>% filter(is.na(english))
data %>% filter(!is.na(english))
#결측치 제거 방법 0 : 핉터 함수 사용
data_no_na <- data %>% filter(!is.na(english)) %>%
  filter(!is.na(class)) %>%
  filter(!is.na(science))
#sum 구해보기
sum(data_no_na$english)
sum(data_no_na$science)

#방법 1 : 결측치 쉽게 제거(행모두삭제)
data_no_na2 <- na.omit(data) #결측치가 포함된 행 모두 삭제
table(is.na(data_no_na2)) #결측치가 없다!
#방법 2 : 계산할때마다 결측치가 아닌값들만 계산.(정상적인 데이터 보존 가능)
sum(data$english, na.rm=T) #결측치가 아닌값들만 계산.
#방법 3 : 결측값을 그 변수의 평균(대푯값)으로 대체.(정상적인 데이터 보존 가능)
avg <- mean(data$english, na.rm = T)
data$english <- ifelse(is.na(data$english), avg, data$english)
sum(data$english)

### 이상치 제거
data_pre <- ifelse((data$english<0)|(data$english>100), #이상치를 NA로 변환.
                   NA, data$english)
table(data_pre) #빈도표 출력
sum(data$english, na.rm=T) #이상치 제거한 합계값.


c <- c(1:10, 20, 30)
boxplot(c)
