//
//  RequestManager.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/5.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
let BaseURL:String = "https://app.todobo.com/"
let ProBaseURl:String = "https://app.todobo.com/"
let DEVMODE:Bool = true
enum RequestAdress {
    static var loginURL = "User/selectEntityByEqualToOption?"
    static var serverListURL = "SsNode/selectEntityByEqualToOption?"
    static var checkDBURL = "User/checkDB"
}
func PrintLog<T>(message:T,file:String = #file,method:String = #function,line:Int = #line) {
    if DEVMODE {
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):>>>>>>>\(message)")
    }
}
class AppRequesionConfig: NSObject {
   
    class func getRequest(urlString:String,params:[String:Any]?,header:[String:String]?,success:@escaping(_ json:String?)->(),failtrue:@escaping(_ error:Error) -> ()) {
        
        Alamofire.request(BaseURL+urlString, method: .get, parameters: params,  headers: header).responseString { (jsonString) in
            switch jsonString.result {
            case .success:
                success(jsonString.value)
                PrintLog(message: jsonString)
            case .failure(let error):
                failtrue(error)
                PrintLog(message: error)
            }
        }
    }
}
class BaseResponse<T:HandyJSON>: HandyJSON {
    var code: Int? // 服务端返回码
    var data: [T]? // 具体的data的格式和业务相关，故用泛型定义
    public required init() {}
}



