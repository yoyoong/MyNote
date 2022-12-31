* 场景：Git push代码
* 现象：报错Failed to connect to github.com port 443: Timed out
* 解决方案：执行以下命令
    ```
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    ```
****
* 场景：运行VUE项目
* 现象：报错Error: ENOSPC: System limit for number of file watchers reached, watch '文件路径'
* 解决方案：执行以下命令
    ```
    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p 
    sudo sysctl --system
    ```
****
* 场景：使用MultiQC
* 现象：报错from _bz2 import BZ2Compressor, BZ2Decompressor ModuleNotFoundError: No module named '_bz2'
* 解决方案
    * 1、下载_bz2.cpython-36m-x86_64-linux-gnu.so，放在Python-3.10.7/lib/python3.10/lib-dynload下，并将其改名符合Python版本，如3.7改为_bz2.cpython-**37m**-x86_64-linux-gnu.so，而3.10改为_bz2.cpython-**310**-x86_64-linux-gnu.so
    * 2、此时，报错ImportError: libbz2.so.1.0: cannot open shared object file: No such file or directory，待解决。。。
****
* 场景：wget安装软件
* 现象：报错ERROR: cannot verify mirrors.tuna.tsinghua.edu.cn’s certificate
* 解决方案：在wget命令最后加入--no-check-certificate即可解决
****
* 场景：Mongodb建立索引
* 现象：报错MongoError: command createIndexes requires authentication
* 解决方案：连接Mongodb数据库需加入用户名和密码：mongodb://admin:SnKIrfCZ@127.0.0.1:27017
****
* 场景：Mongodb使用mongoimport导入数据
* 现象：报错unable to authenticate using mechanism "SCRAM-SHA-1": (AuthenticationFailed)
* 解决方案：mongoimport命令加上authenticationDatabase参数，指定数据库名称，如mongoimport --authenticationDatabase admin -u admin -p SnKIrfCZ ...
****

* 场景：
* 现象：
* 解决方案
    * 1、
    * 2、
****
* 场景：
* 现象：
* 解决方案
    * 1、
    * 2、
****
* 场景：
* 现象：
* 解决方案
    * 1、
    * 2、
****
* 场景：
* 现象：
* 解决方案
    * 1、
    * 2、
****