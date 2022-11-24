######################################################### 测试数据 ###############################################################
> library(nycflights13)
> flights # 包含了2013年从纽约市出发的所有336776次航班的信息
# A tibble: 336,776 × 19
    year month   day dep_time sched_…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier flight tailnum origin dest  air_t…⁶ dista…⁷
   <int> <int> <int>    <int>    <int>   <dbl>   <int>   <int>   <dbl> <chr>    <int> <chr>   <chr>  <chr>   <dbl>   <dbl>
 1  2013     1     1      517      515       2     830     819      11 UA        1545 N14228  EWR    IAH       227    1400
 2  2013     1     1      533      529       4     850     830      20 UA        1714 N24211  LGA    IAH       227    1416
 3  2013     1     1      542      540       2     923     850      33 AA        1141 N619AA  JFK    MIA       160    1089
 ######################################################### 测试数据 ###############################################################

##### 判断数据文件列数是否都满足条件
all(count.fields("file", sep = "\t") >= 5)

##### 修改列名：rename() 函数
> rename(flights, tail_num = tailnum) # 将列名tailnum改为tail_num

##### 新增一列：dplyr:mutate()函数
> mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60) # 新增gain和speed两列，数值由原有列计算而来
# A tibble: 336,776 × 21
> transmute(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60) # 只想保留新列
# A tibble: 336,776 × 2

########## 按值筛选行
##### dplyr:filter()函数：基于观测的值筛选出一个观测子集。第一个参数是数据框名称，第二个以及随后的参数是用来筛选数据框的表达式。
> filter(flights, month == 1, day == 1) # 筛选出1月1日的所有航班

########## 筛选列
##### dplyr:select()函数：按列名筛选指定的列
> select(flights, year, month, day) # 选择年、月、日3列
> select(flights, year:day) # 选择“year”和“day”之间的所有列（包括“year”和“day”）
> select(flights, -(year:day)) # 选择不在“year”和“day”之间的所有列（不包括“year”和“day”）
### 还可以在 select () 函数中使用一些辅助函数
# starts_with("abc")：匹配以“abc”开头的名称
# ends_with("xyz")：匹配以“xyz”结尾的名称
# contains("ijk")：匹配包含“ijk”的名称
# matches("(.)\\1")：选择匹配正则表达式的那些变量。这个正则表达式会匹配名称中有重复字符的变量
# num_range("x", 1:3)：匹配x1、x2和x3

########## 对行进行排序
##### dplyr:arrange()函数：接受一个数据框和一组作为排序依据的列名（或者更复杂的表达式）作为参数，默认为升序（缺失值总是排在最后）。
> arrange(flights, year, month, day) # 按年、月、日排序
> arrange(flights, desc(arr_delay)) # 使用desc()可以按列进行降序排序

