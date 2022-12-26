##### 获取字符长度：nchar()函数、stringr:str_length()函数
> nchar("abc de/n")
[1] 8
> nchar(NULL) # 用在非字符串上可能会得到不可预料的结果，要想得到一致的结果，可使用CRAN上的stringr包
integer(0)
> nchar(NA)
[1] NA
> str_length(c("a", NULL, NA))
[1]  1 NA

##### 拼接字符串：paste()函数、stringr:str_c()函数
> paste("abc", "de") # 默认分隔符为空格
[1] "abc de"
> paste("abc", "de", sep = "") # 不需要分隔符
[1] "abcde"
> paste("prefix-", c("a", "b", "c"), "-suffix") # 可向量化，stringr:str_c()函数效果一样
[1] "prefix- a -suffix" "prefix- b -suffix" "prefix- c -suffix"
> paste0("abc", "de")
[1] "abcde"
> str_c("abc", "de")
[1] "abcde"
> str_c("abc", "de", sep = ",")
[1] "abc,de"

##### 截取字符串：subst()函数、stringr:str_sub()函数
> substr("abcde", 2, 4)
[1] "bcd"
> str_sub(c("Apple", "Banana", "Pear"), 1, 3) # 可向量化
[1] "App" "Ban" "Pea"
> str_sub(c("Apple", "Banana", "Pear"), 2) # stringr:str_sub()函数可缺省终止位置，substr不行
[1] "pple"  "anana" "ear" 
> x <- "Apple"
> str_sub(x, 1) <- str_to_lower(str_sub(x, 1)) # 还可以使用str_sub()函数的赋值形式来修改字符串
> x
[1] "apple"

##### 按分隔符分割字符串：strsplit()函数
> strsplit("2022-11-5", split = "-")
[[1]]
[1] "2022" "11"   "5" 
# 注意按元字符划分时，需要加上fixed=T参数，否则需使用转移后的字符作为分隔符
> strsplit("CRC_hg19_MHB.bed", ".")
[[1]]
 [1] "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
> strsplit("CRC_hg19_MHB.bed", ".", fixed = T)
[[1]]
[1] "CRC_hg19_MHB" "bed"         
> strsplit("CRC_hg19_MHB.bed", "\\.")
[[1]]
[1] "CRC_hg19_MHB" "bed" 

##### 在字符串中寻找子字符串所在的第一个位置：regexpr()函数
> regexpr("bc", "abced")
[1] 2
attr(,"match.length")
[1] 2
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
##### 找出子字符串在字符串中的所有位置：gregexpr()函数
> gregexpr("bc", "abcedcbcbca")
[[1]]
[1] 2 7 9
attr(,"match.length")
[1] 2 2 2
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

## 在字符串向量中搜索子字符串：grep(pattern, strList)函数
> s <- c("abc", "bcd", "cde")
> grep("d", s) # 返回存在子字符串的字符串在向量中的位置
[1] 2 3

### 格式化输出：sprintf()函数
> sprintf("The result is: %d", 1)
[1] "The result is: 1"
# 可用于批量创建多个文件
> for(i in 1:5) {
+ fname <- sprintf("file%d.pdf", i)
+ pdf(fname)
+ }
# 注意%d是整型、%f和%g是浮点型，但%f含有6位小数
> sprintf("%f", 1.2)
[1] "1.200000"
> sprintf("%g", 1.2)
[1] "1.2"