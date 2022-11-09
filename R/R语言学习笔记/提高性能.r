########## 编写快速的R代码的方法：
##### 1、通过向量化优化代码，使用字节码编译
### 可能加速代码的向量化函数：ifelse()、which()、where()、any()、all()、comsum()、cumprod()。对于矩阵可以适用面rowSums()和colSums()等
### 对于“穷举所有组合”这类问题，可能需要combin()、outer()、lower.tri()、upper.tri()或expand.grid()等函数
### apply()函数可以消除显式循环，但它实际上是用R而不是C语言的，因此通常不同加速代码。而其他的apply函数，如lapply()对于加速代码很有帮助
##### 2、将代码中最消耗CPU的核心部分用编译型语言编写，如C或C++
##### 3、使用并行计算

##### 使用字节码编译函数：compiler包的cmpfun()函数
> library(compiler)
> f <- function() for(i in 1:length(x)) z[i] <- z[i] + y[i]
> cf <- cmpfun(f)
> system.time(cf())
用户 系统 流逝 
0.06 0.11 0.18 

### 查看语句运行时间：system.time()方法
> x <- runif(10000000)
> y <- runif(10000000)
> z <- vector(length = 10000000)
> system.time(z <- x + y)
用户 系统 流逝 
0.02 0.00 0.01 
> system.time(for(i in 1:length(x)) z[i] <- x[i] + y[i])
用户 系统 流逝 
0.36 0.00 0.35 

##### 监视代码的运行情况：Rprof()函数
> x <- runif(1000000)
> Rprof() # 开启监视器
> invisible(x <- x ^ 8)
> Rprof(NULL) # 调用带NULL参数的Rprof()结束监视
> summaryRprof() # 查看结果

##### 程序所需内存过大的解决方案
### 1、分块
### 2、利用R软件包进行内存管理
### （1）RMySQL：是R到MySQL数据库的一个接口，可将大量数据存储在数据库中，再用R读取SQL选择出的数据集
### （2）biglm：在很大的数据集上进行回归和广义线性模型的分析
### （3）ff和bigmemory：