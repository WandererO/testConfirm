//
//  AppObjectManager.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/14.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import Foundation
import HandyJSON
class ServerListObject : HandyJSON {
    let id:Int = 0
    let nodeClient:String = ""
    let nodeLoad:Int = 0
    let nodeMethod:String = ""
    let nodeName:String = ""
    let nodeServer:String = ""
    let nodeStatus:String = ""
    let nodeType:Int = 0
    required init() {}
}
class CheckDBObject : HandyJSON {
    var timestamp:Int = 0
    var status:Int = 2
    var error:String = ""
    var message:String = ""
    var path:String = ""
    required init() {}
}
class UserObject : NSObject, HandyJSON, NSCoding{
    
    
    var uid:Int?
    var t:Int?
    var u:Int?
    var d:Int?
    var transferEnable:Int?
    var port:Int?
    var switch2:Int?
    var enable:Int?
    var lastGetGiftTime:Int?
    var lastCheckInTime:Int?
    var lastRestPassTime:Int?
    var credits:Int?
    var introUid:Int?
    
    var userName:String?
    var email:String?
    var pass:String?
    var passwd:String?
    var regDate:String?
    var expTime:String?
    required override init() {}
    required init?(coder aDecoder: NSCoder) {
        self.uid = aDecoder.decodeObject(forKey: "uid") as? Int
        self.t = aDecoder.decodeObject(forKey: "t") as? Int
        self.u = aDecoder.decodeObject(forKey: "u") as? Int
        self.d = aDecoder.decodeObject(forKey: "d") as? Int
        self.enable = aDecoder.decodeObject(forKey: "enable") as? Int
        self.transferEnable = aDecoder.decodeObject(forKey: "transferEnable") as? Int
        self.port = aDecoder.decodeObject(forKey: "port") as? Int
        self.switch2 = aDecoder.decodeObject(forKey: "switch2") as? Int
        self.lastGetGiftTime = aDecoder.decodeObject(forKey: "lastGetGiftTime") as? Int
        self.lastCheckInTime = aDecoder.decodeObject(forKey: "lastCheckInTime") as? Int
        self.lastRestPassTime = aDecoder.decodeObject(forKey: "lastRestPassTime") as? Int
        self.credits = aDecoder.decodeObject(forKey: "credits") as? Int
        self.introUid = aDecoder.decodeObject(forKey: "introUid") as? Int
        
        self.userName = aDecoder.decodeObject(forKey: "userName") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.pass = aDecoder.decodeObject(forKey: "pass") as? String
        self.passwd = aDecoder.decodeObject(forKey: "passwd") as? String
        self.regDate = aDecoder.decodeObject(forKey: "regDate") as? String
        self.expTime = aDecoder.decodeObject(forKey: "expTime") as? String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(t, forKey: "t")
        aCoder.encode(u, forKey: "u")
        aCoder.encode(d, forKey: "d")
        aCoder.encode(enable, forKey: "enable")
        aCoder.encode(transferEnable, forKey: "transferEnable")
        aCoder.encode(port, forKey: "port")
        aCoder.encode(switch2, forKey: "switch2")
        aCoder.encode(lastGetGiftTime, forKey: "lastGetGiftTime")
        aCoder.encode(lastCheckInTime, forKey: "lastCheckInTime")
        aCoder.encode(lastRestPassTime, forKey: "lastRestPassTime")
        aCoder.encode(credits, forKey: "credits")
        aCoder.encode(introUid, forKey: "introUid")
        
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(pass, forKey: "pass")
        aCoder.encode(passwd, forKey: "passwd")
        aCoder.encode(regDate, forKey: "regDate")
        aCoder.encode(expTime, forKey: "expTime")
        
    }
    
}
