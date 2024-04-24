if(!require(dplyr)) {install.packages("dplyr"); library(dplyr)}
if(!require(ggplot2)) {install.packages("ggplot2"); library(ggplot2)}
if(!require(ggrepel)) {install.packages("ggrepel"); library(ggrepel)}
options(scipen = 999)
osso <- read.csv('외식산업.csv')
osso %>% filter(항목 == "매출액") -> 매출


매출$num <- format(매출$수,big.mark=",")

ggplot(매출, aes(x = 연도))+geom_bar(aes(y = 수,fill = 산업별),stat = 'identity',position = position_dodge(0.5),width=0.4)+ggtitle("산업별 매출액수")+geom_text(aes(y = 수,label = num),vjust=-0.5 )

# 상관관계
del <- read.csv("delivery2.csv", fileEncoding = "euc-kr")
del

del %>% group_by(연도) %>% summarise(n = sum(이용여부))-> delivery
osso %>% filter(산업별 == "음식점 및 주점업"&항목 == '매출액') %>% select(연도, 수)%>% group_by(연도) -> sales

cor(sales$수, delivery$n)