load('data/df_results.Rdata')
load('data/df_registered.Rdata')

df <- df_results %>% 
  select(locality, year, percent) %>% 
  spread(year, percent) %>%
  left_join(df_registered)

ggplot(df, aes(`2013`, `2016`, size = active, color = `2016` - `2013`)) +
  geom_point() +
  scale_color_gradient2() +
  geom_abline() +
  scale_x_continuous(limit = c(0, 1), labels = scales::percent) +
  scale_y_continuous(limit = c(0, 1), labels = scales::percent) +
  theme_minimal() +
  theme(legend.position="none") +
  labs(title = 'Democratic Two-Party Vote Share', 
          subtitle = '2016 vs 2013 General Election',
          caption = "Data via Virginia Department of Elections")
  
ggsave("img/2013_2016.png")