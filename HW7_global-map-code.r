############# data ##############
library(dplyr); library(rvest); library(stringr)
source("https://www.dropbox.com/s/4tubw8e5h3cem6w/theEconomist.R?dl=1")

"https://www.economist.com/the-world-this-week/2019/11/21/politics-this-week" %>%
  get_theWorldThisWeek() -> df_politics %>% View()

"https://www.economist.com/the-world-this-week/2019/11/21/business-this-week" %>%
  get_theWorldThisWeek() -> df_business

############# settings ##############
library(dplyr); library(stringr); library(ggplot2); library(plotly); library(lubridate); library(readr); library(tidyr); library(showtext)

#font_add("QYuan","cwTeXQYuan-Medium.ttf") # 新增字體
showtext_auto(enable=TRUE) #啟用字體
theme_set(theme_classic())
knitr::opts_chunk$set(out.width='80%', fig.asp=.75, fig.align='center', fig.showtext=T)
knitr::opts_chunk$set(echo = TRUE)

############# graph ##############
#Set country boundaries as light grey
l <- list(color = toRGB("#d1d1d1"), width = 0.5)
#Specify map projection and options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'orthographic'),
  resolution = '100',
  showcountries = TRUE,
  countrycolor = '#d1d1d1',
  showocean = TRUE,
  oceancolor = '#c9d2e0',
  showlakes = TRUE,
  lakecolor = '#99c0db',
  showrivers = TRUE,
  rivercolor = '#99c0db')

nations <- read_csv("C:/Users/linyi/Downloads/nations.csv", locale = locale(encoding = "BIG5"))

nations %>% 
  mutate(COUNTRY = as.factor(COUNTRY), ABBR.nation = as.factor(ABBR.nation)) %>% 
  filter(!is.na(content)) -> nations

nations %>% 
  mutate(
    簡述=c(
      "塔利班以恐怖分子交換人質",          #1
      "白俄羅斯反對派在議會無席次",          #2
      "玻利維亞鎮壓示威者",          #3
      "亞馬遜的森林遭濫砍程度日益增加",          #4
      "智利政府公投是否該制定新憲法",          #5
      "香港法院判定禁口罩令違反基本法",          #6
      "伊朗民眾示威抗議",          #7
      "美國承認以色列西岸所有權",          #8
      "駐韓美軍費用問題",          #9
      "布基納法索、馬里和尼日爾的軍事衝突影響人民生計",          #10
      "斯里蘭卡反恐行動",          #11
      "澳大利亞記者在倫敦被拘留 檢察官考慮將他引渡到美國",          #12
      "以色列攻擊伊朗",          #13
      "英國選舉辯論發生衝突",          #14
      "美國國會通過香港法案",          #15
      "彈劾川普的調查案進度",          #16
      "俄羅斯干預美國政治"          #17
    ),
    標籤=c(
      "軍事衝突",
      "國內事件",
      "死傷",
      "國際事件",
      "國內事件",
      "國內事件",
      "死傷",
      "國際事件",
      "國際事件",
      "軍事衝突",
      "死傷",
      "國際事件",
      "軍事衝突",
      "國內事件",
      "國際事件",
      "國際事件",
      "國際事件"
    )
  ) %>% mutate(簡述=as.factor(簡述),標籤=as.factor(標籤)) %>% mutate(分類 = c(1,2,3,4,2,2,3,4,4,1,3,4,1,2,4,4,4))-> nations


plot_geo(nations) %>% 
  add_trace(z= ~分類,color = ~分類, showscale = F, locations = ~ABBR.nation, marker = list(line = l), text = ~paste(簡述) )%>%   
  layout(title = '', geo = g) -> nations_plot

nations_plot


#Sys.setenv("plotly_username"="LINYICHI017")
#Sys.setenv("plotly_api_key"="tDaJHoOPyo3brquPJuLp")

#Sys.getenv("plotly_username")
#Sys.getenv("plotly_api_key")

#api_create(nations_plot,filename="nations_plot",fileopt="overwrite") -> Meta_pltly

pltly_nation <- api_download_plot("3","LINYICHI017")