### 使用“过半数规则”：如果最近k期里下雨（1）的数量大于等于k/2，则预测下一个值为1,；否则预测下一个值为0

# 方法1
preda <- function(x,k) {
  n <- length(x)
  k2 <- k/2
  pred <- vector(length=n-k)
  for (i in 1:(n-k)) {
    if (sum(x[i:(i+(k-1))]) >= k2) # 使用sum计算避免了循环
      pred[i] <- 1 
    else 
      pred[i] <- 0
  }
  return(mean(abs(pred-x[(k+1):n])))
}

# 方法2
predc <- function(x,k) {
  n <- length(x)
  k2 <- k/2
  pred <- vector(length=n-k)
  csx <- c(0,cumsum(x)) # 使用cumsum计算向量累计和
  for (i in 1:(n-k)) {
    if (csx[i+k] - csx[i] >= k2) # 计算窗口的结束和开始处的累计和只差则为窗口内的向量和
      pred[i] <- 1 
    else 
      pred[i] <- 0
  }
  return(mean(abs(pred-x[(k+1):n])))
}

# 方法3
predb <- function(x,k) {
   n <- length(x)
   k2 <- k/2
   pred <- vector(length=n-k)
   sm <- sum(x[1:k])
   if (sm >= k2) 
     pred[1] <- 1 
   else 
     pred[1] <- 0
   if (n-k >= 2) {
      for (i in 2:(n-k)) {
         sm <- sm + x[i+k-1] - x[i-1] # 更新上一步的向量和
         if (sm >= k2) 
           pred[i] <- 1 
         else 
           pred[i] <- 0
      }
   }
   return(mean(abs(pred-x[(k+1):n])))
}