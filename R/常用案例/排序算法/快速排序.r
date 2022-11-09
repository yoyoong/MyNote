##### 使用递归实现快速排序（速度比原生的sort慢，因为sort是用C写的）
qs <- function(x) {
   if (length(x) <= 1) return(x)
   compareValue <- x[1]
   therest <- x[-1]
   unsortList1 <- therest[therest < compareValue]
   unsortList2 <- therest[therest >= compareValue]
   unsortList1 <- qs(unsortList1)
   unsortList2 <- qs(unsortList2)
   return(c(unsortList1, compareValue, unsortList2))
}