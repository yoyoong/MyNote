##### 循环：可使用for、while和repeat结构进行循环，也支持break跳出循环
#### next语句跳过本次迭代的剩余部分，直接进入循环的下一次迭代
### repeat没有逻辑判断退出条件，必须使用break或next

### 对非向量集合（如列表）的循环，可使用lapply()或get()函数
## lapply函数：如果循环的每次迭代之间相互独立，可使用lapply分别迭代
## get()函数：接受一个代表对象名字的字符串参数，返回该对象的内容。假设u和v分别是一个列表
for(m in c("u", "v")) {
    z <- get(m)
    print(lm(z[, 2] ~ z[, 1]))
}

##### if-else结构：可写在同一行，类似于java的?:
> x <- 2
> y <- if(x == 1) x else x + 1
> y
[1] 3

## 返回值：语法为return()，注意返回值在括号里面。也可以直接把需要返回的值放在最后作为单独一行，避免显式调用return()？
> x <- 2
> f <- function(x) return(x + 1)
> f(x)
[1] 3
> f <- function(x) x + 1
> f(x)
[1] 3


##### 函数
## 环境层次中的某一层次对其上级层次的所有变量至少有读的权限，还可以使用超赋值运算符<<-或者函数assign()对上级变量进行写操作
## 闭包：包含函数的参数、函数体以及调用时的环境
> addOne <- function() {
+     ctr <- 0
+     f <- function() {
+         ctr <<- ctr + 1
+         cat("this count current value is: ", ctr, "\n")
+     }
+     return(f)
+ }
> a1 <- addOne()
> a2 <- addOne()
> a1() # 每次调用，ctr都会在不同的环境生成独立的物理地址
this count current value is:  1 
> a2()
this count current value is:  1 
> a1()
this count current value is:  2 
> a1()
this count current value is:  3 
### 置换函数：任何左边不是标识符的赋值语句都是置换函数，如g(u) <- v，R语言会尝试用以下方式运行：u <- "g<-"(u, value = v)
> x <- c(1, 2, 4)
> names(x)
NULL
> names(x) <- c("a", "b", "c")
> names(x)
[1] "a" "b" "c"
> x
a b c 
1 2 4 
> x <- "names<-"(x, c("d", "e", "f"))
> x
d e f 
1 2 4 
## 匿名函数：不给函数命名，如apply中使用的函数