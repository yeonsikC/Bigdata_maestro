library(dplyr)    #전처리
library(ggplot2)  #시각화

#데이터 업로드1
data1 <- read.csv('C:/workspace/R/대전광역시_CCTV_20170201.csv', header=T)
head(data1)
#데이터 업로드2
data2 <- read.csv('C:/workspace/R/도로교통공단_전국_사망교통사고정보_2018_.csv', header=T)
head(data2)
#필요없는 변수 제거1
data_cctv <- select(data1, -c(관리기관명, 소재지지번주소, 관리기관전화번호, 데이터기준일자))
head(data_cctv)
View(data_cctv)
#필터링 및 필요없는 변수 제거2
data_acc <- filter(data2, 발생지시도=="대전")
data_acc <- select(data_acc, -c(발생년, 발생지시도))
head(data_acc)
dim(data_acc)

#빈도분석_cctv대수
head(data_cctv)
sum(data_cctv$카메라대수) # 205개
#빈도분석_대전시_2018년_교통사고건수
head(data_acc)
length(data_acc) # 25건
#사망자수 및 사상자수
sum(data_acc$사망자수) #93명
sum(data_acc$사상자수) #129명

#cctv 시각화 (위도경도가 있지만, 주소로 위도경도를 불러와봄)
library(ggmap)
register_google(key = 'AIzaSyC1HESsjwnBdc_UKl3Yra7SJ7aSjz3eIng') 
addr <- as.character(data1$소재지지번주소)
gc1 <- geocode(enc2utf8(addr))
str(gc)
df <- data.frame(name=data1$소재지지번주소, lon=gc$lon, lat=gc$lat)
cen <- c(mean(df$lon), mean(df$lat))+
map_cctv <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=12)
ggmap(map_cctv) + geom_point(data=gc1, aes(x=lon, y=lat, color="green"))

#교통사고 시각화
gc <- data.frame(data_acc$경도, data_acc$위도)
names(gc) <- c("lon", "lat")
df <- data.frame(name=data_acc$발생지시군구, lat=data_acc$위도, lon=data_acc$경도)
cen <- c(mean(df$lon), mean(df$lat))
map_acc <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=12)
ggmap(map_acc) +
  geom_point(data=gc, aes(x=lon, y=lat, size=3, colour="교통사고 발생위치")) +
  geom_point(data=gc1, aes(x=lon, y=lat, size=3, colour="CCTV 위치"))
