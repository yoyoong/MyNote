* 场景：Linux上运行jar
* 现象：报错java.awt.AWTError: Can’t connect to X11 window server using ‘localhost:10.0’ as
* 解决方案
    * 方法一：在tomcat的/bin/catalina.sh文件开头处加入如下配置：JAVA_OPTS=-Djava.awt.headless=true
    * 方法二：在代码中加System.setProperty(”java.awt.headless”,“true”)
****
* 场景：删除map中的键值对
* 现象：报错java.util.ConcurrentModificationException
* 解决方案
    * 使用迭代器，通过迭代器进行删除，而不是map.remove()，如下：
    ```Java
    Iterator<String> iterator = mHapListMap.keySet().iterator();
    while (iterator.hasNext()) {
        String key = iterator.next();
        if (key.equals("")) {
            iterator.remove();
        }
    }
    ```
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