## 从技术上讲，列表就是向量。但向量是最小的，不可再分的，列表是递归型向量，列表的组件可以是列表

###### 列表基本操作
### 创建列表
> x <- list("Joe", 5000, T) # 不指定组件标签
> x
[[1]]
[1] "Joe"
[[2]]
[1] 5000
[[3]]
[1] TRUE
> x <- list(name = "Joe", salary = 5000, union = T) # 指定组件标签
> x
$name
[1] "Joe"
$salary
[1] 5000
$union
### 添加新组件，也可以使用索引添加新组件
> x$address <- "home"
### 删除组件，直接把其值设置为NULL即可
> x$union <- NULL
### 获取列表长度
> length(x)
[1] 3


## 获取列表组件值
[1] TRUE
> x$name # 根据标签获取组件值，也可以用x[["name"]]或x[[2]]
[1] "Joe"
> x$sal # 可以使用标签的前缀，一般都能识别
[1] 5000

## 获取子列表：使用[]获取子列表，使用[[]]获取的是列表的组件值（一次只能获取一个，不能用:）
> x[1:2]
$name
[1] "Joe"
$salary
[1] 5000

# names()函数：获取列表标签集
> names(x)
[1] "name"    "salary"  "address"
> xun <- unname(x) # 去掉列表标签值

## unlist()函数：获取列表的值，返回的是一个向量
> unlist(x)
   name  salary address 
  "Joe"  "5000"  "home" 
> unlist(x)[1]
 name 
"Joe" 

##### 在列表上使用apply系列函数（包括lapply()和sapply()函数）
> x = list(1:3, 2:5)
> lapply(x, median) # 分别对列表的两个向量求中位数，返回一个列表
[[1]]
[1] 2
[[2]]
[1] 3.5
> sapply(x, median) # 返回一个矩阵或向量
[1] 2.0 3.5

