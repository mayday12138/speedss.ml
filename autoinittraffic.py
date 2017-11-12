#!/usr/bin/env python
#coding: utf-8

import pymysql

conn = pymysql.connect(host='localhost', port=3306, user='root', passwd='tienon', db='shadowsocks')
conn.autocommit(1)
cur = conn.cursor()
try:
	#cur.execute("select * from `shadowsocks`.`user_traffic_log`  limit 0,1000")
	#print(cur.description)
	#for row in cur:
    	#	print(row)
	
	#20170312 1个月
	#cur.execute("update `shadowsocks`.`user` set `transfer_enable`='2147483648' where `port`='1061'")
	#20170312 6个月
	cur.execute("update `shadowsocks`.`user` set `transfer_enable`='85899345920' where `port`='1062'")
        #20170318 6个月
        cur.execute("update `shadowsocks`.`user` set `transfer_enable`='85899345920' where `port`='1073'")
        #20170328 6个月
        cur.execute("update `shadowsocks`.`user` set `transfer_enable`='85899345920' where `port`='1040'")
        #20170329 1个月
        #1082
except:
    import traceback
    traceback.print_exc()
    # 发生错误时会滚
    conn.rollback()
finally:
    # 关闭游标连接
    cur.close()
    # 关闭数据库连接
    conn.close()
