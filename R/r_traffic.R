install.packages("readxl")
library(readxl)
library(dplyr)
library(ggmap)
data <- read_xlsx("C:/workspace/work/�ð��� ���α��뷮.xlsx")

#2017�� �����Ͱ� ���� �� 500���� �������⿡ 2016�� �����͸� ����
data_2016 <- data[1:413,]

#�׷캰 ���� ����
count_addr <- data_2016 %>% group_by(data_2016$...2) %>% summarise(n=n())

#Ȯ�� ��� �Ʒ� 5������ �����Ͱ� 1���ΰ��� Ȯ�� -> ����
data_2016 <- subset(data_2016, data_2016$...2!="���ȴ��")
data_2016 <- subset(data_2016, data_2016$...2!="���ȵ���")
data_2016 <- subset(data_2016, data_2016$...2!="�������2")
data_2016 <- subset(data_2016, data_2016$...2!="�����Ŵ��")
data_2016 <- subset(data_2016, data_2016$...2!="�������")


#��Һ� Ʈ���� �Ϸ���� ���
traffic_mean <- tapply(data_2016$�հ�, data_2016$...2, mean)/24
#��Һ� ��ٽð�(8��) Ʈ���� ��� ���
traffic_8 <- tapply(data_2016$`0.33333333333333331`, data_2016$...2, mean)
traffic_mean <- data.frame(traffic_mean,traffic_8)

#�ּ� -> �����浵
register_google(key = 'AIzaSyC1HESsjwnBdc_UKl3Yra7SJ7aSjz3eIng') 

addr <- paste("����������", rownames(traffic_mean))
traffic_mean$addr = addr
gc <- geocode(enc2utf8(addr))

#�����浵�� ���� �ʴ� �ּ� ����(���ͳ� ��� ������ ����)
traffic_mean <- subset(traffic_mean, addr!="���������� ��õ��")
gc <- geocode(enc2utf8(traffic_mean$addr))

#�����浵 -> �ּ�
addr_full=''
for(i in 1:dim(gc)[1]){
  addr_full[i] <- revgeocode(c(gc$lon[i],gc$lat[i]))
}

#���ּҿ��� ���� ����
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
  a <- gsub("Dong-gu","����",a) 
  a <- gsub("Seo-gu","����",a) 
  a <- gsub("Yuseong-gu","������",a) 
  a <- gsub("Daedeok-gu","�����",a) 
  a <- gsub("Jung-gu","�߱�",a) 
  addr_kor[i] <- a
}

#Ʈ���Ȱ� �� ���� cbind
data_gu <- cbind(traffic_mean,addr_kor,gc)
View(data_gu)

#�ּҰ� �ȶߴ� ������ ����
data_gu <- na.omit(data_gu)
data_gu <- data_gu[,-3]

#��Һ� Ʈ���� ��� ���
#�Ʒ� �ּ� 5���� �� ���� ��ġ�ϴ� �ּҷ�, �� ���� �Ÿ��� ��Ȯ�� �ϱ� ���� ����.
code <- c("���������� ����� �񷡵� 136-3", "���������� ���� �뼺�� �����", "���������� ���� ������ 1643", "���������� ������ �ż��� 380-4", "���������� �߱� ������ 142")
data_gu_mean <- tapply(data_gu$traffic_mean, data_gu$addr_kor, mean)
data_gu_8 <- tapply(data_gu$traffic_8, data_gu$addr_kor, mean)
data_gu_mean <- data.frame(data_gu_mean,data_gu_8)
location <- paste("����������", rownames(data_gu_mean))
gc <- geocode(enc2utf8(code))
address <- c("�����", "����", "����", "������", "�߱�")
data_gu_mean_gc <- cbind(address,data_gu_mean,gc)

#�Ϸ���� ������ ���� �ð�ȭ
map <- get_map(location='Daejeon', zoom=12, maptype='roadmap',color='bw')
ggmap(map) +
  geom_jitter(data=data_gu_mean_gc, aes(x=lon, y=lat, size=data_gu_mean))
#�⽼�ð� ��� ������ ���� �ð�ȭ
map <- get_map(location='Daejeon', zoom=12, maptype='roadmap',color='bw')
ggmap(map) +
  geom_jitter(data=data_gu_mean_gc, aes(x=lon, y=lat, size=data_gu_8))

  
#�Ϸ���� ����׷���
height <- as.numeric(data_gu_mean_gc$data_gu_mean)
name <- as.character(data_gu_mean_gc$address)
df <- data.frame(name,height)
df <- df[order(-df$height),]
cols <- c("brown", rep("grey",4))
barplot(df$height, names.arg=df$name, main="���� ��� Ʈ����", col=cols, border="white", space=0.5, width=50)

#��ٽð� ��� ����׷���
height <- as.numeric(data_gu_mean_gc$data_gu_8)
name <- as.character(data_gu_mean_gc$address)
df <- data.frame(name,height)
df <- df[order(-df$height),]
cols <- c("brown", rep("grey",4))
barplot(df$height, names.arg=df$name, main="���� ��ٽð� Ʈ����", col=cols, border="white", space=0.5, width=50, )


#������ ����
install.packages("writexl")
library(writexl)
writexl::write_xlsx(data_gu_mean_gc, path = "C:/workspace/work/Work/traffic_mean_8.xlsx")