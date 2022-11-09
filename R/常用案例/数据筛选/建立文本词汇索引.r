## 读取文本中的单词，建立单词所在位置的索引（存在多个则展示全部索引）

# 方法1
findwords <- function(tf) {
   txt <- scan(tf,"") # 读取文件中的词汇，返回一个向量
   wl <- list()
   for (i in 1:length(txt)) {
      wrd <- txt[i]
      wl[[wrd]] <- c(wl[[wrd]],i) # 若此单词未出现过，则插入一个新的索引；若已经出现过，则在后面添加索引
   }
   return(wl)
}

# 方法2
findwords <- function(tf) {
   txt <- scan(tf,"") 
   words <- split(1:length(txt),txt)
   return(words)
}