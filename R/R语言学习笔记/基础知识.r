##### NA与NULL值：NA表示缺失值，NULL表示不存在的值（而不是存在但未知的值）
##### 判断一个值是否为缺失值：is.na()函数
##### NA在计算时不会自动跳过（需要显式跳过），而NULL会自动跳过
> c <- c(1, NA, 2, 3)
> mean(c)
[1] NA
> mean(c, na.rm=T)
[1] 2
> c <- c(1, NULL, 2, 3)
> mean(c)
[1] 2

##### 算术和逻辑运算符：+、-、*、/、^（幂）、%%（模运算）、%/%（整数除法）、&&（标量的逻辑与）、||（标量的逻辑或）、&（向量的逻辑与）、|（向量的逻辑或）

# 输出
print()

# 输出结果拼接
cat(a, b, c , ...)

# 输出内容到文件，此操作是"覆盖写入"操作，会将输出文件的原有数据清除，若想"追加写入"，可设置append参数。实例：cat("RUNOOB", file="D:\\test.txt", append=TRUE)
cat(value, file=filePath) # 实例：cat("RUNOOB", file="D:\\test.txt")

# 把控制台输出的文字直接输出到文件中
sink(filePath) # 实例：sink("D:\\test.txt")

#### 导入R文件中的代码
source("test.R")
