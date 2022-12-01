##### 允许其他电脑连接mysql数据库
mysql -u root -p # 登录数据库
use mysql;
update user set host = ‘%’ where user = ‘root’; # %表示所有地址都可访问
FLUSH PRIVILEGES # 重启MySQL

##### 修改root密码
mysql -uroot -p # 输入后后回车，提示输入密码时直接按回车进入
use mysql;
update user set authentication_string='' where user='root'; # 将authentication_string置空
alter user 'root'@'localhost' identified by 'newpassword'; # newpassword是要设的新密码
flush privileges;

### 解决ERROR 2003 (HY000): Can't connect to MySQL server on 'localhost:3306' (10061)问题
mysqld --console # 继续在该窗口输入
# 然后重新打开一个cmd，输入：
mysql -uroot -p