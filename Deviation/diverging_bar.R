# https://nhsrcommunity.com/blog/diverging-bar-charts-plotting-variance-with-ggplot2/
# https://stackoverflow.com/questions/49290010/how-to-part-diverging-bar-plots-in-r

library(ggplot2)
library(dplyr)
theme_set(theme_classic())
data("mtcars")

mtcars$CarBrand = rownames(mtcars)
mtcars$mgp_z_score = round((mtcars$mpg - mean(mtcars$mpg)) / sd(mtcars$mpg), digits = 2)

# 按原文操作报错，直接用mutate代替了
#mtcars$mpg_type = ifelse(mtcars$mpg_z_score < 0, "below", "above")
mtcars %>%
  mutate(mgp_type = ifelse(mgp_z_score < 0, "below", "above")) %>%
  arrange(mgp_z_score) -> mtcars

# 这里是对数据进行升序排列的，但提示mtcars$mgp_z_score不是vector...
# 在上面用arrange函数替代
#mtcars = mtcars[order(mtcars$mgp_z_score),]

mtcars$CarBrand = factor(mtcars$CarBrand, levels = mtcars$CarBrand)

ggplot(mtcars, aes(x = CarBrand, y = mgp_z_score, lable = mgp_z_score)) +
  geom_bar(stat = 'identity', aes(fill = mgp_type)) +
  # 对图形进行手动的填充
  scale_fill_manual(
    name = "Mileage (deviation)",
    labels = c("Above Average", "Below Average"),
    values = c("above" = "#00ba38", "below" = "#0b8fd3")
  ) +
  # 保留作者信息
  labs(subtitle = "Z score (normalised) mileage for mtcars'",
       title = "Diverging Bar Plot (ggplot2)",
       caption = "Produced by Gary Hutson")+
  coord_flip()