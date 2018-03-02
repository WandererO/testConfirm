//
//  LoginViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/5.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit
import MBProgressHUD
import HandyJSON
class LoginViewController: BaseViewController {
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var userObject:UserObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewUI()
        
        self.userNameTextFiled.text = ""
        self.passwordTextFiled.text = ""
        
        self.userNameTextFiled.text = UserDefaults.standard.string(forKey: "loginUserName");
        self.passwordTextFiled.text = UserDefaults.standard.string(forKey: "loginPassword");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setViewUI() {
        self.showPasswordButton.isSelected = false
        self.oneView.setCornerRadius()
        self.cancelButton.setCornerRadius()
        self.sureButton.setCornerRadius()
    }
    @IBAction func showPasswordButtonClick(_ sender: UIButton) {
        self.showPasswordButton.isSelected = !self.showPasswordButton.isSelected
        if self.showPasswordButton.isSelected == true {
            self.showPasswordButton.setImage(UIImage.init(named: "登录注册-眼睛密码可看"), for: .normal)
            self.passwordTextFiled.isSecureTextEntry = false
        }else{
            self.showPasswordButton.setImage(UIImage.init(named: "登录注册-眼睛密码不可看"), for: .normal)
            self.passwordTextFiled.isSecureTextEntry = true
        }
        
    }
    
    @IBAction func suerLoginButtonClick(_ sender: UIButton) {
        guard (self.userNameTextFiled.text ?? "" ).count > 0 else {
            HUD.showMessageNoImage("請輸入賬號！")
            return
        }
        guard (self.passwordTextFiled.text ?? "").count > 0 else {
            HUD.showMessageNoImage("請輸入密碼！")
            return
        }
        let params:[String:Any] = ["pass":self.passwordTextFiled.text!,"email":self.userNameTextFiled.text!]
        let str = self.userNameTextFiled.text! + ":" + self.passwordTextFiled.text!
        let plainData = str.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: UInt(0)))
        let header:[String:String] = ["authorization":"Basic "+base64String!]
        let base64 = NSData(base64Encoded: base64String!, options: NSData.Base64DecodingOptions.init(rawValue: UInt(0)))
        let str2 = String.init(data: base64! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
    UserDefaults.standard.setValue(self.userNameTextFiled.text, forKey: "loginUserName");
    UserDefaults.standard.setValue(self.passwordTextFiled.text, forKey: "loginPassword");
        
        
        PrintLog(message: "Basic "+base64String!)
        PrintLog(message: str2)
        AppRequesionConfig.getRequest(urlString: RequestAdress.loginURL, params: params,header: header ,success: { (json) in
            if let obj:[UserObject] = JSONDeserializer<UserObject>.deserializeModelArrayFrom(json: json, designatedPath: "data") as? [UserObject]{
                if obj.count > 0 {
                    self.userObject = obj[0]
                    if self.userObject?.enable == 1 {
                        let data:NSData = NSKeyedArchiver.archivedData(withRootObject: self.userObject!) as NSData
                        AppJumpViewControllerManager.shareInsten.userObject = self.userObject
                        SaveDataTool.save(data, key: "userObject")
                        AppJumpViewControllerManager.shareInsten.isLoginedIn()
                        
                    }else{
                        HUD.showMessageNoImage("請登錄郵箱激活賬號")
                    }
                }
            }else{
                HUD.showMessageNoImage("賬號或密碼錯誤！")
            }
        }) { (error) in
            HUD.showMessageNoImage("賬號或密碼錯誤！")
        }
      
    }
    
    @IBAction func cancelLoginButton(_ sender: UIButton) {
        self.userNameTextFiled.text?.removeAll();
        self.passwordTextFiled.text?.removeAll();
    UserDefaults.standard.setValue(self.userNameTextFiled.text, forKey: "loginUserName");
    UserDefaults.standard.setValue(self.passwordTextFiled.text, forKey: "loginPassword");
    }
    
    @IBAction func registerButtonClick(_ sender: UIButton) {
//        UIApplication.shared.openURL(URL.init(string: "https://cross.todobo.com/user/register.php")!)
        AppJumpViewControllerManager.shareInsten.gotoWebViewController(curViewController: self, url: "https://cross.todobo.com/user/register.php", title: "註冊")
    }
    @IBAction func forgetButtonClick(_ sender: UIButton) {
//        UIApplication.shared.openURL(URL.init(string: "https://cross.todobo.com/user/resetpwd.php")!)
        AppJumpViewControllerManager.shareInsten.gotoWebViewController(curViewController: self, url: "https://cross.todobo.com/user/resetpwd.php", title: "忘記密碼")
    }
    
}
