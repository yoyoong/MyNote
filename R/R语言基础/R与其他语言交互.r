########### R与C/C++交互
##### 注意事项：C语言中二维数组是按行存储的，R则是按列存储的，且C语言的下标是从0开始，在R中是从1开始
##### 从R传递给C的参数都是以指针的形式存在的，而C语言函数的返回值必须是void，因此如果想从C函数返回值，则必须与函数的参数进行交互
##### 实例：
### 使用C语言写一段提取方阵次对角线元素的程序，命名为sd.c：
#include <R.h>  // required
// arguments:
//    m:  a square matrix
//    n:  number of rows/columns of m
//    k:  the subdiagonal index--0 for main diagonal, 1 for first 
//        subdiagonal, 2 for the second, etc.
//    result:  space for the requested subdiagonal, returned here
void subdiag(double *m, int *n, int *k, double *result)
{
  int nval = *n, kval = *k;
  int stride = nval + 1;
  for (int i = 0, j = kval; i < nval-kval; ++i, j+= stride) 
     result[i] = m[j];
}
### 编译C语言程序生成动态共享库文件sd.so：以Linux为例（Windows此功能包含在Cygwin中）
% R CMD SHLIB sd.c
gcc -std=gnu99 -I/usr/share/R/include -fpic -g -O2 -c sd.c -o sd.o
gcc -std=gnu99 -shared -o sd.so sd.o -L/usr/lib/R/lib -lR
### 将这个库文件加载到R中并调用C函数
dyn.load("sd.so")
.C("subdiag", m, n, k, result)


########## 从Python调用R：使用RPy包，调用R中的函数只需在函数名加上r.即可
>>> r.hist(r.rnorm(100)) # 调用R中的rnorm()函数生成100个标准正态分布的随机数，并绘制成直方图
##### Python和R的不同：
##### 1、Python的语法中没有波浪线（~），因此在线性拟合时需要使用字符串，如'v2~v1'
##### 2、如果R的函数名含有英文句号，在Python中需改成下划线，如data.frame()需改成data_frame()

