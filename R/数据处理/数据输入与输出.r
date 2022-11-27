########################################################### 使用tidyverse中的readr包输入输出数据 #######################################################
##### readr包中读取数据的函数与R自带的函数相比，速度更快，推荐使用
##### read_csv()函数：读取逗号分隔文件
> heights <- read_csv("hg19.csv")
Rows: 3751 Columns: 37
# read_csv()函数默认都使用数据的第一行作为列名称，可以改变这种做法：
> read_csv("The first line of metadata
+  The second line of metadata
+  x,y,z
+  1,2,3", skip = 2) # 可使用skip = n来跳过前n行
Rows: 1 Columns: 3  
> read_csv("# A comment I want to skip
+  x,y,z
+ 1,2,3", comment = "#") # 或使用comment = "#"来丢弃所有以#开头的行
Rows: 1 Columns: 3  
> read_csv("1,2,3\n4,5,6", col_names = FALSE) # 若数据没有列名称，可使用col_names = FALSE不将第一行作为列标题，而是将各列依次标注为X1 Xn
Rows: 2 Columns: 3 
> read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z")) # 或者可以向col_names传递一个字符向量，以用作列名称
Rows: 2 Columns: 3 

##### read_csv2()函数：读取分号分隔文件
##### read_tsv()函数：读取制表符分隔文件
##### read_delim()函数：读取使用任意分隔符的文件
##### read_fwf()函数：读取固定宽度的文件。可使用fwf_widths( 函数按照宽度来设定域，也可以使用fwf_positions()函数按照位置来设定域
##### read_log()函数：读取Apache风格的日志文件（需安装webreadr包）

##### 获取读取数据的失败记录
> problems(hg19)
# A tibble: 14 × 5
     row   col expected actual file                             
   <int> <int> <chr>    <chr>  <chr>                            
 1   876    18 a double null   C:/Users/94835/Documents/hg19.csv
 2   876    19 a double null   C:/Users/94835/Documents/hg19.csv

##### 写入文件
write_csv(challenge, "challenge.csv")
# 注意，当保存为CSV文件时，类型信息就丢失了，这使得CSV文件在暂存临时结果时有些不可靠——每次加载时都要重建列类型
# write_rds()和read_rds()函数是对基础函数readRDS()和saveRDS()的统一包装，可使用write_rds()函数可以将数据保存为R自定义的二进制RDS格式
write_rds(challenge, "challenge.rds")
read_rds("challenge.rds")
######################################################################################################################################################

##### 读取SPSS、Stata和SAS文件：haven包
##### 读取Excel文件：readxl