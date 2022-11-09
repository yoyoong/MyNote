##### 判断数据文件列数是否都满足条件
all(count.fields("file", sep = "\t") >= 5)

