### 求向量的最小值和最大值：min()/max()函数和pmin()/pmax()函数
> x <- c(5, 12, 13, -1)
> y <- c(2, 4, 5, 2)
> min(x, y) # min把向量的所有元素组成一个新向量然后返回最小值
[1] -1
> pmin(x, y) # pmin将向量对应元素分别两两对比
[1]  2  4  5 -1
> z <- c(1, 4, 6, 0) # pmin支持两个以上的向量
> pmin(x, y, z)
[1]  1  4  5 -1

### 求函数的最小值和最大值：nlm()函数和optim()函数
> fx <- function(x) {
+ return(x ^ 2 - sin(x))
+ }
> nlm(fx, 8)  # 求f(x)=x^2-sin(x)的最小值，使用数值计算中的Newton-Raphson方法，8为初始值
$minimum # 最小值
[1] -0.2324656
$estimate # 取最小值时的x
[1] 0.4501831
$gradient
[1] 4.024558e-09
$code
[1] 1
$iterations
[1] 5

## 求微积分
> D(expression(exp(x ^ 2)), "x") # 符号微分
exp(x^2) * (2 * x)
> integrate(function(x) x ^ 2, 0, 1) # 数值积分
0.3333333 with absolute error < 3.7e-15

# 计算向量的累计和以及累计积：cumsum()和cumprod()函数
> x <- c(5, 12, 13, -1)
> cumsum(x)
[1]  5 17 30 29
> cumprod(x)
[1]    5   60  780 -780

###### 统计分布函数：常用的分布包括正态分布（norm）、卡方分布（chisq）、二项分布（binom）、指数分布（exp）、伽马分布（gamma）、泊松分布（pois）
### 各种分布分布的函数名有一套统一的前缀：
### d：概率分布密度或概率质量密度，如dnorm()
### p：累积分布函数，如pnorm()
### q：分布的分位数，如qnorm()
### r：使用对应分布生成随机数，如rnorm()
> rnorm(10) # 生成服从正态分布的10个随机数
 [1] -0.2270592  1.3384653  0.5478051 -0.5003083  0.4051116
 [6]  0.3152706 -0.2189877 -1.0939218 -0.5001728  0.4689548
> qchisq(0.95, 2) # 计算自由度为2的卡方分布的95%分布数
[1] 5.991465
> qchisq(c(0.95, 0.995), df = 2) # d、p、q系列的函数的第一个参数可以是向量，可同时求多个值
[1]  5.991465 10.596635

## 计算向量的内积：使用crossprod()函数（注意这个函数名，不是计算向量叉积的）
> x
[1] 2 3 2 4
> y
[1] 2 4 5 2
> crossprod(x, y)
     [,1]
[1,]   34

### 解线性方程组：solve()函数
> a <- matrix(c(1, 1, -1, 1), nrow = 2, ncol = 2)
> c <- c(2, 4)
> solve(a, c)
[1] 3 1

##### 矩阵相关函数
### t()：矩阵转置
### qr()：QR分解
### chol()：Cholesky分解
### det()：矩阵的行列式值
### eigen()：矩阵的特征值和特征向量
### diag()：从方阵中提取对角矩阵。如果参数是矩阵，则返回一个向量；如果参数是向量或标量，则返回一个对应大小的单位矩阵
### sweep()：数值分析批量运算符。sweep()的前两个参数类似于apply()，分别是数组和方向，第3个参数是执行运算的对象，第4个参数是要使用的函数
> a
     [,1] [,2]
[1,]    1   -1
[2,]    1    1
> t(a)
     [,1] [,2]
[1,]    1    1
[2,]   -1    1
> diag(a)
[1] 1 1
> diag(diag(a))
     [,1] [,2]
[1,]    1    0
[2,]    0    1
> diag(3)
     [,1] [,2] [,3]
[1,]    1    0    0
[2,]    0    1    0
[3,]    0    0    1
> m <- diag(3)
> sweep(m, 1, c(1, 4, 7), "+") # 第1行加1，第2行加4，第3行加7
     [,1] [,2] [,3]
[1,]    2    1    1
[2,]    4    5    4
[3,]    7    7    8

### 集合运算
# union(x, y)：取并集
# intersect(x, y)：取交集
# setdiff(x, y)：取差集，即属于集合x但不属于集合y的元素的集合
# setequal(x, y)：检验两个集合是否相等
# c %in% x：检验c是否为集合x中的元素
# choose(n, k)：从含有n个元素的集合中选取含有k个元素的子集的数目
> x
[1] 2 3 2 4
> 1 %in% x
[1] FALSE
> 2.0 %in% x
[1] TRUE
> choose(5, 3)
[1] 10