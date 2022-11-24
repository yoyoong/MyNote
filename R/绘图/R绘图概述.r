## 绘制一张空白图：plot()
plot(c(-3, 3), c(1, 5), type = "n", xlab = "x", ylab = "y") # 绘制x轴范围-3到3，y轴范围1到5的空白图
> x <- c(1, 2, 3)
> y <- c(1, 3, 8)
### 添加线段：abline()函数
> abline(c(0, 0), c(3, 3))
### 添加点：points()函数
> points(c(2, 5))
### 添加图例：legend()函数
### 添加文字：text()函数
> text(1.5, 5, "test")
### 精准定位：locator()函数
> hist(x) # 先绘制一个图形
> locator(1) # 弹出一个十字符，点击图形上的点，返回该点坐标
$x
[1] 1.681836
$y
[1] 0.5404975

### 定制图形
## 改变字符大小：cex选项
> text(1.5, 5, "test", cex = 1.5)
## 改变坐标轴的范围：xlim和ylim选项
## 添加多边形：polygon()函数
> polygon(c(1, 2, 2, 1), c(1, 1, 2, 2), col = "gray")
## 拟合散点：lowess()或loess()函数
lowess(data)
##### 绘制散点图以及拟合曲线
> plot(c(1, 2, 3), c(4, 5, 6))
> plot(c(1, 3), c(4, 6), type = "n")
> x <- c(1, 2, 3)
> y <- c(1, 3, 8)
> plot(x, y)
> lmout <- lm(y ~ x)
> abline(lmout)
## 绘制具有显式表达式的函数：curve()函数
> curve((x ^ 2 + 1) ^ 0.5, 0, 5, add = T) # add=T表示在现有图中添加这条曲线

##### 绘图设备控制：每做一张图，可以放到不同的窗口，有时候，明明代码运行了没有报错，但是右边plot一动不动，
##### 是因为我们的操作对象不是它，而是另外一张图，所以，我们要经常看看当前存在多少设备（devices），或称画布
dev.list() # 返回打开的设备的名单列表，但不包含空设备；
dev.off() # 关闭指定的设备（缺省情况下为当前设备）；当前设备被关闭后，若还有打开的设备，则紧接着的下一个打开的设备变为当前设备，返回新打开的活跃设备的名字和编号。
# 注意：设备1是不能被关闭的，即对设备1进行关闭操作是错误的；
graphics.off() # 关闭所有打开的设备；
dev.set() # 指定一个特定的设备为活跃设备，但若没有那个指定的设备，等同于dev.next();若指定设备的值为1，则打开一个新的设备，并且指定那个设备为活跃设备，返回新设备的名字和编号。
dev.new() # 打开一个新的设备。R中经常根据需要自动的打开新的设备，但也能使用跨平台的方式打开更多的设备；返回新设备的名字和编号。
dev.cur() # 查看当前的活跃设备；返回包含当前活跃设备的名字和编号的向量；如果是返回值是1,空设备，即没有活跃设备。
dev.next() # 查看紧随当前活跃进程的下一个进程；返回其名字和编号。
dev.prev() # 查看当前活跃进程的前一个进程；返回其名字和编号。

######## 将图形保存到文件
> pdf("plot.pdf") # 打开一个pdf文件
> dev.list() # RStudioGD图形窗口的设备编号为2，pdf文件的设备编号是3，当前活动的设备是该pdf文件，此时所有的图形输出都会被写入这一文件，而不是绘制在屏幕上
RStudioGD       png       pdf 
        2         3         4 
### 因此要想将图形保存到文件，只需建立一个pdf设备，然后将在屏幕上绘图的代码重新运行一遍
### 将当前显示的图形保存到文件的一个方法是：将当前屏幕重新设置为活动设备，然后将其内容复制到pdf设备中
> dev.set(2)
RStudioGD 
        2 
> dev.copy(which = 4)
pdf 
  4 
> dev.set(3)
png 
  3 
> dev.off() # 需要关闭pdf设备才能看到图形
pdf 
  4 

##### 绘制三维图形：使用lattice库
### 绘制曲面图：persp()和wireframe()函数
### 绘制三维散点图：cloud()函数

################################################################### ggplot2库 ###################################################################
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

##### ggplot2对分组数据进行排序：reorder()函数
> ggplot(data = mpg) + geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) + coord_flip() # 按中位数排序

##### 发现异常值：coord_cartesian()函数可将坐标轴某一位置附近的图放大，有助于发现少量异常值的存在
> ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5)
> ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.5) + coord_cartesian(ylim = c(0, 50)) # y轴的范围设置为0-50
################################################################### ggplot2库 ###################################################################