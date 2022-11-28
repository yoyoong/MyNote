### 可使用正则表达式的函数：grep()、grep1()、regexpr()、gregexpr()、sub()、gsub()、strsplit()等
### 开启正则表达式匹配：[]

### 常用的正则表达式及其匹配规则
# .     匹配任意一个字符
# ..    匹配任意两个字符
# \\.   匹配点(.)
# \\\\  匹配反斜杠(\)
# \d    匹配任意数字
# \s    匹配任意空白字符（如空格、制表符和换行符）
# [abc] 匹配a、b或c
# [^abc]匹配除a、b、c外的任意字符。注意这个^是包含在中括号里面的，跟下面的从字符串开头进行匹配不一样
# ^     从字符串开头进行匹配
# $     从字符串末尾进行匹配。如果想要强制正则表达式匹配一个完整字符串，那么可以同时设置^和$这两个锚点
# |     创建多个可选的模式。注意，因为|的优先级很低，所以abc|xyz匹配的是abc或xyz，而不是abcyz或abxyz，可以使用括号让其表达得更清晰一些，如gr(e|a)y匹配grey和gray
# ?     匹配0次或1次。如colou?r可以匹配color何colour。默认的匹配方式是“贪婪的”，即会匹配尽量长的字符串，通过在正则表达式后面添加一个?，可将匹配方式更改为“懒惰的”，即匹配尽量短的字符串
# +     匹配1次或多次。
# *     匹配0次或多次
# {n}   匹配n次。
# {n,}  匹配n次或更多次。如C{2,}匹配两个以上连续的C
# {,m}  最多匹配m次。
# {n, m}匹配n到m次

### 原生regexpr()函数
> regexpr("^ab", "abcde")
[1] 1
attr(,"match.length")
[1] 2
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
> regexpr("[^ab]", "abcde")
[1] 3
attr(,"match.length")
[1] 1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
> regexpr("[b.e]", "abced")
[1] 2
attr(,"match.length")
[1] 1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
> regexpr(".", "abced")
[1] 1
attr(,"match.length")
[1] 1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE
> regexpr("\\.", "abced")
[1] -1
attr(,"match.length")
[1] -1
attr(,"index.type")
[1] "chars"
attr(,"useBytes")
[1] TRUE

### 当使用一个字符串作为模式时，R会自动调用regex()函数对其进行包装。可以使用regex()函数的其他参数来控制具体的匹配方式：
# ignore_case = TRUE 既可以匹配大写字母，也可以匹配小写字母
# multiline = TRUE 可以使得^和$从每行的开头和末尾开始匹配，而不是把多行字符串的开头和末尾开始匹配
> str_extract_all(x, "^Line")
[[1]]
[1] "Line"
> str_extract_all(x, regex("^Line", multiline = TRUE))
[[1]]
[1] "Line" "Line" "Line"
# comments = TRUE 可以让你在复杂的正则表达式中加入注释和空白字符，以便更易理解，匹配时会忽略空格和#后面的内容。
> phone <- regex("
+  \\(? # 可选的开括号
+  (\\d{3}) # 地区编码
+  [)- ]? # 可选的闭括号、短划线或空格
+  (\\d{3}) # 另外3个数字
+  [ -]? # 可选的空格或短划线
+  (\\d{3}) # 另外3个数字
+  ", comments = TRUE)
> str_match("514-791-8141", phone)
     [,1]          [,2]  [,3]  [,4] 
[1,] "514-791-814" "514" "791" "814"
# dotall = TRUE 可以使得 . 匹配包括 \n 在内的所有字符

##### 正则表达式的其他应用
### apropos()函数：在全局环境空间中搜索所有可用对象。当不能确切想起函数名称时，这个函数特别有用
### dir()函数：列出一个目录下的所有文件。dir()函数的patten参数可以是一个正则表达式，此时它只返回与这个模式相匹配的文件名

################################################################## stringr包进行正则表达式匹配 ##################################################################
> x <- c("apple", "banana", "pear")
##### 检测是否匹配：str_detect()函数
> str_detect(x, "e")
[1]  TRUE FALSE  TRUE
> sum(str_detect(x, "^a")) # 可统计匹配结果
[1] 1
> mean(str_detect(x, "[aeiou]$"))
[1] 0.6666667
### 当逻辑条件非常复杂时（例如，匹配a或b，但不匹配c，除非d成立），一般来说，相对于创建单个正则表达式，使用逻辑运算符将多个str_detect()调用组合起来会更容易
> no_vowels_1 <- !str_detect(words, "[aeiou]") # 找出至少包含一个元音字母的所有单词，然后取反
> no_vowels_2 <- str_detect(words, "^[^aeiou]+$") # 找出仅包含辅音字母（非元音字母）的所有单词
> identical(no_vowels_1, no_vowels_2) # 结果是一样的
[1] TRUE
### str_detect()函数的一种常见用法是选取出匹配某种模式的元素。可以通过逻辑取子集或str_subset()函数
> words[str_detect(words, "x$")]
[1] "box" "sex" "six" "tax"
> str_subset(words, "x$")
[1] "box" "sex" "six" "tax"
### str_detect()函数的一种变体是str_count()，返回字符串中匹配的数量
> mean(str_count(x, "[aeiou]"))
[1] 2.333333
### ！！！！！注意，匹配从来不会重叠
> str_count("abababa", "aba")
[1] 2

##### 提取匹配内容：str_extract()和str_extract_all()函数
> str_extract(x, "na") # 只提取第一个匹配
[1] NA   "na" NA 
> str_extract_all(x, "na") # 提取所有匹配
[[1]]
character(0)
[[2]]
[1] "na" "na"
[[3]]
character(0)
> str_extract_all(x, "na", simplify = T) # 返回一个矩阵，其中较短的匹配会扩展到与最长的匹配具有同样的长度
     [,1] [,2]
[1,] ""   ""  
[2,] "na" "na"
[3,] ""   "" 

##### 替换匹配内容：str_replace()和str_replace_all()函数
> str_replace(x, "[aeiou]", "-")
[1] "-pple"  "b-nana" "p-ar"  
> str_replace_all(x, "[aeiou]", "-")
[1] "-ppl-"  "b-n-n-" "p--r"  
> str_replace_all(x, c("a" = "A", "b" = "B", "c" = "C")) # 通过提供一个命名向量同时执行多个替换
[1] "Apple"  "BAnAnA" "peAr" 

##### 定位匹配内容：str_locate()和str_locate_all()函数可以给出每个匹配的开始位置和结束位置
> str_locate(x, "na")
     start end
[1,]    NA  NA
[2,]     3   4
[3,]    NA  NA
> str_locate_all(x, "na")
[[1]]
     start end
[[2]]
     start end
[1,]     3   4
[2,]     5   6
[[3]]
     start end

################################################################## stringr包进行正则表达式匹配 #####################################################################