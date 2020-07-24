-- HH:MM:SS [D(天数) HH(小时):MM(分钟):SS(秒)] D:表示天数day的一个缩写 D的范围是 0-34
-- eg: 2 3:23:45  51(2*24+3):23:45
-- 因为TiME类型 的小时是从-838到838 所以有TIME类型有了天数的效果 可以用来表示某种特殊需要的时间间隔
-- 所以TIME类型的小时范围扩大了而且还支持了负值

-- 测试 TIME类型
CREATE TABLE test_time(
  a TIME

);

INSERT test_time(a) VALUES('12:23:45');
mysql> SELECT * FROM TEST_TIME;
+----------+
| a        |
+----------+
| 12:23:45 |
+----------+
1 row in set (0.00 sec)

INSERT test_time(a) VALUES('2 12:23:45');
--这里的2代表两天即 2*24+12 :23:45  即60:23:45
mysql> SELECT * FROM TEST_TIME;
+----------+
| a        |
+----------+
| 12:23:45 |
| 60:23:45 |
+----------+
2 rows in set (0.00 sec)


-- 当时间格式为XX:XX的时候 插入的时间为小时和分钟秒数默认为00
INSERT test_time(a) VALUES('22:22');
mysql> SELECT * FROM TEST_TIME;
+----------+
| a        |
+----------+
| 12:23:45 |
| 60:23:45 |
| 22:22:00 |
+----------+
3 rows in set (0.00 sec)

 -- 当只有一个数字时 插入的时间为小时
INSERT test_time(a) VALUES('22');
mysql> select * from test_time;
+----------+
| a        |
+----------+
| 12:23:45 |
| 60:23:45 |
| 22:22:00 |
| 00:00:22 |
+----------+
4 rows in set (0.00 sec)

-- 当值为两个整数时 第一个整数代表天数 第二个数代表小时数 显示的时间为 天数*24+小时数:00:00
INSERT test_time(a) VALUES('2 22');
mysql> select * from test_time;
+----------+
| a        |
+----------+
| 12:23:45 |
| 60:23:45 |
| 22:22:00 |
| 00:00:22 |
| 70:00:00 |
+----------+
5 rows in set (0.00 sec)

-- 可以省略 : 直接写成 HHMMSS 这种字符串的形式
INSERT test_time(a) VALUES('121212');
-- 注这样写不是代表着 5 12:12:12 而是5*121212:00:00 而此时超过了TIME所能表示的最大范围 而产生自动截断 最终插入的值为 838:59:59
INSERT test_time(a) VALUES('5 121212');
mysql> select * from test_time;
+-----------+
| a         |
+-----------+
| 12:23:45  |
| 60:23:45  |
| 22:22:00  |
| 00:00:22  |
| 70:00:00  |
| 12:12:12  |
| 838:59:59 |
+-----------+
7 rows in set (0.00 sec)

-- 当向表中TIME类型的字段a 添加 数值0或者字符串0 时 都会转换成 00:00:00的这个形式保存
INSERT test_time(a) VALUES(0);
INSERT test_time(a) VALUES('0');

mysql> SELECT * FROM TEST_TIME;
+-----------+
| a         |
+-----------+
| 12:23:45  |
| 60:23:45  |
| 22:22:00  |
| 00:00:22  |
| 70:00:00  |
| 12:12:12  |
| 838:59:59 |
| 00:00:00  |
| 00:00:00  |
+-----------+
9 rows in set (0.00 sec)


--当向表中插入的TIME类型的数据值 超出TIME类型的范围时
INSERT test_time(a) values(787878);
mysql> INSERT test_time(a) values(787878);
ERROR 1292 (22007): Incorrect time value: '787878' for column 'a' at row 1

-- 使用系统函数
-- NOW() 函数转换为当前的系统时间
INSERT test_time(a) VALUES(NOW());
mysql> select * from test_time;
+-----------+
| a         |
+-----------+
| 12:23:45  |
| 60:23:45  |
| 22:22:00  |
| 00:00:22  |
| 70:00:00  |
| 12:12:12  |
| 838:59:59 |
| 00:00:00  |
| 00:00:00  |
| 00:00:00  |
| 10:03:16  |
+-----------+
11 rows in set (0.00 sec)

INSERT test_time(a) VALUES(CURRENT_TIME);
mysql> SELECT * FROM test_TIME;
+-----------+
| a         |
+-----------+
| 12:23:45  |
| 60:23:45  |
| 22:22:00  |
| 00:00:22  |
| 70:00:00  |
| 12:12:12  |
| 838:59:59 |
| 00:00:00  |
| 00:00:00  |
| 00:00:00  |
| 10:03:16  |
| 10:05:53  |
+-----------+
12 rows in set (0.00 sec)


-- 系统函数 SELECT NOW(); 得到当前系统的日期时间
SELECT NOW();
mysql> SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2020-07-24 10:08:19 |
+---------------------+
1 row in set (0.00 sec)

-- 得到当前系统时间
SELECT CURRENT_TIME;
mysql> SELECT CURRENT_TIME;
+--------------+
| CURRENT_TIME |
+--------------+
| 10:09:33     |
+--------------+

SELECT CURTIME();
mysql> SELECT CURTIME();
+-----------+
| CURTIME() |
+-----------+
| 10:12:31  |
+-----------+
1 row in set (0.00 sec)

# 测试 DATE 类型 YYYY-MM-DD  或者 YYYYMMDD
CREATE TABLE test_date(
  a DATE
);

INSERT test_date(a) VALUES(2017-03-04); # 不能这样写
INSERT test_date(a) VALUES('2017-03-04');
mysql> SELECT * FROM test_date;
+------------+
| a          |
+------------+
| 2017-03-04 |
+------------+
1 row in set (0.00 sec)

-- 不写0也是可以的
INSERT test_date(a) VALUES('2017-3-4');

mysql> SELECT * FROM test_date;
+------------+
| a          |
+------------+
| 2017-03-04 |
| 2017-03-04 |
+------------+
2 rows in set (0.00 sec)


-- 当年份 YYYY, MM, DD 的位数不够时 eg 217-3-4 会先用0补位后再保存
INSERT test_date(a) VALUES('217-3-4');
mysql> SELECT * FROM test_date;
+------------+
| a          |
+------------+
| 2017-03-04 |
| 2017-03-04 |
| 0217-03-04 |
+------------+
3 rows in set (0.00 sec)

-- 年份,月份,日之间 不带-也是可以的
INSERT test_date(a) VALUES('40071212');

-- 但是要注意当 年份,月份,日之间 不带-时 要保证 年份,月份,日 的位数
INSERT test_date(a) VALUES('4071212'); #是不行的
INSERT test_date(a) VALUES('4007112'); #是不行的
INSERT test_date(a) VALUES('7');       #是不行的

--mysql 支持一些不严格的语法形式 可以指定其他符号作为年月日的分隔符
INSERT test_date(a) VALUES('4007@12@12');
 INSERT test_date(a) VALUES('4009.12.12');

-- 使用两位的年份 月份和日的位数保持不变
-- YY-MM-DD YYMMDD
# 年份转换规则
# 当两位的年份 范围在
# 70~99 转换成1970~1999
# 00~69 转换成2000~2069

INSERT test_date(a) VALUES('780902');
mysql> SELECT * FROM test_date;
+------------+
| a          |
+------------+
| 2017-03-04 |
| 2017-03-04 |
| 0217-03-04 |
| 4007-12-12 |
| 2040-07-11 |
| 4007-12-12 |
| 4008-12-12 |
| 4009-12-12 |
| 1978-09-02 |
+------------+
9 rows in set (0.00 sec)


INSERT test_date(a) VALUES('650902');
mysql> SELECT * FROM test_date;
+------------+
| a          |
+------------+
| 2017-03-04 |
| 2017-03-04 |
| 0217-03-04 |
| 4007-12-12 |
| 2040-07-11 |
| 4007-12-12 |
| 4008-12-12 |
| 4009-12-12 |
| 1978-09-02 |
| 2065-09-02 |
+------------+
10 rows in set (0.00 sec)

INSERT test_date(a) VALUES('880902');
mysql> SELECT * FROM test_date;
+------------+
| a          |
+------------+
| 2017-03-04 |
| 2017-03-04 |
| 0217-03-04 |
| 4007-12-12 |
| 2040-07-11 |
| 4007-12-12 |
| 4008-12-12 |
| 4009-12-12 |
| 1978-09-02 |
| 2065-09-02 |
| 1988-09-02 |
+------------+
11 rows in set (0.00 sec)


-- 使用系统函数插入当前的日期
INSERT test_date(a) VALUES(NOW());-- 当插入的值为NOW()函数时会出现警告 提示
mysql> SHOW  WARNINGS;
+-------+------+---------------------------------------------------------------------+
| Level | Code | Message                                                             |
+-------+------+---------------------------------------------------------------------+
| Note  | 1292 | Incorrect date value: '2020-07-24 13:25:18' for column 'a' at row 1 |
+-------+------+---------------------------------------------------------------------+
1 row in set (0.00 sec)

-- 插入数据表中的值为
mysql> SELECT * FROM TEST_DATE;
+------------+
| a          |
+------------+
| 2017-03-04 |
| 2017-03-04 |
| 0217-03-04 |
| 4007-12-12 |
| 2040-07-11 |
| 4007-12-12 |
| 4008-12-12 |
| 4009-12-12 |
| 1978-09-02 |
| 2065-09-02 |
| 1988-09-02 |
| 2020-07-24 |
+------------+
12 rows in set (0.00 sec)
将NOW() 函数 获取的当前时间的时间部分去掉了 只保留了日期部分

INSERT test_date(a) VALUES(CURRENT_DATE);

-- 测试 DATETIME

CREATE TABLE test_datetime(
  a DATETIME
);

INSERT test_datetime(a) VALUES('1004-09-12 13:24:56');
mysql> SELECT * FROM TEST_DATETIME;
+---------------------+
| a                   |
+---------------------+
| 1004-09-12 13:24:56 |
+---------------------+
1 row in set (0.00 sec)

--mysql 支持一些不严格的语法形式 可以指定其他符号作为年月日 和时间的的分隔符
INSERT test_datetime(a) VALUES('1004.09.12 13.24.56');
mysql> SELECT * FROM TEST_DATETIME;
+---------------------+
| a                   |
+---------------------+
| 1004-09-12 13:24:56 |
| 1004-09-12 13:24:56 |
+---------------------+
2 rows in set (0.00 sec)

-- 缩写形式
INSERT test_datetime(a) VALUES('7203051212');
mysql> SELECT * FROM TEST_DATETIME;
+---------------------+
| a                   |
+---------------------+
| 1004-09-12 13:24:56 |
| 1004-09-12 13:24:56 |
| 1972-03-05 12:12:00 |
+---------------------+
3 rows in set (0.00 sec)

72   03 05 12 12
1972 03 05 12:12:00

-- 使用系统函数
INSERT test_datetime(a) VALUES(NOW());
mysql> SELECT * FROM TEST_DATETIME;
+---------------------+
| a                   |
+---------------------+
| 1004-09-12 13:24:56 |
| 1004-09-12 13:24:56 |
| 1972-03-05 12:12:00 |
| 2020-07-24 13:44:49 |
+---------------------+
4 rows in set (0.00 sec)

-- TIMESTAMP
-- DATETIME 和 TIMESTAMP 的区别在于他们的起始时间和结束时间不同
-- TIMESTAMP的日期时间范围要比DATETIME日期时间的范围要小

-- TIMESTAMP 与 DATATIME 的区别
CREATE TABLE test_timestamp(
  a TIMESTAMP
);

INSERT test_timestamp(a) VALUES('1978-10-23 12:12:12');

-- 当向表中插入CURRENT_TIMESTAMP 会得到当前系统的日期和时间
INSERT test_timestamp(a) VALUES(CURRENT_TIMESTAMP);
mysql> select * from test_timestamp;
+---------------------+
| a                   |
+---------------------+
| 1978-10-23 12:12:12 |
| 2020-07-24 14:01:15 |
+---------------------+
2 rows in set (0.00 sec)

-- 当向表中插入NULL 会得到当前系统的日期和时间
INSERT test_timestamp(a) VALUES(NULL);
mysql> select * from test_timestamp;
+---------------------+
| a                   |
+---------------------+
| 1978-10-23 12:12:12 |
| 2020-07-24 14:01:15 |
| 2020-07-24 14:02:26 |
+---------------------+
3 rows in set (0.00 sec)

-- 什么也不写 会得到当前的系统的日期和时间
INSERT test_timestamp VALUES();
