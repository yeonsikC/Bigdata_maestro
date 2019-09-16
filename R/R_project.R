install.packages("foreign")
library(foreign)  #SPSS 파일 불러오기
library(dplyr)    #전처리
library(ggplot2)  #시각화
library(readxl)   #엑셀 파일 불러오기

#데이터 만들기
raw_welfare <- read.spss(file = 'C:/workspace/R/Koweps_etc (1)/데이터/Koweps_hpc10_2015_beta1.sav',
                         to.data.frame=T)
#복사본 만들기
welfare <- raw_welfare

#데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

#변수명 변경
welfare <- rename(welfare,
                  sex = h10_g3,           #성별
                  birth = h10_g4,         #태어난 연도
                  marriage = h10_g10,     #혼인 상태
                  religion = h10_g11,     #종교
                  income = p1002_8aq1,    #월급
                  code_job = h10_eco9,    #직업 코드
                  code_region = h10_reg7) #지역 코드

#사용할 변수만 추출
welfare_s <- select(welfare, c(sex, birth, marriage, religion, income, code_job, code_region))
#성별 변수중에서 결측값이 아닌것만 나타냄
welfare_s %>% filter(!is.na(sex))

###성별에 따른 월급 차이
class(welfare_s$sex) #데이터 타입 확인
table(welfare_s$sex) #빈도 확인(1남/2여)
#이상치가 있다면 아래와 같이 결측값 처리 실시
welfare_s$sex <- ifelse(welfare_s$sex == 9, NA, welfare$sex)
#결측치 확인
table(is.na(welfare_s$sex)) #결측치가 없다 : FALSE
#성별 항목 이름 부여
welfare_s$sex <- ifelse(welfare_s$sex==1,"male","female")
table(welfare_s$sex)
qplot(welfare_s$sex) #막대그래프

#변수 검토하기
class(welfare_s$income)
summary(welfare_s$income)
qplot(welfare_s$income) #default가 최댓값까지 보이도록 설정되어있음.
qplot(welfare_s$income) + xlim(0, 1000) #0~1000
summary(welfare_s$income) #min=0 : 직업이없다 -결측치처리.
#이상치 결측치 처리
welfare_s$income <- ifelse(welfare_s$income %in% c(0, 9999), NA, welfare_s$income)
#결측치 확인
table(is.na(welfare_s$income))

#성별 월급 평균표 만들기
sex_income <- welfare_s%>%              #성별별 평균수입을 나타냄
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))
#평균적으로 남성이 여성보다 월급이 약 150만원 더 많음.

#그래프 만들기
ggplot(data=sex_income, aes(x=sex, y=mean_income)) + geom_col()
