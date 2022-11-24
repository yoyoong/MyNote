

# coord_flip()函数可交换x轴和y轴，可用于绘制水平箱线图
> ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot() + coord_flip() 
# reorder()函数可对分组按某种规则进行排序
> ggplot(data = mpg) + geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) + coord_flip() # 按中位数排序

