//
//  BaseTabBarController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/6.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController ,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if let data = SaveDataTool.get("userObject") {
            let userObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data ) as? UserObject
            if (userObject?.switch2 ?? 0) == 0 {
                self.viewControllers?.remove(at: 1)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        var email = ""
        if let data = SaveDataTool.get("userObject") {
            let userObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data ) as? UserObject
            if (userObject?.switch2 ?? 0) != 0 {
                if tabBarController.selectedIndex == 1 {
                    if let obj = AppJumpViewControllerManager.shareInsten.userObject {
                        if let str = obj.email{
                            for (i,v) in str.enumerated() {
                                if v == "@" {
                                    let index = str.index(str.startIndex, offsetBy: i)
                                    email = str.substring(to: index)
                                }
                            }
                        }
                        UIApplication.shared.openURL(URL.init(string: "https://cross.todobo.com/user/direct.php?verify=" + (email+"\(obj.passwd ?? "")\(obj.t ?? 0)").md5+"&uid=\(obj.uid ?? 0)")!)
//                        AppJumpViewControllerManager.shareInsten.gotoWebViewController(curViewController: self, url: "https://cross.todobo.com/user/direct.php?verify=" + (email+"\(obj.passwd ?? "")\(obj.t ?? 0)").md5+"&uid=\(obj.uid ?? 0)" , title: "忘記密碼")
                    }
                    tabBarController.selectedIndex = 0
                }
            }
            
        }
      
    }
    


}
