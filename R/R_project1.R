library(foreign)  #SPSS ���� �ҷ�����
library(dplyr)    #��ó��
library(ggplot2)  #�ð�ȭ
library(readxl)   #���� ���� �ҷ�����
dataset <- read.spss(file = 'C:/workspace/R/Koweps_etc (1)/������/Koweps_p10_2015_beta1.sav',
                         to.data.frame=T)
data<-dataset
data1 <- rename(data,
                income = p1002_8aq1,   #���� ���� �� ��� �ӱ�(����:����)
                internet = p1003_1,    #���ͳ� ��� ����(1.�׷���, 2.�ƴϴ�)
                service = p1004_4,     #�ڿ�����Ȱ�� ����(1.�׷���, 2.�ƴϴ�)
                edu = p1007_3aq1,      #�����з�(1.��������, 2.����, 3.������, 4.4��������, 5.���п��̻�)
                par_edu = np1006_39)   #�θ�� �����з�
data1 <- select(data1, c(income, internet, service, edu, par_edu))
#������ �� -> �������� ��ȯ
data1 <- mutate(data1, internet_value = ifelse(internet==1, "���ͳݻ��", "���ͳݹ̻��"))
data1 <- mutate(data1, service_value = ifelse(service==1, "�ڿ�������", "���ڿ�������"))
data1 <- mutate(data1, edu_value = ifelse(edu==1, "5. ��������",
                                          ifelse(edu==2, "4. ���� ����/����",
                                                 ifelse(edu==3, "3. ������ ����/����/����",
                                                        ifelse(edu==4, "2. 4�������� ����/����/����",
                                                               ifelse(edu==5, "1. ���п��̻�", NA))))))
data1 <- mutate(data1, par_edu_value = ifelse(par_edu==1, "5. ��������",
                                          ifelse(par_edu==2, "4. ���� ����/����",
                                                 ifelse(par_edu==3, "3. ������ ����/����/����",
                                                        ifelse(par_edu==4, "2. 4�������� ����/����/����",
                                                               ifelse(par_edu==5, "1. ���п��̻�", NA))))))
#�ֿ亯�� �̻�ġ ����
outlier_up <- boxplot(data1$income)$stats
data1$income <- ifelse(data1$income>outlier_up[5]|data1$income<outlier_up[1], NA, data1$income)
###########################����1. ���ͳ� ��� ���ο� �ҵ氣, ���谡 �ִ��� Ȯ��.
#����ġ Ȯ��
table(is.na(data1$income))
table(is.na(data1$internet))
#����ġ ����
data_internet <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(internet))
data_internet <- data1 %>% filter(income)
#������ Ȯ��
dim(data_internet)
attach(data_internet)
table(internet_value)
#�ҵ濡 ���� �⺻�м�
summary(income) #��� 241.6����
head(sort(income, decreasing = T)) #MAX�� 2400 �󵵰� 1�ΰ����� ���� ���������� �Ǵ�.
head(table(income))
#histogram
ggplot(data_internet, aes(income))+
  geom_histogram(binwidth=50,color='221')
#boxplot by internet
ggplot(data_internet, aes(x=internet_value, y=income, group=internet))+
  geom_boxplot(col='51')
#t-test
t.test(income~internet_value)

###########################����2. �ڿ����� ���ο� �ҵ氣, ���谡 �ִ��� Ȯ��.
#����ġ Ȯ��
table(is.na(data1$service_value))
#����ġ ����
data_service <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(service_value))
#������ Ȯ��
dim(data_service)
attach(data_service)
#�ڿ�����Ȱ�� ���� ������ ���� ���ʺм�
table(service_value)
ggplot(data_service, aes(x=factor(service_value)))+
  geom_bar(width = 0.5, color='77') #����׷��� #width : ���� �β�
#boxplot by internet
ggplot(data_internet, aes(x=service_value, y=income, group=service_value))+
  geom_boxplot(col='51')

#t-test
t.test(income~service_value)

###########################����3. �����з°� �ҵ氣, ���谡 �ִ��� Ȯ��.
#����ġ Ȯ��
table(is.na(data1$edu_value))
#����ġ ����
data_edu <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(edu_value))
#������ Ȯ��
dim(data_edu)
attach(data_edu)
#�зº����� ���� ���ʺм�
table(edu_value)
ggplot(data_edu, aes(x=factor(edu_value)))+
  geom_bar(width = 0.5, color='77') #����׷��� #width : ���� �β�
#boxplot
ggplot(data_par_edu, aes(x=par_edu_value, y=income, group=par_edu))+
  geom_boxplot(col='51')
#boxplot
ggplot(data_edu, aes(x=edu_value, y=income, group=edu))+
  geom_boxplot(col='51')
#anova
aov(income~edu_value)
#�׷캰 ���
aggregate(income~edu_value,data_edu,mean)

###########################����4. �θ�� �����з°� �ҵ氣, ���谡 �ִ��� Ȯ��.
#����ġ Ȯ��
table(is.na(data1$par_edu_value))
#����ġ ����
data_par_edu <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(par_edu_value))
#������ Ȯ��
dim(data_par_edu)
attach(data_par_edu)
#�зº����� ���� ���ʺм�
table(par_edu_value)
ggplot(data_par_edu, aes(x=factor(par_edu_value)))+
  geom_bar(width = 0.5, color='77') #����׷��� #width : ���� �β�
#boxplot
ggplot(data_par_edu, aes(x=par_edu_value, y=income, group=par_edu_value))+
  geom_boxplot(col='51')
#anova
aov(income~par_edu_value)
#�׷캰 ���
aggregate(income~par_edu_value,data_par_edu,mean)

################5.���ͳ� ��� ���ο� �ڿ�����Ȱ�� ���ΰ��� ���谡 �ִ��� Ȯ��.
#����ġ Ȯ��
table(is.na(data1$internet_value))
table(is.na(data1$service_value))
#����ġ ����
data_inser <- data1 %>% filter(!is.na(internet_value)) %>%
  filter(!is.na(service_value))
#������ Ȯ��
dim(data_inser)
attach(data_inser)
#�����м�
result <- data.frame(level=internet_value, pass=service_value)
table(result$level, result$pass)
chisq.test(internet_value,service_value)