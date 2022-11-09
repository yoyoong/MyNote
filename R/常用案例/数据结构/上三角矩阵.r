# create an object of class "ut" from the full matrix inmat (0s included)
ut <- function(inmat) {
   n <- nrow(inmat)
   rtrn <- list()  # start to build the object  
   class(rtrn) <- "ut"
   rtrn$mat <- vector(length=sum1toi(n))  
   rtrn$ix <- sum1toi(0:(n-1)) + 1  
   for (i in 1:n) { # for循环也可写成：rtrn$mat <- inmat[row(m) <= col(m)]
      # store column i
      ixi <- rtrn$ix[i]
      rtrn$mat[ixi:(ixi+i-1)] <- inmat[1:i,i]
   }
   return(rtrn)
}

# utility function, returns 1+...+i
sum1toi <- function(i) return(i*(i+1)/2)

> m
     [,1] [,2] [,3]
[1,]    4    3    5
[2,]   NA    1    6
[3,]   NA   NA    2
> ut(m)
$mat
[1] 4 3 1 5 6 2
$ix
[1] 1 2 4
attr(,"class")
[1] "ut"