library(xlsx)
library(dpl)
library(ggplot2)
data <- read.xlsx2('C:/workspace/R/대전광역시_개인서비스요금_가격동향_2015.12월_.xlsx',
                  sheetIndex=1, startRow=4,header=T)
head(data)
View(data)
names(data)
str(data)

data$신탄진동 <- gsub("없음","", data$신탄진동)
data$신탄진동 <- gsub(" ","", data$신탄진동)

#factor -> numeric
for(i in c(4:12, 13:26, 31:51, 52:59, 60:69)){
  data[,i] <- as.numeric(as.character(data[,i]))
}

#원하는 변수만 select
data0 <- data[,c(1,4:12, 13:26, 31:51, 52:59, 60:69)]
View(data0)

names(data0)
#구별 평균 및 소수점 제거
{
  dong <-round(rowMeans(data0[,2:10], na.rm=T))
  joong <-round(rowMeans(data0[,11:24], na.rm=T))
  seo <-round(rowMeans(data0[,25:45], na.rm=T))
  yu <-round(rowMeans(data0[,46:53], na.rm=T))
  dae <-round(rowMeans(data0[,54:63], na.rm=T))
}

data_use <- data.frame(data0[,1],dong,joong,seo,yu,dae)
View(data_use)

#변수명 변경
colnames(data_use) <- c("항목", "동구", "중구", "서구", "유성구", "대덕구")
#데이터 없는 행 삭제
tail(data_use)
data_use <- data_use[c(2:47),]
View(data_use)
#유사항목이 많으니 결측값행 제거
data_use <- na.omit(data_use)
View(data_use)
#항목정의
data_use[,1]
#식비 : 1~25
#편의 : 26~42

#구 별, 종목 간 가격 차이 비교
food=0 #초기값
deviation=0 #초기값
for(i in 1:5){
  food[i] <- mean(data_use[1:25,(i+1)])
  deviation[i] <- mean(data_use[26:42,(i+1)])
}
final <- data.frame(food, deviation)
rownames(final) <- c("동구", "중구", "서구", "유성구", "대덕구")
colnames(final) <- c("음식", "편의")
View(final)

#시각화
stack_final <- stack(final)
rownames(stack_final) <- c("동구_F", "중구_F", "서구_F", "유성구_F", "대덕구_F",
                           "동구_D", "중구_D", "서구_D", "유성구_D", "대덕구_D")

ggplot(stack_final, aes(x=rownames(stack_final), y=values, colour=ind, group=ind)) +
  geom_line(linetype="dashed", size=1) +
  geom_point(size=2, shape=19) +
  ggtitle("자치구별 물가 차이")
  theme(plot.title=element_text(size=20))