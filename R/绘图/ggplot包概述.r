##### ggplot2介绍：一张统计图形就是从数据到几何对象(geometric object, 缩写为geom, 包括点、线、条形等)的图形属性(aesthetic attributes, 缩写为aes, 包括颜色、形状、大小等)的一个映射。此外, 图形中还可能包含数据的统计变换(statistical transformation, 缩写为stats), 最后绘制在某个特定的坐标系(coordinate system, 缩写为coord)中, 而分面(facet, 指将绘图窗口划分为若干个子窗口)则可以用来生成数据中不同子集的图形。

########## ggplot2的基本要素
##### 数据data和映射mapping：将数据中的变量映射到图形属性，映射控制了两者之间关系。aes()函数是ggplot2中的映射函数。
##### 标度scale：标度负责控制映射后图形属性的显示方式。具体形式上来看是图例和坐标刻度。
##### 几何对象geom：几何对象代表我们在图中实际看到的图形元素，如点、线、多边形等。通过”+”以图层的方式加入点的几何对象,例如对二元散点图加上一条回归线。
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + geom_smooth(mapping = aes(x = displ, y = hwy)) # 添加一条平滑曲线拟合散点图
> ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth() # 功能同上,使用全局映射而不是局部映射
##### 统计变换stats：绘图时用来计算新数据的算法。ggplot2提供了20多个统计变换，每个统计变换都是一个函数，例如?geom_bar显示出stat的默认值是count，这说明geom_bar()使用stat_count()函数进行统计变换。
> ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
> ggplot(data = diamonds) + stat_count(mapping = aes(x = cut)) # 通常来说，几何对象函数和统计变换函数可以互换使用
> ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1)) # 修改统计变换方法为prop（按比例展示）
##### 坐标系统coord：坐标系统控制坐标轴幵影响所有图形元素，坐标轴可以进行变换以满足不同的需要。
> ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot() # 默认的坐标系是笛卡儿直角坐标系
> ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot() + coord_flip() # coord_flip()函数可交换x轴和y轴。可用于绘制水平箱线图，也用于x轴标签过长的图
# coord_quickmap()函数可以为地图设置合适的纵横比
# coord_polar()函数使用极坐标系
##### 图层layer：数据、映射、几何对象、统计变换等构成一个图层。图层可以允许用户一步步的构建图形，方便单独对图层进行修改。
> ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth() # 单独对散点图图层添加分组
##### 分面facet：条件绘图，将数据按某种方式分组，然后分别绘图。通过facet_wrap()或facet_grid()函数进行分面。
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2) # 通过单变量进行分面
> ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl) # 通过两个变量进行分面
##### 主题theme：theme()函数中的选项可以调整字体、背景、颜色、网格线。
##### 存储和输出：ggsave()函数
> ggsave(fil e= "mygraph.png", plot=  myplot, width = 5, height = 4)

##### ggplot2绘图模板：ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>), stat = <STAT>, position = <POSITION>) + <COORDINATE_FUNCTION> + <FACET_FUNCTION>
### 其中，<DATA>为数据集，<GEOM_FUNCTION>为几何对象函数，<MAPPINGS>为映射集合，<STAT>为统计变换算法，<POSITION>为位置调整方式，COORDINATE_FUNCTION为坐标轴转换函数，<FACET_FUNCTION>为分面函数
# 也可去掉参数名，如下面两个语句效果一样
> ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
> ggplot(diamonds) + geom_bar(aes(cut))


##### 图形添加标签
> ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) + geom_smooth(se = FALSE) +
+     labs(title = "Fuel efficiency generally decreases with engine size", # 添加标题
+          subtitle = "Two seaters (sports cars) are an exception because of their light weight", # 添加子标题
+          caption = "Data from fueleconomy.gov") # 右下角添加文本（常用于描述数据来源）
> ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) + geom_smooth(se = FALSE) +
+     labs(x = "Engine displacement (L)",  y = "Highway fuel economy (mpg)", # 坐标轴标题
+          colour = "Car type") # 图例标题
##### 在图形中添加注释
> best_in_class <- mpg %>% group_by(class) %>% filter(row_number(desc(hwy)) == 1) # 使用dplyr选取出每类汽车中效率最高的型号
> ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
+     geom_text(aes(label = model), data = best_in_class) # 标记效率最高的型号
> ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) +
+     geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5) # 为文本加上方框，nudge_y参数让标签位于相应数据点的正上方
### 使用由ggrepel包自动调整标签的位置，使它们免于重叠
> ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class)) + 
+     geom_point(size = 3, shape = 1, data = best_in_class) +
+     ggrepel::geom_label_repel(aes(label = model), data = best_in_class)  # 还用较大的空心圆来强调添加了标签的数据点
### 将标签直接放在图形上以替代图例
> class_avg <- mpg %>% group_by(class) %>% summarize(displ = median(displ), hwy = median(hwy)) # 计算每组数据的中心点
> ggplot(mpg, aes(displ, hwy, color = class)) +
+  ggrepel::geom_label_repel(aes(label = class), data = class_avg, size = 6, label.size = 0, segment.color = NA) +
+  geom_point() + theme(legend.position = "none") # 不显示图例
### 向图中任意位置添加自定义标签
> label <- tibble(displ = max(displ), hwy = max(hwy), # 定义标签的位置（如果想让标签紧贴着图形边界，可以使用+Inf和-Inf值）
+  label = "Increasing engine size is \nrelated to decreasing fuel economy.") # 定义标签的显示字符
> ggplot(mpg, aes(displ, hwy)) + geom_point() +
+  geom_text(aes(label = label), data = label, vjust = "top", hjust = "right") # hjust和vjust用于控制标签的对齐方式
### 添加其他注释
# geom_hline()和geom_vline()函数：添加参考线
# geom_rect()函数：在感兴趣的数据点周围绘制一个矩形，矩形的边界由图形属性xmin、xmax、ymin和ymax确定
# geom_segment()函数及arrow参数：绘制箭头，指向需要关注的数据点。使用图形属性x和y来定义开始位置，使用xend和yend来定义结束位置

##### ggplot2对分组数据进行排序：reorder()函数
> ggplot(data = mpg) + geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) + coord_flip() # 按中位数排序

##### 发现异常值：coord_cartesian()函数可将坐标轴某一位置附近的图放大，有助于发现少量异常值的存在
> ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)
> ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5) + coord_cartesian(ylim = c(0, 50)) # y轴的范围设置为0-50