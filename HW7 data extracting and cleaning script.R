# HW 7 global data retrieval

library(tidyverse)

# importing a dataset with country names all around the globe
global <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')

head(global)

# delete unused variables and rename a better name
global <- global %>% 
  select(-GDP..BILLIONS.) %>%
  rename(ABBR.nation = CODE)

# write.csv(global, file = "data/nations.csv")

# Bind the df_politics with the global country name dataset for later drawing
pol <- read.csv("data/politics_this_week.csv")
head(pol)

global$COUNTRY <- as.character(global$COUNTRY)
pol$COUNTRY <- as.character(pol$COUNTRY)

world <- full_join(global, pol, by = "COUNTRY")

# world %>% View

world <- world %>% select(-X)

# write.csv(world, file = "data/nations.csv")

## 3 United States because of 3 distinct US newstories, needs adjustment

################## Attempt of webscrap the URL link for the distinct articles ######################3

web <- read_html("https://www.economist.com/the-world-this-week/2019/11/21/politics-this-week")

url.link <- web %>%
  html_nodes(".blog-post__text a") %>%
  html_attr("href") %>%
  as.data.frame(stringsAsFactors = T)

# url.link %>% View  # success

url.link$COUNTRY <- c("Sri Lanka", "Hong Kong", "Korea, South", 
                      "United States", "Iran", "Israel", "Brazil", 
                      "Chile", "United Kingdom")

chartofnews <- full_join(pol, url.link, by = "COUNTRY")

# cleanup the unwanted variables
names(chartofnews)

chartofnews <- chartofnews %>%
  rename(chartofnews, Link_to_Article = .) %>%
  dplyr::select(-c(X, content, identities)) %>%
  dplyr::mutate(Link_to_Article = as.character(Link_to_Article))

# fill in the NAs of Links with the `Politics this Week` URL
for(i in 1:nrow(chartofnews)){
  if(is.na(chartofnews$Link_to_Article[[i]])){
    chartofnews$Link_to_Article[[i]] <-  "https://www.economist.com/the-world-this-week/2019/11/21/politics-this-week"
  } else{
  }
}


# add in a new variable of link_title
chartofnews <- chartofnews %>% 
  mutate(link_title = substring(chartofnews$Link_to_Article,
                                regexpr("11/", chartofnews$Link_to_Article) + 6) %>%
           gsub(pattern = "-", replacement = " "))


 write.csv(chartofnews, file = "data/chartofnews.csv")


############################# Make the table with kable ####################

## Caution! Don't run this with R script
  ## This is a Rmarkdown code chunk (Supposed to ...)

```{r}

table <- chartofnews %>% 
  mutate(`Link to Article` = paste0("<a href=\"", `Link to Article`, "\">",
                                    link_title, "</a>")) %>%
  dplyr::select(COUNTRY, `Link to Article`) %>%
  dplyr::rename(Country = COUNTRY)

table %>% knitr::kable(format = "html", escape = F)

#  kableExtra::kable_styling(bootstrap_options = c("hover", "condensed"))
```

################## Get the KAL's Cartoon picture #######################

KAl.web <- read_html("https://www.economist.com/the-world-this-week/2019/11/21/kals-cartoon")

# Extract the source of the KAL Cartoon picture
KAL <- html_nodes(KAl.web, ".blog-post__image-block") %>%
  html_attr(name = "src")

