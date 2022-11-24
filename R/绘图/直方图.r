##### 实例：
> ggplot(data = diamonds) + geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
### 可使用dplyr::count()和ggplot2::cut_width()函数组合来手动计算结果：
> diamonds %>% count(cut_width(carat, 0.5))
# A tibble: 11 × 2
   `cut_width(carat, 0.5)`     n
   <fct>                   <int>
 1 [-0.25,0.25]              785
 2 (0.25,0.75]             29498
 3 (0.75,1.25]             15977
 4 (1.25,1.75]              5313
 5 (1.75,2.25]              2002
 6 (2.25,2.75]               322
 7 (2.75,3.25]                32
 8 (3.25,3.75]                 5
 9 (3.75,4.25]                 4
10 (4.25,4.75]                 1
11 (4.75,5.25]                 1

##### 同一张图上叠加多个直方图：geom_freqploy()函数可执行geom_histogram()同样的计算过程，但前者使用折线而不是条形图显示数据
> ggplot(data = diamonds, mapping = aes(x = carat, color = cut)) + geom_freqpoly()
### 为了防止各组之间数量相差过大导致看不出分布的区别，可显示密度对计数进行标准化
> ggplot(data = diamonds, mapping = aes(x = carat, y = ..density.., color = cut)) + geom_freqpoly()