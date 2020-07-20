-- 测试浮点型
-- FLOAT(M,D) M代表这个浮点数的总长度D代表小数点后几位
-- M叫精度是数据的总长度,D叫标度指的是小数点后的长度
CREATE TABLE test_float(
  a FLOAT (6,2),
  b DOUBLE (6,2),
  c DECIMAL (6,2)
);

INSERT test_float(a,b,c) VALUES(4.143,4.146,4.149);
-- 此时插入的数据标度为3即小数点后面的位数为3位但是数据类型要求的是小数点后面的位数
-- 是两位所以会发生四舍五入 4.14 4.15 4.15
-- FLOAT 和 DOUBLE 在进行自动截断后是不会有警告提示的,而DECINMAL会有警告提示

CREATE TABLE test_float1 (
  a Float,
  b DOUBLE,
  c DECIMAL
);

-- 当FLOAT  DOUBLE DECIMAL 后面什么也不写时也会创建成功
-- 在向该表插入数据时 FLOAT DOUBLE 的数据值保持不变而 插入的DECIMAL类型的数据值会
-- 发生数据的自动截断他是将后面的小数部分全部截断了
INSERT test_float1(a,b,c) VALUES(4.143,4.146,4.149);

--DECIMAL 如果是因为实际表示小于显示标度而产生的截断则截断是按照 小数部分进行四舍五入的
--而如果是因为在创建表时建表语句中没写DECIMAL的显示精度和标度而产生的截断是按照
--整数部分的四舍五入即最后只剩下小数 ==> DECIMAL类型在没有指定显示精度和标度时
--默认只保存数值为进行完四舍五入的整数.

mysql> INSERT test_float1(a,b,c) VALUES(4.143,4.146,4.149);
Query OK, 1 row affected, 1 warning (0.40 sec)
mysql> show warnings;
+-------+------+----------------------------------------+
| Level | Code | Message                                |
+-------+------+----------------------------------------+
| Note  | 1265 | Data truncated for column 'c' at row 1 |
+-------+------+----------------------------------------+
1 row in set (0.00 sec)

mysql> INSERT test_float1(a,b,c) VALUES(4.143,4.146,4.56);
mysql> show warnings;
+-------+------+----------------------------------------+
| Level | Code | Message                                |
+-------+------+----------------------------------------+
| Note  | 1265 | Data truncated for column 'c' at row 1 |
+-------+------+----------------------------------------+
1 row in set (0.00 sec)
Query OK, 1 row affected, 1 warning (0.04 sec)

+-------+-------+------+
| a     | b     | c    |
+-------+-------+------+
| 4.143 | 4.146 |    4 |
| 4.143 | 4.146 |    5 |
+-------+-------+------+
