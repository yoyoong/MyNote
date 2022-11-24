##### 绘制两个分类变量的数量图（泡泡图）：geom_count()函数
> ggplot(data = diamonds) + geom_count(mapping = aes(x = cut, y = color))
# 可使用计算出具体数值
> diamonds %>% count(color, cut)
##### 也可绘制成色块图：geom_tile()函数
> diamonds %>% count(color, cut) %>% ggplot(mapping = aes(x = cut, y = color)) + geom_tile(mapping = aes(fill = n))
