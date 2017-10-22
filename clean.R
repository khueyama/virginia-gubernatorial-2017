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
    filter(party == 'Democratic') %>%
    select(locality, year, percent)
  
  df
}

# load data
dta <- read_results(2016, 'President and Vice President') %>%
  bind_rows(read_results(2013, 'Governor'))
  
# save
save(dta, file = 'dta.Rdata')
