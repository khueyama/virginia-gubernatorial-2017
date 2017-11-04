# load data
load('data/df_results.Rdata')
load('data/df_registered.Rdata')

# combine df
df <- df_results %>% 
  select(locality, year, percent) %>% 
  spread(year, percent) %>%
  left_join(df_registered)

# 2013 vs 2016
ggplot(df, aes(`2013`, `2016`, size = active, color = `2016` - `2013`)) +
  geom_point() +
  scale_color_gradient2() +
  geom_abline() +
  scale_x_continuous(limit = c(0, 1), labels = scales::percent) +
  scale_y_continuous(limit = c(0, 1), labels = scales::percent) +
  theme_minimal() +
  theme(legend.position="none") +
  labs(title = 'Democratic Two-Party Vote Share', 
       x = "2013 Gubernatorial",
       y = "2016 Presidential",
       caption = "Data via Virginia Department of Elections")
  
ggsave("img/2013_2016.png")

# 2016 vs 2017
ggplot(df, aes(`2016`, `2017`, size = active, color = `2017` - `2016`)) +
  geom_point() +
  scale_color_gradient2() +
  geom_abline() +
  scale_x_continuous(limit = c(0, 1), labels = scales::percent) +
  scale_y_continuous(limit = c(0, 1), labels = scales::percent) +
  theme_minimal() +
  theme(legend.position="none") +
  labs(title = 'Democratic Two-Party Vote Share', 
       x = "2016 Presidential",
       y = "2017 Gubernatorial",
       caption = "Data via Virginia Department of Elections")

ggsave("img/2016_2017.png")

# 2013 vs 2017
ggplot(df, aes(`2013`, `2017`, size = active, color = `2017` - `2013`)) +
  geom_point() +
  scale_color_gradient2() +
  geom_abline() +
  scale_x_continuous(limit = c(0, 1), labels = scales::percent) +
  scale_y_continuous(limit = c(0, 1), labels = scales::percent) +
  theme_minimal() +
  theme(legend.position="none") +
  labs(title = 'Democratic Two-Party Vote Share', 
       x = "2013 Gubernatorial",
       y = "2017 Gubernatorial",
       caption = "Data via Virginia Department of Elections")

ggsave("img/2013_2017.png")