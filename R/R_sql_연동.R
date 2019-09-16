install.packages('DBI')
install.packages('RJDBC')
install.packages('rJava')
library(DBI)
library(RJDBC) #rJava보다 먼저 라이브러리 돼야함
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_211')
library(rJava)

drv <- JDBC( driverClass = "oracle.jdbc.driver.OracleDriver",
             classPath = "C:/app/mydus/product/11.2.0/dbhome_1/jdbc/lib/ojdbc6.jar")
conn <- dbConnect( drv, 'jdbc:oracle:thin:@//localhost:1521/orcl', 'scott', 'tiger')
rst <- dbGetQuery( conn, 'SELECT purpose, COUNT(*) FROM cctv_tbl GROUP BY purpose')

str( rst )
dim( rst )
head( rst )
tail( rst )
View( rst )

