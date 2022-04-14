txhousing
top<-txhousing %>% 
  count(sales,sort = TRUE) %>% 
  slice(1:5) %>% 
  pull(sales)

top


t<-sum(sales)
txhousing$city(t)
t
describe(txhousing$sales,txhousing$city, na.rm = TRUE)
sum(txhousing$sales ~ txhousing$city, na.rm = TRUE)

etape1 <- tapply(txhousing$sales, txhousing$city,sum)
etape2 <- sort(etape1, decreasing = TRUE)
etape3 <- etape2 [1:5]
etape3


top_5 <- txhousing[txhousing, which = c("Houston","Dallas","Austin","San Antonio", "Collin County"),] 

top_5 = txhousing[txhousing$city == "Houston",]
top_5
