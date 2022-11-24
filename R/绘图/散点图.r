########### ggplot绘制散点图：geom_point()函数
geom_point(
  mapping = NULL, # 映射集合，由aes()函数创建
  data = NULL, # 数据集
  stat = "identity",
  position = "identity", # 位置调整方式，默认为identity，其他可选值为jitter（为每个数据点添加一个很小的随机扰动，可将四舍五入后重叠的点分散开来）
  ..., # 其他参数，如设置数据点的大小（size）、形状（shape）、边框颜色（color）、填充颜色（fill）、透明度（alpha）等
  na.rm = FALSE, # 去除空值
  show.legend = NA,
  inherit.aes = TRUE
)

##### 设置数据点属性
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), size = 5)
> ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price), alpha = 0.1) # 散点数量特别多时，可设置透明度使图形更清晰
### 数据点的形状是一个数值，取值范围从0到24以及*.+-/|%#等，其中15-20为实心形状，21-24为填充形状（边界颜色由color决定，填充颜色由fill决定）
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), shape = 21, color = "blue", fill = "blue") # 蓝色实心圆点

##### 向二维散点图中添加第三个变量，如汽车类型（class），将其映射为图形属性
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class)) # 映射为颜色
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class)) # 映射为大小
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class)) # 映射为透明度
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class)) # 映射为形状（只能同时使用6种情况，多出的变量将不会出现在图中）

##### 对于数据量特别大的散点图无法清晰看到所有点分布时，可使用geom_bin2d()和geom_hex()函数在两个维度上进行分箱（把一个区域内的数量通过颜色展示出来）
##### geom_bin2d()创建长方形分箱；geom_hex()创建六边形分箱（需要安装hexbin包）
> ggplot(data = diamonds) + geom_bin2d(mapping = aes(x = carat, y = price))