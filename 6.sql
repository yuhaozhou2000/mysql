-- 测试CHAR 和 VARCHAR
CREATE TABLE test_str(
  a CHAR(5),
  b VARCHAR(5)
);
-- CHAR 占用5个字节 VARCHAR 占用1个字节(占用长度+1个字节)
INSERT test_str(a,b) VALUES('','');
-- CHAR 占用5个字节 VARCHAR 占用2个字节(占用长度+1个字节)
INSERT test_str(a,b) VALUES('a','a');
-- CHAR 占用5个字节 VARCHAR 占用3个字节(占用长度+1个字节)
INSERT test_str(a,b) VALUES('aa','aa');
-- CHAR 占用5个字节 VARCHAR 占用4个字节(占用长度+1个字节)
INSERT test_str(a,b) VALUES('aaa','aaa');
-- CHAR 占用5个字节 VARCHAR 占用5个字节(占用长度+1个字节)
INSERT test_str(a,b) VALUES('abcd','abcd');
-- CHAR 占用5个字节 VARCHAR 占用6个字节(占用长度+1个字节)
INSERT test_str(a,b) VALUES('abcde','abcde');
-- 注意cmd下是不认空格的
INSERT test_str(a,b) VALUES(' ',' ');与
INSERT test_str(a,b) VALUES('','');
在表中插入的都为空(即什么也没有)
-- 当字符串的长度超出了该字符串类型的指定长度后,会发生自动截取然后将截取后的数值插入到表中
INSERT test_str(a,b) VALUES('abcdef','abcdef');

INSERT test_str(a,b) VALUES(' 123 ',' 123 ');

SELECT CONCAT('*',a,'*'),CONCAT('*',b,'*') FROM test_str;
mysql> SELECT CONCAT('*',a,'*'),CONCAT('*',b,'*') FROM test_str;
+-------------------+-------------------+
| CONCAT('*',a,'*') | CONCAT('*',b,'*') |
+-------------------+-------------------+
| **                | **                |
| *a*               | *a*               |
| *aa*              | *aa*              |
| *aaa*             | *aaa*             |
| *abcd*            | *abcd*            |
| *abcde*           | *abcde*           |
| *abcde*           | *abcde*           |
| * 123*            | * 123 *           |
+-------------------+-------------------+
8 rows in set (0.06 sec)

我们在向表中插入数据时
向表中插入的字符串123的前后都是带有空格的即* 123 *
但是定长字符串CHAR在显示时 会将123后面的空格给删掉即* 123*
而变长字符串VARCHAR在显示时 是不会将123后面的空格删掉的即* 123 *还是保留着原来插入时的格式

INSERT test_str(a,b) VALUES(' 111',' 111');


-- 测试TEXT不能有默认值
CREATE TABLE test_str1(
  content
)
