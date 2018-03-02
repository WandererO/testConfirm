//
//  SaveTools.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/15.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import Foundation
class SaveDataTool: NSObject {
    //MARK:存储数据
    class func save(_ data:NSData,key:String) {
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: key)
        if userDefaults.synchronize() {
            if DEVMODE {
                PrintLog(message: "\(data) is saved")
            }
        }else{
            if DEVMODE {
                PrintLog(message: "\(data) No is saved")
            }
        }
    }
    
    //MARK:移除数据
    class func remove(_ key:String){
        let userDefaults:UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    //MARK:获取数据
    class func get(_ key:String) -> NSData? {
        let userDefaults:UserDefaults = UserDefaults.standard
        if  let data = userDefaults.object(forKey: key)  {
            return data as? NSData
        }else{
            return nil
        }
    }
    
}
extension String  {
    
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
            
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}
