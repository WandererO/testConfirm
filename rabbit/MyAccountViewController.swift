//
//  MyAccountViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/6.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit

class MyAccountViewController: BaseViewController {
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var fiveView: UIView!
    
    @IBOutlet weak var creditsLabel: UILabel!
    
    @IBOutlet weak var packegeTypeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
    }
    func setViewUI() {
        self.oneView.setCornerRadius()
        self.twoView.setCornerRadius()
        self.threeView.setCornerRadius()
        self.fourView.setCornerRadius()
        self.fiveView.setCornerRadius()
        if let obj = AppJumpViewControllerManager.shareInsten.userObject {
            self.creditsLabel.text = "\(obj.credits ?? 0)"
            if obj.transferEnable != nil {
                if obj.transferEnable! % 3 != 0 {
                    self.packegeTypeLabel.text = "無限包"
                }else{
                    self.packegeTypeLabel.text = "標準包"
                }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func userGuideButtonClick(_ sender: UIButton) {
        UIApplication.shared.openURL(URL.init(string: "https://cross.todobo.com/user/guide.php")!)
//        AppJumpViewControllerManager.shareInsten.gotoWebViewController(curViewController: self, url: "https://cross.todobo.com/user/guide.php", title: "使用指南")
        
    }
    @IBAction func exitButtonClick(_ sender: UIButton) {
        VpnManager.shared.disconnect()
        AppJumpViewControllerManager.shareInsten.exitLogin()
    }
    @IBAction func onlineServiceButtonClick(_ sender: UIButton) {
        UIApplication.shared.openURL(URL.init(string: "https://cross.todobo.com/chat/php/app.php?widget-mobile")!)
//        AppJumpViewControllerManager.shareInsten.gotoWebViewController(curViewController: self, url: "https://cross.todobo.com/mibew/client.php/", title: "在線客服")
    }
    @IBAction func promotionCodeButtonClick(_ sender: UIButton) {
        if let obj = AppJumpViewControllerManager.shareInsten.userObject {
            AppJumpViewControllerManager.shareInsten.gotoPromoteViewController(curViewController: self, id: obj.uid ?? 0)
        }
        
    }
    
}
