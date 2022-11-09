# 方法1
findruns <- function(x,k) {
   n <- length(x)
   runs <- NULL
   for (i in 1:(n-k+1)) {
      if (all(x[i:(i+k-1)]==1)) 
        runs <- c(runs,i) # 每次延长都要重新分配内存空间，运行速度较慢
   }
   return(runs)
}

# 方法2
findruns1 <- function(x,k) {
   n <- length(x)
   runs <- vector(length=n) # 预先分配内存空间，避免频繁进行内存分配而降低运行速度
   count <- 0
   for (i in 1:(n-k+1)) {
      if (all(x[i:(i+k-1)]==1)) {
         count <- count + 1
         runs[count] <- i
      }
   }
   if (count > 0) 
      runs <- runs[1:count]
   else 
      runs <- NULL
   return(runs)
}