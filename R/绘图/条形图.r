########### ggplot绘制条形图：geom_point()或geom_col()或stat_count()函数
geom_bar(
  mapping = NULL,
  data = NULL,
  stat = "count",
  position = "stack", # 位置调整方式，默认为stack（各组堆叠），其他可选值为identity、fill（堆叠，但所有条形高度相同，展示各组占比）和dodge（各组平放）
  ..., # 其他参数，如设置条形的大小（size）、形状（shape）、边框颜色（color）、填充颜色（fill）、透明度（alpha）等
  just = 0.5, # 横轴坐标的位置在条形的位置，0.5表示在中间，0.1表示在从条形图左边开始的1/10处（相当于条形右移了0.4个条形宽度）
  width = NULL,
  na.rm = FALSE,
  orientation = NA,
  show.legend = NA,
  inherit.aes = TRUE
)
geom_col(mapping = NULL, data = NULL, position = "stack", ..., just = 0.5, width = NULL, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE)
stat_count(mapping = NULL, data = NULL, geom = "bar", position = "stack", ..., width = NULL, na.rm = FALSE, orientation = NA, show.legend = NA, inherit.aes = TRUE)

##### 设置条形属性
> ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = cut)) # 每个条形填充不同的颜色
> ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity)) # 将fill图形属性映射到另一个变量，条形会自动分块堆叠起来，每个彩色矩形表示cut和clarity的一种组合。
