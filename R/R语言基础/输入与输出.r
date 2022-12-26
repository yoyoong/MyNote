### scan()函数：从文件中读取或用键盘输入一个向量，可以是数值型或字符型
scan(filename)
scan(filename, what="") # 若文件是字符型，需要加参数what=""，表示使用字符模式读取文件
scan(filename, what="", sep = "\n") # 指定分隔符

# readline()函数：从键盘读取单行数据
str <- readline("input a string:")

##### 从文件中读取数据框或矩阵：2种方法
## 方法1：用scan()逐行读取，再用matrix()中的byrow选项设定矩阵安航存储
data <- matrix(scan(filename, nrow = 5, byrow = TRUE))
#### 方法2：先用read.table()读取为数据框，再用as.matrix()转化为矩阵【通用方法】
data <- as.matrix(read.table(filename))

########## 读取文本文件：使用readLines()函数
##### 一次性读取整个文件
data <- readLines(filename)
##### 逐行读取文件
con <- file(filename, "r")
readLines(con, 2) # 读取下两行，若下一行为空，则出现character(0)，可根据length(line) == 0判断是否为文件最后一行
### 从文件某处（以字符个数为单位）重新读取
seek(con2 = con, where = 0) # 从开始处读取

### 通过URL在远程计算机上访问文件：某些I/O函数，如read.table()和scan()，可以用网站地址作为参数，读取网站上的数据

########## 写入文件
##### 写入数据框和矩阵：write.table()函数
> d
  x y
1 2 a
2 3 b
3 1 a
4 4 b
> write.table(d, "d.txt") # 写入数据框
> write.table(d, "d.txt", row.names = F, col.names = F) # 写入矩阵，只需声明不要列明和行名
##### 写入新行：cat()和writeLines()函数
> cat("abc\n", file = "cat.txt") # 创建文件cat.txt，并写入一行
> cat("de\n", file = "cat.txt", append = T) # 往cat.txt追加一行
> file <- file("writeLines.txt", "w") # 创建文件，进入写模式
> writeLines(c("abc", "de"), file) # 同时写入两行
> close(file) # 关闭文件

##### 文件和目录处理
# 获取当前工作目录
> getwd()
[1] "C:/Users/94835/Documents"
# 设置当前工作目录
> setwd("C:\\Users\\94835\\Downloads")
> getwd() 
[1] "C:/Users/94835/Downloads"
##### 拼接路径名和文件名
> f <- file.path("outputDir", "CRC_hg19_MHB.bed") # 由于linux和window的拼接规则不一致，不能直接用字符串拼接
> f
[1] "outputDir/CRC_hg19_MHB.bed"
# 显示文件的基本信息
> file.info("CRC_hg19_MHB.bed")
                 size isdir mode               mtime               ctime               atime exe
CRC_hg19_MHB.bed   21 FALSE  666 2022-11-04 14:49:43 2022-11-04 14:49:52 2022-11-04 15:14:51  no
> file.info("CRC_hg19_MHB.bed")$isdir # 判断文件是目录还是文件
[1] FALSE
# 列出当前目录下的文件
> dir()
[1] "CRC_hg19_MHB.bed" "desktop.ini"      "hg19_CpG"         "hg38_CpG"         "outputDir"       
[6] "windows"         
> dir(recursive = T) # 显示整个目录树
##### 文件重命名/文件移动
file.name("a/b/c.txt", "a/d/e.txt") # 从文件夹a/b/移动到a/d/，且文件名从c.txt改为e.txt