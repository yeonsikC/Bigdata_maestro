install.packages("readxl")
library(readxl)
library(dplyr)
library(ggmap)
data <- read_xlsx("C:/workspace/work/시간당 도로교통량.xlsx")

#2017년 데이터가 행의 수 500에서 끊어졌기에 2016년 데이터만 추출
data_2016 <- data[1:413,]

#그룹별 개수 세기
count_addr <- data_2016 %>% group_by(data_2016$...2) %>% summarise(n=n())

#확인 결과 아래 5지역은 데이터가 1개인것을 확인 -> 삭제
data_2016 <- subset(data_2016, data_2016$...2!="도안대로")
data_2016 <- subset(data_2016, data_2016$...2!="도안동로")
data_2016 <- subset(data_2016, data_2016$...2!="동서대로2")
data_2016 <- subset(data_2016, data_2016$...2!="월드컵대로")
data_2016 <- subset(data_2016, data_2016$...2!="현충원로")


#장소별 트래픽 하루평균 계산
traffic_mean <- tapply(data_2016$합계, data_2016$...2, mean)/24
#장소별 출근시간(8시) 트래픽 평균 계산
traffic_8 <- tapply(data_2016$`0.33333333333333331`, data_2016$...2, mean)
traffic_mean <- data.frame(traffic_mean,traffic_8)

#주소 -> 위도경도
register_google(key = 'AIzaSyC1HESsjwnBdc_UKl3Yra7SJ7aSjz3eIng') 

addr <- paste("대전광역시", rownames(traffic_mean))
traffic_mean$addr = addr
gc <- geocode(enc2utf8(addr))

#위도경도가 뜨지 않는 주소 삭제(인터넷 결과 나오지 않음)
traffic_mean <- subset(traffic_mean, addr!="대전광역시 옥천길")
gc <- geocode(enc2utf8(traffic_mean$addr))

#위도경도 -> 주소
addr_full=''
for(i in 1:dim(gc)[1]){
  addr_full[i] <- revgeocode(c(gc$lon[i],gc$lat[i]))
}

#영주소에서 구만 추출
word=''
word <- strsplit(addr_full, split=",")

addr_kor=''
for(i in 1:33){
  df <- data.frame(word[i])
  colnames(df) <- "addr_col"
  df_0 <- gsub(" ", "", df$addr_col)  
  df_0 <- data.frame(df_0)
  
  a <- subset(df_0, df_0=="Dong-gu"|df_0=="Seo-gu"|df_0=="Yuseong-gu"|df_0=="Daedeok-gu"|df_0=="Jung-gu")
  a <- a[1,1]
  a <- gsub("Dong-gu","동구",a) 
  a <- gsub("Seo-gu","서구",a) 
  a <- gsub("Yuseong-gu","유성구",a) 
  a <- gsub("Daedeok-gu","대덕구",a) 
  a <- gsub("Jung-gu","중구",a) 
  addr_kor[i] <- a
}

#트래픽과 구 변수 cbind
data_gu <- cbind(traffic_mean,addr_kor,gc)
View(data_gu)

#주소가 안뜨는 결측값 제거
data_gu <- na.omit(data_gu)
data_gu <- data_gu[,-3]

#장소별 트래픽 평균 계산
#아래 주소 5곳은 각 구에 위치하는 주소로, 각 구별 거리를 명확히 하기 위해 지정.
code <- c("대전광역시 대덕구 비래동 136-3", "대전광역시 동구 대성동 식장산", "대전광역시 서구 관저동 1643", "대전광역시 유성구 신성동 380-4", "대전광역시 중구 사정동 142")
data_gu_mean <- tapply(data_gu$traffic_mean, data_gu$addr_kor, mean)
data_gu_8 <- tapply(data_gu$traffic_8, data_gu$addr_kor, mean)
data_gu_mean <- data.frame(data_gu_mean,data_gu_8)
location <- paste("대전광역시", rownames(data_gu_mean))
gc <- geocode(enc2utf8(code))
address <- c("대덕구", "동구", "서구", "유성구", "중구")
data_gu_mean_gc <- cbind(address,data_gu_mean,gc)

#하루평균 데이터 지도 시각화
map <- get_map(location='Daejeon', zoom=12, maptype='roadmap',color='bw')
ggmap(map) +
  geom_jitter(data=data_gu_mean_gc, aes(x=lon, y=lat, size=data_gu_mean))
#출슨시간 평균 데이터 지도 시각화
map <- get_map(location='Daejeon', zoom=12, maptype='roadmap',color='bw')
ggmap(map) +
  geom_jitter(data=data_gu_mean_gc, aes(x=lon, y=lat, size=data_gu_8))

  
#하루평균 막대그래프
height <- as.numeric(data_gu_mean_gc$data_gu_mean)
name <- as.character(data_gu_mean_gc$address)
df <- data.frame(name,height)
df <- df[order(-df$height),]
cols <- c("brown", rep("grey",4))
barplot(df$height, names.arg=df$name, main="구별 평균 트래픽", col=cols, border="white", space=0.5, width=50)

#출근시간 평균 막대그래프
height <- as.numeric(data_gu_mean_gc$data_gu_8)
name <- as.character(data_gu_mean_gc$address)
df <- data.frame(name,height)
df <- df[order(-df$height),]
cols <- c("brown", rep("grey",4))
barplot(df$height, names.arg=df$name, main="구별 출근시간 트래픽", col=cols, border="white", space=0.5, width=50, )


#데이터 추출
install.packages("writexl")
library(writexl)
writexl::write_xlsx(data_gu_mean_gc, path = "C:/workspace/work/Work/traffic_mean_8.xlsx")
