##### 使用snow包解决共同外链问题
### 共同外链问题：
mtl <- function(ichunk, m) {
   n <- ncol(m)
   matches <- 0
   for (i in ichunk) {
   	   if (i < n) {
         rowi <- m[i, ]
         matches <- matches + sum(m[(i + 1) : n, ] %*% rowi)
        }
   }
   matches
}
mutlinks <- function(cls, m) {
	n <- nrow(m)
	nc <- length(cls) # 获取集群工人的数量
	# determine which worker gets which chunk of i
	options(warn = -1)
	ichunks <- split(1:n, 1:nc) # 如果nc=2，在利用R的循环补齐将n列分割为奇数列和偶数列，如1:4分割为1/3和2/4
	options(warn = 0)
	counts <- clusterApply(cls, ichunks, mtl, m) # 将对应的ichunks[i]分配给集群工人cls[i]
	do.call(sum, counts) / (n * (n - 1) / 2)
}
##### 运行snow代码步骤
source("mt1.R") # 加载代码
library(snow) # 加载snow包
cl <- makeCluster(type = "SOCK", c("localhost", "localhost")) # 创建snow集群
m <- matrix(sample(0:1, 16, replace = T), nrow = 4)
mutlinks(cl, m) # 在集群上运行代码

##### 借助于C
### 利用多核编程（多线程）：可使用C语言的OpenMP包进行多核编程
### 实例：使用OpenMP解决共同外链问题
#include <omp.h>
#include <R.h> 
int tot;  // grand total of matches, over all threads
// processes row pairs (i,i+1), (i,i+2), ...
int procpairs(int i, int *m, int n) {  
    int j,k,sum=0;
    for (j = i+1; j < n; j++) {
        for (k = 0; k < n; k++) 
        // find m[i][k]*m[j][k] but remember R uses col-major order
        sum += m[n*k+i] * m[n*k+j];
    }
    return sum;
}
void mutlinks(int *m, int *n, double *mlmean) {  
    int nval = *n;
    tot = 0;
    #pragma omp parallel
    {  
        int i,mysum=0,
        me = omp_get_thread_num(),
        nth = omp_get_num_threads(); 
        // in checking all (i,j) pairs, partition the work according to i;
        // to get good load balance, this thread me will handle all i that equal
        // me mod nth
        for (i = me; i < nval; i += nth) {
            mysum += procpairs(i,m,nval);
        }
        #pragma omp atomic
        tot += mysum;
    }
    int divisor = nval * (nval-1) / 2;
    *mlmean = ((float) tot)/divisor;
}
### 使用GPU编程：R软件包gputools包含一些R能够进行调用的矩阵代数和统计分析函数，如矩阵求逆GPUSolve()函数

##### 普遍的性能考虑
### 1、对于简单并行程序，对问题进行划分并行计算即可；若程序不是简单并行的，将计算密集的部分使用C改写，例如使用OpenMP或GPU编程
### 2、静态和动态任务分配
### 3、将一般问题转变为简单并行问题

##### 调试R并行代码
## tips：print()函数无法在集群工人上使用，应使用message()，若message()也不能使用，需使用cat()