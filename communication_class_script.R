library(tidyverse)
library(completejourney)
library(lubridate)
library(here)

campaign_descriptions %>%
  gather(start_date, end_date, key = campaign_event, value = date) ->
  campaign_descriptions_long

coupons %>%
  left_join(campaign_descriptions) %>%
  ggplot(aes(x = campaign_id, fill = campaign_type)) + 
  geom_bar()

campaign_descriptions_long %>%
  mutate(
    campaign_type = fct_collapse(
      campaign_type,
      "Purchase History" = "Type A",
      "Regular"          = c("Type B", "Type C")
    )
  ) ->
  campaign_descriptions_long

campaign_descriptions_long %>%
  ggplot(aes(x = date, y = campaign_id %>% fct_reorder(date, .fun = "min"))) + 
  geom_vline(xintercept = as.Date("2017-01-01"), size = 2, colour = "white") +
  geom_vline(xintercept = as.Date("2017-12-31"), size = 2, colour = "white") + 
  geom_line(size = 1.5, colour = "grey50") + 
  geom_point(aes(colour = campaign_type), size = 4) + 
  scale_x_date(
    date_breaks = "month",
    date_labels = 
  )
  #coord_cartesian(xlim = c(as.Date("2017-01-01"), as.Date("2017-12-31")))
