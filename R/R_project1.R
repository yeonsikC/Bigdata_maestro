library(foreign)  #SPSS 파일 불러오기
library(dplyr)    #전처리
library(ggplot2)  #시각화
library(readxl)   #엑셀 파일 불러오기
dataset <- read.spss(file = 'C:/workspace/R/Koweps_etc (1)/데이터/Koweps_p10_2015_beta1.sav',
                         to.data.frame=T)
data<-dataset
data1 <- rename(data,
                income = p1002_8aq1,   #일한 달의 월 평균 임금(단위:만원)
                internet = p1003_1,    #인터넷 사용 여부(1.그렇다, 2.아니다)
                service = p1004_4,     #자원봉사활동 여부(1.그렇다, 2.아니다)
                edu = p1007_3aq1,      #최종학력(1.중졸이하, 2.고교, 3.전문대, 4.4년제대학, 5.대학원이상)
                par_edu = np1006_39)   #부모님 최종학력
data1 <- select(data1, c(income, internet, service, edu, par_edu))
#데이터 값 -> 실제용어로 변환
data1 <- mutate(data1, internet_value = ifelse(internet==1, "인터넷사용", "인터넷미사용"))
data1 <- mutate(data1, service_value = ifelse(service==1, "자원봉사자", "미자원봉사자"))
data1 <- mutate(data1, edu_value = ifelse(edu==1, "5. 중졸이하",
                                          ifelse(edu==2, "4. 고교 중퇴/졸업",
                                                 ifelse(edu==3, "3. 전문대 재학/중퇴/졸업",
                                                        ifelse(edu==4, "2. 4년제대학 재학/중퇴/졸업",
                                                               ifelse(edu==5, "1. 대학원이상", NA))))))
data1 <- mutate(data1, par_edu_value = ifelse(par_edu==1, "5. 중졸이하",
                                          ifelse(par_edu==2, "4. 고교 중퇴/졸업",
                                                 ifelse(par_edu==3, "3. 전문대 재학/중퇴/졸업",
                                                        ifelse(par_edu==4, "2. 4년제대학 재학/중퇴/졸업",
                                                               ifelse(par_edu==5, "1. 대학원이상", NA))))))
#주요변수 이상치 제거
outlier_up <- boxplot(data1$income)$stats
data1$income <- ifelse(data1$income>outlier_up[5]|data1$income<outlier_up[1], NA, data1$income)
###########################문제1. 인터넷 사용 여부와 소득간, 관계가 있는지 확인.
#결측치 확인
table(is.na(data1$income))
table(is.na(data1$internet))
#결측치 제거
data_internet <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(internet))
data_internet <- data1 %>% filter(income)
#데이터 확인
dim(data_internet)
attach(data_internet)
table(internet_value)
#소득에 대한 기본분석
summary(income) #평균 241.6만원
head(sort(income, decreasing = T)) #MAX값 2400 빈도가 1인것으로 봐서 실제값으로 판단.
head(table(income))
#histogram
ggplot(data_internet, aes(income))+
  geom_histogram(binwidth=50,color='221')
#boxplot by internet
ggplot(data_internet, aes(x=internet_value, y=income, group=internet))+
  geom_boxplot(col='51')
#t-test
t.test(income~internet_value)

###########################문제2. 자원봉사 여부와 소득간, 관계가 있는지 확인.
#결측치 확인
table(is.na(data1$service_value))
#결측치 제거
data_service <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(service_value))
#데이터 확인
dim(data_service)
attach(data_service)
#자원봉사활동 여부 변수에 대한 기초분석
table(service_value)
ggplot(data_service, aes(x=factor(service_value)))+
  geom_bar(width = 0.5, color='77') #막대그래프 #width : 막대 두께
#boxplot by internet
ggplot(data_internet, aes(x=service_value, y=income, group=service_value))+
  geom_boxplot(col='51')

#t-test
t.test(income~service_value)

###########################문제3. 최종학력과 소득간, 관계가 있는지 확인.
#결측치 확인
table(is.na(data1$edu_value))
#결측치 제거
data_edu <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(edu_value))
#데이터 확인
dim(data_edu)
attach(data_edu)
#학력변수에 대한 기초분석
table(edu_value)
ggplot(data_edu, aes(x=factor(edu_value)))+
  geom_bar(width = 0.5, color='77') #막대그래프 #width : 막대 두께
#boxplot
ggplot(data_par_edu, aes(x=par_edu_value, y=income, group=par_edu))+
  geom_boxplot(col='51')
#boxplot
ggplot(data_edu, aes(x=edu_value, y=income, group=edu))+
  geom_boxplot(col='51')
#anova
aov(income~edu_value)
#그룹별 평균
aggregate(income~edu_value,data_edu,mean)

###########################문제4. 부모님 최종학력과 소득간, 관계가 있는지 확인.
#결측치 확인
table(is.na(data1$par_edu_value))
#결측치 제거
data_par_edu <- data1 %>% filter(!is.na(income)) %>%
  filter(!is.na(par_edu_value))
#데이터 확인
dim(data_par_edu)
attach(data_par_edu)
#학력변수에 대한 기초분석
table(par_edu_value)
ggplot(data_par_edu, aes(x=factor(par_edu_value)))+
  geom_bar(width = 0.5, color='77') #막대그래프 #width : 막대 두께
#boxplot
ggplot(data_par_edu, aes(x=par_edu_value, y=income, group=par_edu_value))+
  geom_boxplot(col='51')
#anova
aov(income~par_edu_value)
#그룹별 평균
aggregate(income~par_edu_value,data_par_edu,mean)

################5.인터넷 사용 여부와 자원봉사활동 여부간의 관계가 있는지 확인.
#결측치 확인
table(is.na(data1$internet_value))
table(is.na(data1$service_value))
#결측치 제거
data_inser <- data1 %>% filter(!is.na(internet_value)) %>%
  filter(!is.na(service_value))
#데이터 확인
dim(data_inser)
attach(data_inser)
#교차분석
result <- data.frame(level=internet_value, pass=service_value)
table(result$level, result$pass)
chisq.test(internet_value,service_value)
