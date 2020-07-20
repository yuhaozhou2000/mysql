#用户表 user
CREATE TABLE IF NOT EXISTS user(
id INT,
username VARCHAR(20),
password CHAR(32),
email VARCHAR(50),
age TINYINT,
card CHAR(18),
tel CHAR(11),
salary Float(8,2),
married TINYINT(1),
sex ENUM('男','女','保密'),
addr VARCHAR(100)

)ENGINE=INNODB CHARSET=UTF8;

#INSERT [INTO] tbl_name(字段名称,字段名称,...)
#INSERT [INTO] tbl_name(id,username,...) VALUES(1,...,...);

#向imooc_user表插入一条记录
INSERT imooc_user(id,username,password,email,age,card,tel,salary,married,addr,sex)
VALUES(1,'KING','KING','382771946@qq.com',24,'230112197803241234','18635579617',8888.68,0,'北京','男');

#查询表中所有的记录 SELECT * FROM tbl_name;  *代表着表中的字段 如果你写的是* 表中所有的字段都会查出来
INSERT imooc_user(id,username,password,email,age,card,tel,salary,married,addr,sex)
VALUES(-5,'KING','123456','382771946@qq.com',127,'230112197803241234','18635579617',2345.68,1,'北京','女');
