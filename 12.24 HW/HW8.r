library(ggplot2)


######## movie #########

movie <- data.frame(時間點=rep(c("11/03", "11/04", "11/05", "11/06", "11/07", "11/08"),each=3),
                  類別=rep(c("海報", "臉書", "網站"),6),
                  點擊次數=c(7, 6, 6, 10, 8, 8,
                        10, 8, 8, 10, 12, 16,
                        10, 15, 18, 10, 16, 19))

  # drawing the plot of frequency
movieplot <- ggplot(data=movie, aes(x=時間點, y=點擊次數, fill=類別)) +
  geom_bar(stat="identity", color="grey",position=position_dodge(), width = 0.6) + 
  geom_hline(yintercept=15, color='coral', linetype="dashed", size=1.2) + 
  scale_fill_manual(values=c("海報" = "#00CC00", "臉書" = "orange", "網站" = "coral")) + 
  theme_classic()

movieplot

# sum the views by different srcs
agg.movie <- aggregate(movie$點擊次數, by = list(Category = movie$類別), FUN = sum)

agg.movie[1, 2]

######## toy #########

toy <- data.frame(時間點=rep(c("10/09","11/18", "11/19", "11/20", "11/21", "11/22", "11/23", "11/27"),each=3),
                       類別=rep(c("海報", "臉書", "網站"),8),
                       點擊次數=c(0,0,4,
                              3,2,4,
                              9,8,13,
                              15,12,19,
                              19,15,22,
                              26,25,32,
                              28,30,37,
                              28,34,37))

# drawing the plot of frequency
toyplot <- ggplot(data=toy, aes(x=時間點, y=點擊次數, fill=類別)) +
  geom_bar(stat="identity", color="grey",position=position_dodge(), width = 0.6) + 
  geom_hline(yintercept=15, color='#0066FF', linetype="dashed", size=1.2) + 
  scale_fill_manual(values=c("海報" = "#00CC00", "臉書" = "orange", "網站" = "coral")) + 
  theme_classic()

toyplot

# sum the views by different srcs
agg.toy <- aggregate(toy$點擊次數, by = list(Category = toy$類別), FUN = sum)

agg.toy

######## Xmas #########

xmas <- data.frame(時間點=rep(c("12/16","12/17","12/18"),each=3),
                     類別=rep(c("海報", "臉書", "網站"),3),
                     點擊次數=c(6,3,5,
                            14,12,14,
                            14,14,15))

# drawing the plot of frequency
xmasplot <- ggplot(data=xmas, aes(x=時間點, y=點擊次數, fill=類別)) +
  geom_bar(stat="identity", color="grey",position=position_dodge(), width = 0.6) + 
  geom_hline(yintercept=15, color='#00cc66', linetype="dashed", size=1.2) + 
  scale_fill_manual(values=c("海報" = "#00CC00", "臉書" = "orange", "網站" = "coral")) + 
  theme_classic()

xmasplot

# sum the views by different srcs
agg.xmas <- aggregate(xmas$點擊次數, by = list(Category = xmas$類別), FUN = sum)

agg.xmas
