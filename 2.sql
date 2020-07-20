--创建慕课网 imooc
CREATE DATABASE IF NOT EXISTS imooc DEFAULT CHARACTER SET 'UTF8';
--打开imooc
USE imooc;
--用户表 user
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
-- INNODB为默认的存储引擎
-- 字段名 表名 数据库名都为小写 关键字大写
