//
//  AppJumpViewControllerManager.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/6.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON
class AppJumpViewControllerManager {
    static let shareInsten = AppJumpViewControllerManager()
    let mainStoryd:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userObject:UserObject?
    func isLogin()  {
        if let data = SaveDataTool.get("userObject") {
            self.userObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data ) as? UserObject
            self.isLoginedIn()
            PrintLog(message: self.userObject!.uid)
            
        }else{
            self.login()
        }
    }
    func setUpBaseTabBarController() -> UITabBarController {
        let tab:BaseTabBarController = mainStoryd.instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        return tab
    }
    func isLoginedIn()  {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = self.setUpBaseTabBarController()
        appDelegate.window?.makeKeyAndVisible()
    }
    func login()  {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let nav:UINavigationController = self.mainStoryd.instantiateViewController(withIdentifier: "BaseNavigationController") as! BaseNavigationController
        appDelegate.window?.rootViewController = nav
        appDelegate.window?.makeKeyAndVisible()
    }
    func exitLogin()  {
        SaveDataTool.remove("userObject")
        login()
    }
    func gotoLoginViewController(curViewController:UIViewController)  {
        let vc:LoginViewController  = mainStoryd.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        curViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoServerListViewController(curViewController:UIViewController,serverList:[ServerListObject],selectButtonIndex:Int,action: @escaping (_ selectButtonIndex:Int) -> Void)  {
        let vc:ServerListViewController  = mainStoryd.instantiateViewController(withIdentifier: "ServerListViewController") as! ServerListViewController
        vc.obj = serverList
        vc.action = action
        vc.selectButtonIndex = selectButtonIndex
        curViewController.navigationController?.pushViewController(vc, animated: true)
    }
    func gotoWebViewController(curViewController:UIViewController,url:String?,title:String)  {
        let vc:WebViewController  = WebViewController()
        vc.titleLabel = title
        vc.url = url
        curViewController.navigationController?.pushViewController(vc, animated: true)
    }
    func gotoPromoteViewController(curViewController:UIViewController,id:Int)  {
        let vc:PromoteViewController  = mainStoryd.instantiateViewController(withIdentifier: "PromoteViewController") as! PromoteViewController
        vc.id = id
        curViewController.navigationController?.pushViewController(vc, animated: true)
    }
}

