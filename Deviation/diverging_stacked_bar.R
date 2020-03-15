# https://rpubs.com/tskam/likert
# https://luisdva.github.io/rstats/diverging-barplots/
# 原始数据，为了突出堆叠效果，增加了两行数据
# https://raw.githubusercontent.com/luisDVA/codeluis/master/contributions.csv

library(readr)
library(dplyr)
library(ggplot2)

data = read_csv("diverging/diverging_stacked_bar_data.csv") %>%
  mutate(contribution = round(contribution, 0))

ggplot(data, aes(x = fct_rev((fct_inorder(
  study
))), y = contribution, fill = contributor)) +
  geom_bar(stat = "identity",
           position = "identity",
           color = "dark grey") +
  coord_flip() + ylim(-50, 200) +
  geom_hline(yintercept = 0, color = c("white")) +
  #theme_flat() +
  xlab("study") + ylab("% contribution") +
  ggtitle("Contributors to Global Warming over the past 50-65 years") +
  scale_fill_manual(name = "", values = c("#FFA373", "#50486D")) +
  labs(caption = "reproduced from skepticalscience.com") +
  theme(text = element_text(family = "Roboto Medium"))