########## 使用lubridate处理日期和时间（nycflights13包作为练习数据）
##### 创建日期或时间
> today()
[1] "2022-12-02"
> now()
[1] "2022-12-02 15:12:45 CST"
##### 通过字符串创建日期或时间：根据年（y）、月（m）和日（d）在日期数据中的顺序，组成能够解析日期的lubridate函数名称。创建日期时间型数据，可以在后面加一个下划线，以及h、m和s之中的一个或多个字母
> ymd("2022-12-02")
[1] "2022-12-02"
> dmy("02/12/2022")
[1] "2022-12-02"
> dmy("12-02/2022")
[1] "2022-02-12"
> ymd("20221202")
[1] "2022-12-02"
> ymd_hms("2017-01-31 20:11:59")
[1] "2017-01-31 20:11:59 UTC"
> mdy_hm("01/31/2017 08:01")
[1] "2017-01-31 08:01:00 UTC"
##### 通过各个成分创建日期或时间：make_date()函数创建日期，make_datetime()函数创建日期时间
> flights %>% select(year, month, day, hour, minute) %>% mutate(departure = make_datetime(year, month, day, hour, minute))
# A tibble: 336,776 × 6
    year month   day  hour minute departure          
   <int> <int> <int> <dbl>  <dbl> <dttm>             
 1  2013     1     1     5     15 2013-01-01 05:15:00
 2  2013     1     1     5     29 2013-01-01 05:29:00
### 获取日期时间成分：year()、month()、mday()（一个月中的第几天）、yday()（一年中的第几天）、wday()（一周中的第几天）、hour()、minute()和second()等函数
### 对于month()和wday()函数，可以设置label = TRUE来返回月份名称和星期数的缩写，还可以设置abbr = FALSE来返回全名
> yday(now())
[1] 336
> month(now(), label = T)
[1] 12月
Levels: 1月 < 2月 < 3月 < 4月 < 5月 < 6月 < 7月 < 8月 < 9月 < 10月 < 11月 < 12月
> wday(now(), label = T)
[1] 周五
Levels: 周日 < 周一 < 周二 < 周三 < 周四 < 周五 < 周六
### 还可以使用每个访问器函数来设置日期时间中的成分，或者通过update()函数同时设置多个成分创建一个新日期时间
> dt = now()
> year(dt) <- 2020
> dt
[1] "2020-12-02 15:51:40 CST"
##### 时间间隔
### 将两个日期相减
> age <- today() - ymd(19971217)
> age
Time difference of 9118 days
### lubridate提供了总是使用秒为单位的另一种计时对象——时期
> as.duration(age)
[1] "787795200s (~24.96 years)"
### lubridate还提供了阶段对象，使用“人工”时间，比如日和月
> now() + days(1)
[1] "2022-12-05 19:22:11 CST"
> now() + months(1) + days(1)
[1] "2023-01-05 19:22:53 CST"