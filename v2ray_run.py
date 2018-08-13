#!/usr/bin/env python
#coding: utf-8

import commands, json, urllib, os, time, datetime, requests

userCount = 0
sleepTime = 30

def printLog(content):
    print datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') + "  " + content

def main(): 
    while 1:
        #从网站读取用户配置
        url = "https://speedss.xyz/mu/users"
        querystring = {"key":"tienon"}

        headers = {
            'cache-control': "no-cache",
            'postman-token': "0c6691db-d363-8c9c-128d-21d76fa1f0f1"
            }
        try:
            response = requests.request("GET", url, headers=headers, params=querystring)
            jsonstr = json.loads(response.text)
        except:
            printLog("Server data error, try again after %d seconds" % sleepTime)
            time.sleep(sleepTime)
            continue
        printLog("Load json from server success")
        userArray = []
        #遍历拿到所有用户的passwd字段
        for data in jsonstr["data"]:
            #三种不加 
            #uuid为空不加
            if data["uuid"] != "":
                #payment_date小于当前时间戳不加
                if int(data["payment_date"]) > int(time.time()):
                    userArray.append(data["uuid"])
                    printLog("Found a user, uuid is " + data["uuid"])
        
        #userArray数量没变化直接返回
        global userCount
        if len(userArray) == userCount:
            printLog("No changes detected, sleep %d sec" % sleepTime)
            time.sleep(sleepTime)
            continue
        userCount = len(userArray)
        printLog("There are currently %d users" % userCount)
        
        #当前配置文件备份到config.json.bak
        if not os.path.exists("/etc/v2ray/config.json.bak"):
            output = commands.getoutput("mv /etc/v2ray/config.json /etc/v2ray/config.json.bak")
            if output != "":
                print output
            printLog("Write the config.json.bak file success")
        #读取v2ray配置文件
        with open('/etc/v2ray/config.json.bak') as json_data:
            configJson = json.load(json_data)
            printLog("Read the config.json.bak file successfully")

        for uuid in userArray:
            user = {}
            user["alterId"] = 64
            user["id"] = uuid
            user["level"] = 1
            configJson["inbound"]["settings"]["clients"].append(user)
        #configJson写入到config.json
        with open('/etc/v2ray/config.json', 'w') as outfile:
            #prettyprint
            json.dump(configJson, outfile, indent=4, sort_keys=True)
            printLog("Write the config.json file success, with %d users" % userCount)

        #print configJson["inbound"]["settings"]["clients"]
        #print configJson

        #重启v2ray服务
        output = commands.getoutput("service v2ray restart")
        if output != "":
            print output
        printLog("Restart the v2ray service")
        printLog("Data update is completed, sleep %d sec" % sleepTime)
        time.sleep(sleepTime)

if __name__ == '__main__':
    main()

