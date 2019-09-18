
# Please open with encoding UTF-8

library(dplyr); library(stringr); library(ggplot2); library(plotly); library(lubridate); 
library(readr); library(tidyr); library(showtext)


## Get transcriptDataFinal

load(url("https://www.dropbox.com/s/duh5aaqgl2f5m3z/loopTranscriptData.Rda?raw=1"))


# 計算每位學生每個學期的平均成績
transcriptDataFinal %>%
  group_by(學號,學年,學期) %>%
  dplyr::summarise(
    平均成績=sum(學期成績*學分數)/sum(學分數)
  )


#計算每位學生每學期學分數在必/選/通 三類的學分數比重。

transcriptDataFinal %>%
  group_by(學號,學年,學期) %>%
  summarise(必修比重 = sum((`必選修類別（必∕選∕通）` == "必")*學分數) / sum(學分數),
            選修比重 = sum((`必選修類別（必∕選∕通）` == "選")*學分數) / sum(學分數),
            通識比重 = sum((`必選修類別（必∕選∕通）` == "通")*學分數) / sum(學分數))

#學屆為100（即100學年入學）的學生，各系學生在學所修總學分數之中位數，何系最高？


target <-  transcriptDataFinal %>% 
  filter(學屆 == 100) %>%
  group_by(學系, 學號) %>% 
  summarise(學分數總數 = sum(學分數)) %>%
  ungroup() %>%
  group_by(學系) %>%
  summarise(學分總數中位數 = median(學分數總數))

target[which.max(target$學分總數中位數), ]


