****
* 场景：npm start启动frontend项目
* 现象：报错error:03000086:digital envelope routines::initialization error
* 解决方案：npm版本过高，降低npm版本即可，可安装16.0.0版本
****
* 场景：使用node-xlsx读取excel文件
* 现象：Uncaught TypeError: _fs.readFileSync is not a function
* 解决方案
    * 1、
    * 2、
****
* 场景：使用MySQL.js连接MySQL
* 现象：Cannot compile namespaces when the '--isolatedModules' flag is provided.
* 解决方案：在MySQL.js的所有变量名上添加一行注释// @ts-ignore
****
* 场景：node连接mysql数据库
* 现象：Error: ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server; consider upgrading MySQL client
* 解决方案
    * 1、登录数据库：mysql -u root -p
    * 2、打开要访问的数据库：use hg19
    * 3、alter user 'root'@'localhost' identified with mysql_native_password by '123456'; 
    * 4、flush privileges;
****
* 场景：node连接mysql数据库
* 现象：ER_ACCESS_DENIED_ERROR: Access denied for user ‘root‘@‘localhost‘ (using password: YES)
* 解决方案：输入密码错误
****
* 场景：
* 现象：
* 解决方案
    * 1、
    * 2、
****