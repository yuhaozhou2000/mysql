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

-- 
