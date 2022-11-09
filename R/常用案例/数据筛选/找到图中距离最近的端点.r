# 找到图中距离最近的端点（返回一个对称矩阵中元素最小值及其位置）
mind <- function(d) {
   n <- nrow(d)
   dd <- cbind(d,1:n) # 增加一列作为行号，给apply函数用
   wmins <- apply(dd[-n,],1,imin) # 因为矩阵为对称矩阵且对角线元素为0，最后一行无需计算
   # wmins will be 2xn, 1st row being indices and 2nd being values
   i <- which.min(wmins[2,])
   j <- wmins[1,i]
   return(c(d[i,j],i,j))
}

# 返回矩阵每一行的最小值及其列数
imin <- function(x) {
   lx <- length(x)
   i <- x[lx]  # 行号
   j <- which.min(x[(i+1):(lx-1)]) # 仅计算第i+1到倒数第2列的最小值
   k <- i+j # 上一行返回的最小值索引是相对于范围(i+1):(lx-1)的，需要在结果上增加i才是元素所在位置
   return(c(k,x[k])) # 返回的矩阵第1行为列数，第2行为最小值
}
