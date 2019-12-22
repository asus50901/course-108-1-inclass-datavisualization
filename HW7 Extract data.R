library(dplyr); library(rvest); library(stringr)
source("https://www.dropbox.com/s/4tubw8e5h3cem6w/theEconomist.R?dl=1")

"https://www.economist.com/the-world-this-week/2019/11/21/politics-this-week" %>%
  get_theWorldThisWeek() -> df_politics

"https://www.economist.com/the-world-this-week/2019/11/21/business-this-week" %>%
  get_theWorldThisWeek() -> df_business

df_business %>% View

df_politics %>% View

write.csv(df_politics, file = "data/df_politics.csv")

write.csv(df_business, file = "data/df_business.csv")

View(get_theWorldThisWeek)
