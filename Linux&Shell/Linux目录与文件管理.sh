##### 文件权限管理
# 修改文件夹下所有子文件的权限
chmod -R 777 /home/linux

##### 压缩与解压
# 解压tar.bz2
tar -jxvf xxx.tar.*bz2*
# 解压tar.gz
tar -zxvf xxx.tar.gz
# 解压.zip.gz
gunzip xxx.zip.gz
# 解压.zip
unzip xxx.zip
# 查看gzip压缩的文件
zcat file.**.gz | head -n 10

##### 校验和与核实：校验和（checksum）程序用来从文件中生成相对较小的唯一密钥。我们可以重新计算该密钥，用以检查文件是否发生改变。通过比对下载文件和原始文件的校验和，就能够核实接收到的文件是否正确。如果源位置上的原始文件的校验和与目的地上接收文件的校验和相等，就意味着我们接收到的文件没有问题。Unix和Linux支持多种校验和程序，但强健性最好且使用最为广泛的校验和算法是MD5和SHA-1。md5sum和sha1sum程序可以对数据应用对应的算法来生成校验和。
-bash-4.2$ md5sum test.sh temp.txt # 计算md5sum
4d29f1e430addcafed5a53c0ef8a125b  test.sh
8085003714535bc003d0242586a5f0a9  temp.txt
-bash-4.2$ sha1sum test.sh temp.txt # 计算sha1sum
1c857421d5a85207e3520e94eb627f3e120155c1  test.sh
080514cb63e951b48ffe68bc5f7f2b6d365b2b03  temp.txt
-bash-4.2$ md5sum test.sh > test.md5 # 可以将输出的校验和重定向到一个文件中，以备后用
-bash-4.2$ md5sum -c test.md5 # 用生成的文件核实数据完整性
test.sh: OK
-bash-4.2$ vim test.sh
-bash-4.2$ md5sum -c test.md5 # 源文件已修改，校验不通过
test.sh: FAILED
md5sum: WARNING: 1 computed checksum did NOT match
### 对目录进行校验：校验和是从文件中计算得来的。对目录计算校验和意味着需要对目录中的所有文件以递归的方式进行计算。md5deep或sha1deep命令可以遍历目录树，计算其中所有文件的校验和（系统不一定有，需要安装），-r选项允许md5deep递归遍历子目录。-l选项允许显示相对路径径，不再使用默认的绝对路径。或者也可以结合find来递归计算校验和：find directory_path -type f –print0 | xargs -0 md5sum >> directory.md5

##### 加密工具与散列：加密技术主要用于防止数据遭受未经授权的访问。与校验和算法不同，加密算法可以无损地重构原始数据，可用的加密算法包括crypt、gpg和base64等
### crypt命令通常并没有安装在Linux系统中。该命令从stdin接受输入，要求用户创建口令，然后将加密数据输出到stdout
$ crypt <input_file >output_file 
Enter passphrase: 
$ crypt PASSPHRASE <input_file >encrypted_file # 在命令行上提供口令
$ crypt PASSPHRASE -d <encrypted_file >output_file # 解密文件
### gpg（GNU privacy guard）是一种应用广泛的工具，它使用加密技术来保护文件，以确保数据在送达目的地之前无法被读取
$ gpg -c filename # 用gpg加密文件，命令会采用交互方式读取口令并生成filename.gpg
$ gpg filename.gpg # 解密gpg文件
### Base64是一组相似的编码方案，它将二进制数据转换成以64为基数的形式（radix-64 representation），以可读的ASCII字符串进行描述。这类编码程序可用于通过E-mail传输二进制数据。base64命令能够编码/解码Base64字符串。
$ base64 filename > outputfile # 将文件编码为Base64格式，或者cat file | base64 > outputfile 
$ base64 -d file > outputfile # 解码Base64数据，或者cat base64_file | base64 -d > outputfile

