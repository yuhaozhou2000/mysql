-- 测试整型
CREATE TABLE test_int(
  a TINYINT,
  b SMALLINT,
  c MEDIUMINT,
  d INT,
  e BIGINT
);


INSERT test_int(a) VALUES (-128);
INSERT test_int(a) VALUES (127);
-- 当mysql为非严格模式即为宽松模式时 如果插入表中的数据值超出当前所对应的数据类型的取值范围会产生截断的现象
-- 然后将截断后的数据值插入到指定的表中
# 如果mysql为严格模式 插入的数据值超出数据类型取值范围 不会自动截断
# 只会提示插入数据值失败 插入的值超出了当前所对应的数据类型的取值范围

INSERT test_int(a) VALUES (-129);
INSERT test_int(a) VALUES (1270);

CREATE TABLE test_int2(
  a TINYINT,
  b SMALLINT,
  c MEDIUMINT,
  d INT,
  e BIGINT
);


CREATE TABLE test_unsigned(
  a TINYINT,
  b TINYINT UNSIGNED
)

INSERT TEST_UNSIGNED(a,b) VALUES(-12,-12);
INSERT TEST_UNSIGNED(a,b) VALUES(0,0);
INSERT TEST_UNSIGNED(a,b) VALUES(0,256);


-- 测试0填充 ZEROFILL

 CREATE TABLE test_int1(
  a TINYINT ZEROFILL,
  b SMALLINT ZEROFILL,
  c MEDIUMINT ZEROFILL,
  d INT ZEROFILL,
  e BIGINT ZEROFILL
);

INSERT test_int1(a,b,c,d,e) VALUES(1,1,1,1,1);
CREATE TABLE test_int2(
  -- 指定TINYINT的显示长度为2
  a TINYINT(2),
  b SMALLINT(2)
);

INSERT test_int2(a,b) values(123,45678);
-- 显示长度不会影响数据的插入,只要保证实际宽度小于类型的取值范围就可以,如果实际宽度大于类型的取值范围在宽松模式下会发生
--自动截断
-- eg: a TINYINT TINYINT的取值范围是-128--127 当我们插入的数据大于127时 1270 实际插入的值是127,当我们插入的数据小于
-- -128 为-1290时插入的值为-128 即取这个类型的两个边缘值127和-128
-- 显示宽度和zerofill配合使用,当数据的实际宽度大于显示宽度时插入的结果仍然是你要插入的数
-- 当显示宽度大于你要插入的宽度时就会在你要插入的数前面补0使你插入的数值的宽度和显示宽度相等
