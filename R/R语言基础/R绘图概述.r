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
##### 保存为image格式：以png格式为例，此外类似的方法还有jpeg()，bmp()，tiff()，pdf()，svg()
png(filename = "name.png", width = 1200, height = 1200, units = "px", bg = "white", res = 100) # 创建画布
plot(1:5) # 绘图
dev.off() # 关闭画布
##### 保存为pdf格式
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