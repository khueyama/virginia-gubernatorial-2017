library(tidyverse)

# function to read results by year
read_results <- function(year, office) {
  stub <- 'https://apps.elections.virginia.gov/SBE_CSV/ELECTIONS/ELECTIONRESULTS/%i/%i November General.csv'
  url <- sprintf(stub, year, year)
  url <- gsub(' ', '%20', url)
  
  df <- read_csv(url) %>%
    filter(OfficeTitle == office) %>%
    filter(Party %in% c('Democratic', 'Republican')) %>%
    select(locality = LocalityName,
           party = Party,
           votes = TOTAL_VOTES) %>%
    group_by(locality, party) %>%
    summarise(votes = sum(votes, na.rm = TRUE)) %>%
    mutate(year = year,
           total = sum(votes),
           percent = votes/total) %>%
    filter(party == 'Democratic')

  df
}

# load results data
df_results <- read_results(2016, 'President and Vice President') %>%
  bind_rows(read_results(2013, 'Governor'))
  
# save results data
save(df_results, file = 'data/df_results.Rdata')

# function to read registered voters by year and month
read_registered <- function(year, month) {
  stub <- 'https://www.elections.virginia.gov/Files/Registration-Statistics/%s/%s/Registrant_Count_By_Locality.csv'
  url <- sprintf(stub, year, month)
  
  df <- read_csv(url) %>%
    select(locality = Locality,
           active = ActiveVoters) %>%
    mutate(locality = substring(locality, 15)) %>%
    group_by(locality) %>%
    summarise(active = sum(active, na.rm = TRUE))
  
  df
}

# load registered data
df_registered <- read_registered('2017', '09')

# save registered data
save(df_registered, file = 'data/df_registered.Rdata')
