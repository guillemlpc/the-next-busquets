# In this file I'll load all my data and transform it a little. Let's begin
# importing some libraries
library(dplyr)

# First I'll load all my data from the csv files downloaded from FBREF website:
passing <- read.csv('data/Passing_top5.csv')
defensive <- read.csv('data/Defensive_top5.csv')
gca <- read.csv('data/Goalshotcreation_top5.csv')
misc <- read.csv('data/Misc_top5.csv')
passtypes <- read.csv('data/Passtypes_top5.csv')
possession <- read.csv('data/Possession_top5.csv')
shooting <- read.csv('data/Shooting_top5.csv')

# Now I take all the columns I want and form a DataFrame:
all <- data.frame(passing$Player, passing$Pos, passing$Squad, passing$Comp,
                  passing$X90s, passing$Cmp., passing$xA, passing$Prog,
                  passing$PrgDist, passing$KP, passing$X1.3, passtypes$Press,
                  gca$SCA90, defensive$TklW, defensive$Press, defensive$Succ,
                  defensive$Int, defensive$Clr, defensive$Blocks,
                  defensive$Tkl.1, possession$Touches, possession$Mid.3rd,
                  possession$Carries, possession$Succ., misc$Won, shooting$G.Sh) %>%
  dplyr::filter(passing$Pos == "MF", passing$X90s > 15)

#Before exporting, I'll rename the columns for easier understanding
names(all)[1] <- 'Player'
names(all)[2] <- 'Position'
names(all)[3] <- 'Squad'
names(all)[4] <- 'Competition'
names(all)[5] <- '90s'
names(all)[6] <- 'PCmp'
names(all)[7] <- 'xA'
names(all)[8] <- 'ProgP'
names(all)[9] <- 'PrgDist'
names(all)[10] <- 'KP'
names(all)[11] <- 'FinalThird'
names(all)[12] <- 'UPress'
names(all)[13] <- 'SCA90'
names(all)[14] <- 'TklW'
names(all)[15] <- 'Pressures'
names(all)[16] <- 'Press%'
names(all)[17] <- 'Int'
names(all)[18] <- 'Clr'
names(all)[19] <- 'Blocks'
names(all)[20] <- 'DribTkl'
names(all)[21] <- 'Touches'
names(all)[22] <- 'TouchesMid'
names(all)[23] <- 'Carries'
names(all)[24] <- 'Drib%'
names(all)[25] <- 'AWon'
names(all)[26] <- 'GpSh'

# Let's export the DataFrame into a CSV file for further exploring
write.csv(all, "data/all_mf.csv")
