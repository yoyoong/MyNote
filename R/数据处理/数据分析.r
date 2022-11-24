##### 对数据进行分组统计：dplyr:summarize()函数
> flights %>% group_by(year, month, day) %>% summarize(mean = mean(dep_delay, na.rm = T)) # 计算每天所有航班的延误时间平均值
`summarise()` has grouped output by 'year', 'month'. You can override using the `.groups` argument.
# A tibble: 365 × 4
# Groups:   year, month [12]
    year month   day  mean
   <int> <int> <int> <dbl>
 1  2013     1     1 11.5 
 2  2013     1     2 13.9 
### 常用的统计函数：均方误差sd(x)、四分位距IQR()、绝对中位差mad(x)、最小值min(x)、n分位值quantile(x, n)、最大值max(x)
### 第一个值first(x)、第n个值nth(x, n)、最后一个值last(x)、个数n()、非空个数sum(!is.na(x))、唯一值的数量n_distinct(x)
### 逻辑值的计数和比例：sum(x > 10)、mean(y == 0)
### 因为计数太常用了，dplyr提供了一个简单的辅助函数count(x)，用于只需要计数的情况。还可以选择提供一个加权变量
> flights %>% count(dest)
# A tibble: 105 × 2
   dest      n
   <chr> <int>
 1 ABQ     254
 2 ACK     265
