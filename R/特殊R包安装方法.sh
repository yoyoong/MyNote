##### hdf5r包
### 1.下载hdf5的源码
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz
### 2.编译安装
tar -zxvf hdf5-1.12.0.tar.gz
cd hdf5-1.12.0
./configure --prefix=/sibcb2/bioinformatics2/hongyuyang/software/hdf5-1.12.0
make && make install
### 3.设置环境变量
export PATH=/sibcb2/bioinformatics2/hongyuyang/software/hdf5-1.12.0bin:$PATH
export LD_LIBRARY_PATH=/sibcb2/bioinformatics2/hongyuyang/software/hdf5-1.12.0/lib:$LD_LIBRARY_PATH
### 4.重新安装R包hdf5r
install.packages("hdf5r")
# 若报错ERROR: compilation failed for package ‘hdf5r’，需要指定hdf5路径：
install.packages("hdf5r", configure.args="--with-hdf5=/sibcb2/bioinformatics2/hongyuyang/software/hdf5-1.12.0/bin/h5cc")
# 若报错x86_64-conda_cos6-linux-gnu-cc: command not found，则需要吧anaconda/bin（含有x86_64-conda_cos6-linux-gnu-cc）的路径添加到PATH中
# 依然报错Error: package or namespace load failed for ‘hdf5r’ in dyn.load(file, DLLpath = DLLpath, ...): unable to load shared object '/sibcb2/bioinformatics2/hongyuyang/R/x86_64-conda_cos6-linux-gnu-library/3.5/hdf5r/libs/hdf5r.so':/sibcb2/bioinformatics2/hongyuyang/R/x86_64-conda_cos6-linux-gnu-library/3.5/hdf5r/libs/hdf5r.so: undefined symbol: H5Rget_type，则更换hdf5版本为hdf5-1.10.5：
install.packages("hdf5r", configure.args="--with-hdf5=/sibcb2/bioinformatics2/hongyuyang/software/hdf5-1.10.5/bin/h5cc")