library(xlsx)
library(dpl)
library(ggplot2)
data <- read.xlsx2('C:/workspace/R/����������_���μ��񽺿��_���ݵ���_2015.12��_.xlsx',
                  sheetIndex=1, startRow=4,header=T)
head(data)
View(data)
names(data)
str(data)

data$��ź���� <- gsub("����","", data$��ź����)
data$��ź���� <- gsub(" ","", data$��ź����)

#factor -> numeric
for(i in c(4:12, 13:26, 31:51, 52:59, 60:69)){
  data[,i] <- as.numeric(as.character(data[,i]))
}

#���ϴ� ������ select
data0 <- data[,c(1,4:12, 13:26, 31:51, 52:59, 60:69)]
View(data0)

names(data0)
#���� ��� �� �Ҽ��� ����
{
  dong <-round(rowMeans(data0[,2:10], na.rm=T))
  joong <-round(rowMeans(data0[,11:24], na.rm=T))
  seo <-round(rowMeans(data0[,25:45], na.rm=T))
  yu <-round(rowMeans(data0[,46:53], na.rm=T))
  dae <-round(rowMeans(data0[,54:63], na.rm=T))
}

data_use <- data.frame(data0[,1],dong,joong,seo,yu,dae)
View(data_use)

#������ ����
colnames(data_use) <- c("�׸�", "����", "�߱�", "����", "������", "�����")
#������ ���� �� ����
tail(data_use)
data_use <- data_use[c(2:47),]
View(data_use)
#�����׸��� ������ �������� ����
data_use <- na.omit(data_use)
View(data_use)
#�׸�����
data_use[,1]
#�ĺ� : 1~25
#���� : 26~42

#�� ��, ���� �� ���� ���� ��
food=0 #�ʱⰪ
deviation=0 #�ʱⰪ
for(i in 1:5){
  food[i] <- mean(data_use[1:25,(i+1)])
  deviation[i] <- mean(data_use[26:42,(i+1)])
}
final <- data.frame(food, deviation)
rownames(final) <- c("����", "�߱�", "����", "������", "�����")
colnames(final) <- c("����", "����")
View(final)

#�ð�ȭ
stack_final <- stack(final)
rownames(stack_final) <- c("����_F", "�߱�_F", "����_F", "������_F", "�����_F",
                           "����_D", "�߱�_D", "����_D", "������_D", "�����_D")

ggplot(stack_final, aes(x=rownames(stack_final), y=values, colour=ind, group=ind)) +
  geom_line(linetype="dashed", size=1) +
  geom_point(size=2, shape=19) +
  ggtitle("��ġ���� ���� ����")
  theme(plot.title=element_text(size=20))