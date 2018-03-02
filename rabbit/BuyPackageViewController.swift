//
//  BuyPackageViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/12.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit
import WebKit
class BuyPackageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let wkWebView:WKWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(wkWebView)
        var email = ""
        if let obj = AppJumpViewControllerManager.shareInsten.userObject {
            if let str = obj.email{
                for (i,v) in str.enumerated() {
                    if v == "@" {
                        let index = str.index(str.startIndex, offsetBy: i)
                        email = str.substring(to: index)
                    }
                }
            }
           
            let request = URLRequest.init(url: URL.init(string: "https://cross.todobo.com/user/direct.php?verify=" + (email+"\(obj.passwd ?? "")\(obj.t ?? 0)").md5+"&uid=\(obj.uid ?? 0)")!)
            wkWebView.load(request)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
