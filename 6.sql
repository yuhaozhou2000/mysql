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
INSERT test_str(a,b) VALUES(' ','');
