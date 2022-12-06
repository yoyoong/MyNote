## 创建数据框
> x <- c(2, 3, 1, 4)
> y <- c("a", "b")
> d <- data.frame(x, y)
> d
  x y
1 2 a
2 3 b
3 1 a
4 4 b

# 各种矩阵操作都可运用于数据框中

### apply类型函数也可运用于数据框上
> d
  x y
1 2 a
2 3 b
3 1 a
4 4 b
> lapply(d, sort) # 将sort函数应用于每一列，返回一个列表
$x
[1] 1 2 3 4
$y
[1] "a" "a" "b" "b"

#### complete.cases()函数：判断是否存在至少一个缺失值
d[complete.cases(d), ] # 删除含有NA值的行

### 可使用rbind()和cbind()函数向数据框中添加新行/列
> d
  y x
1 a 2
2 b 3
> rbind(d, list("c", 4)) # 添加一行
  y x
1 a 2
2 b 3
3 c 4
> cbind(d, d$x - 1) # 使用原列计算生成新列
  y x d$x - 1
1 a 2       1
2 b 3       2
> d$subOne <- d$x - 1 # 给新列命名
> d
  y x subOne
1 a 2      1
2 b 3      2

##### merge()函数：合并两个数据框
merge(d1, d2) # 合并含有一个或多个同名的列的数据框
merge(d1, d2， by.x = "kids", by.y = "names") # by.x和by.y参数标示出两个数据框中含有相同信息但名称不同的列（最后以x的名称为准）