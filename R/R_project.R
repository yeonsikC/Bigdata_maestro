install.packages("foreign")
library(foreign)  #SPSS ���� �ҷ�����
library(dplyr)    #��ó��
library(ggplot2)  #�ð�ȭ
library(readxl)   #���� ���� �ҷ�����

#������ �����
raw_welfare <- read.spss(file = 'C:/workspace/R/Koweps_etc (1)/������/Koweps_hpc10_2015_beta1.sav',
                         to.data.frame=T)
#���纻 �����
welfare <- raw_welfare

#������ �����ϱ�
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

#������ ����
welfare <- rename(welfare,
                  sex = h10_g3,           #����
                  birth = h10_g4,         #�¾ ����
                  marriage = h10_g10,     #ȥ�� ����
                  religion = h10_g11,     #����
                  income = p1002_8aq1,    #����
                  code_job = h10_eco9,    #���� �ڵ�
                  code_region = h10_reg7) #���� �ڵ�

#����� ������ ����
welfare_s <- select(welfare, c(sex, birth, marriage, religion, income, code_job, code_region))
#���� �����߿��� �������� �ƴѰ͸� ��Ÿ��
welfare_s %>% filter(!is.na(sex))

###������ ���� ���� ����
class(welfare_s$sex) #������ Ÿ�� Ȯ��
table(welfare_s$sex) #�� Ȯ��(1��/2��)
#�̻�ġ�� �ִٸ� �Ʒ��� ���� ������ ó�� �ǽ�
welfare_s$sex <- ifelse(welfare_s$sex == 9, NA, welfare$sex)
#����ġ Ȯ��
table(is.na(welfare_s$sex)) #����ġ�� ���� : FALSE
#���� �׸� �̸� �ο�
welfare_s$sex <- ifelse(welfare_s$sex==1,"male","female")
table(welfare_s$sex)
qplot(welfare_s$sex) #����׷���

#���� �����ϱ�
class(welfare_s$income)
summary(welfare_s$income)
qplot(welfare_s$income) #default�� �ִ񰪱��� ���̵��� �����Ǿ�����.
qplot(welfare_s$income) + xlim(0, 1000) #0~1000
summary(welfare_s$income) #min=0 : �����̾��� -����ġó��.
#�̻�ġ ����ġ ó��
welfare_s$income <- ifelse(welfare_s$income %in% c(0, 9999), NA, welfare_s$income)
#����ġ Ȯ��
table(is.na(welfare_s$income))

#���� ���� ���ǥ �����
sex_income <- welfare_s%>%              #������ ��ռ����� ��Ÿ��
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))
#��������� ������ �������� ������ �� 150���� �� ����.

#�׷��� �����
ggplot(data=sex_income, aes(x=sex, y=mean_income)) + geom_col()