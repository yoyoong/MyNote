## S3类：R中原始的类结构，包含一个列表，再加上一个类名属性和调度的功能
## S3泛型函数：具有多态性的函数称为泛型函数，如print()和plot()。简单来说，泛型函数可以根据不同的对象调用不同的方法，如print()根据打印对象用不同的格式打印出来
## methods()函数：找到给定泛型函数的所有实现方法
> methods(plot) ## plot()函数的所有实现方法
 [1] plot.acf*           plot.data.frame*    plot.decomposed.ts* plot.default        plot.dendrogram*   
 [6] plot.density*       plot.ecdf           plot.factor*        plot.formula*       plot.function      
[11] plot.hclust*        plot.histogram*     plot.HoltWinters*   plot.isoreg*        plot.lm*           
[16] plot.medpolish*     plot.mlm*           plot.ppr*           plot.prcomp*        plot.princomp*     
[21] plot.profile.nls*   plot.raster*        plot.spec*          plot.stepfun        plot.stl*          
[26] plot.table*         plot.ts             plot.tskernel*      plot.TukeyHSD*     
see '?methods' for accessing help and source code
> methods(class = "default") # 查看所有的泛型函数


########## 编写S3类
### 定义类：在构造函数的代码中隐式定义
### 创建对象：创建列表，设置类属性
### 引用成员变量：$
### 实现泛型函数f()：定义f.classname()
### 声明泛型函数：UseMethod()
> j <- list(name = "hyy", salary = 50000, union = T) # 定义一个类结构
> class(j) <- "employee" # 定义该对象的类名
> attributes(j) # 查看该对象的内容
$names
[1] "name"   "salary" "union" 
$class
[1] "employee"
> j # 调用默认的print(j)
$name
[1] "hyy"
$salary
[1] 50000
$union
[1] TRUE
attr(,"class")
[1] "employee"
> print.employee <- function(value) { # 重写employee类的打印方法
+ cat(value$name, value$salary, value$union)
+ }
> j
hyy 50000 TRUE

##### 使用继承
> k <- list(name = "hyy", salary = 50000, union = T, hours = 100) # 定义一个新类结构
> class(k) <- c("hourEmployee", "employee") # hourEmployee类作为employee的子类
> k
hyy 50000 TRUE


##### 编写S4类
### 定义类：setClass()
### 创建对象：new()
### 引用成员变量：@
### 实现泛型函数f()：setMethod()
### 声明泛型函数：setGeneric()
> setClass("employee", representation(name = "character", salary = "numeric", union = "logical")) # 定义一个employee类
> hyy <- new("employee", name = "hyy", salary = 50000, union = T) # 给employee类创建一个实例
> hyy # 实际上调用了S4类的打印函数show()
An object of class "employee"
Slot "name":
[1] "hyy"
Slot "salary":
[1] 50000
Slot "union":
[1] TRUE
> hyy@salary # 获取成员变量
[1] 50000
> slot(hyy, "union") # 使用slot获取成员变量
[1] TRUE
## S4类的优点在于其安全性，比如不小心把salary拼错成salry，S4类会报错，S3类不会有任何报错。S3类仅仅是列表，可以随时添加新的组件，不管是有意还是无意
> hyy@salry <- 60000
Error in (function (cl, name, valueClass)  : 
  ‘salry’不是在“employee”类别里的槽

##### 在S4类上实现泛型函数
> setMethod("show", "employee", function(object) cat(object@name, object@salary, object@union)) # function里面的变量一定要是object
> hyy
hyy 50000 TRUE

##### 对象管理
## 查看所有对象：ls()
## 查看对象的更多信息: ls.str()
# 删除特定对象：rm(object)
## 保存对象集合：save(object, filename)
## 恢复save()保存的对象：load(filename)
### 查看对象内部结构：class(object)、mode(object)、names(object)、attributes(object)、unclass(object)、str(object)
##### 在文本编辑器中浏览对象代码:edit(object)
## 查看对象是否存在：exists(object)