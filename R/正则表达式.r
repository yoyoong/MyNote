### 可使用正则表达式的函数：grep()、grep1()、regexpr()、gregexpr()、sub()、gsub()、strsplit()等
### 开启正则表达式匹配：[]

### 常用的正则表达式
# [.]：任意一个字符
# [..]：任意两个字符

> regexpr("[bc]", "abced")
[1] 2
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