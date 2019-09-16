install.packages('XML')
library(XML)
# 대전시 도로교통
API_Key <- "HVecmOUPv4yHo5g463v3WEEwxrIUgVVVxVdO4D9gHY83tD7XHT8sV4gPndgsymu%2BdqwIauFP938rqdT8DeVfbw%3D%3D"

data=''
for(i in 1:100){
  url <- paste0("http://openapitraffic.daejeon.go.kr/traffic/rest/getTrafficInfoAll.do?ServiceKey=",API_Key,"&numOfRows=100&pageNo=",i)
  xmlfile <- xmlParse(url)
  #xmltop <- xmlRoot(xmlfile)
  df2 <- xmlToDataFrame(getNodeSet(xmlfile,"//TRAFFIC"))
  if(length(data)>0){
    data <- rbind(data,df)
  }
  else{data <- df}
}

## 미세먼지
API_Key <- "HVecmOUPv4yHo5g463v3WEEwxrIUgVVVxVdO4D9gHY83tD7XHT8sV4gPndgsymu%2BdqwIauFP938rqdT8DeVfbw%3D%3D"
url <- paste0("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=대전광역시&dataTerm=3MONTH&pageNo=1&numOfRows=20&ServiceKey=",API_Key
              ,"&ver=1.3")
xmlfile <- xmlParse(url)
xmltop <- xmlRoot(xmlfile)
xmltop

df1 <- xmlToDataFrame(getNodeSet(xmlfile,"//TRAFFIC"))
View(df1)


