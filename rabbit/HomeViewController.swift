//
//  ViewController.swift
//  rabbit
//
//  Created by yicheng on 16/11/18.
//  Copyright © 2016年 yicheng. All rights reserved.
//

import UIKit
import NetworkExtension
import HandyJSON

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var oneVIew: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    
    
    @IBOutlet var connectButton: UIButton!
    @IBOutlet weak var oneLayerView: ZCBView!

    @IBOutlet weak var serverName: UILabel!
    @IBOutlet weak var remainingTraffic: UILabel!
    
    @IBOutlet weak var validTime: UILabel!
    
    @IBOutlet weak var switchDelect: UISwitch!
    var userObject : UserObject?
    var serverList:[ServerListObject] = [ServerListObject]()
    var action:((_ selectButtonIndex:Int) -> Void)?
    var selectButtonIndex:Int = 0
    var timer:Timer!
    var timeNumber:Int = 20
    var status: VPNStatus {
        didSet(o) {
            updateConnectButton()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.status = .off
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(onVPNStatusChanged), name: NSNotification.Name(rawValue: kProxyServiceVPNStatusNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        self.setTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.status = VpnManager.shared.vpnStatus
        
    }
    func setViewUI()  {
        self.getRequestData()
        self.oneVIew.setCornerRadius()
        self.twoView.setCornerRadius()
        self.threeView.setCornerRadius()
        self.fourView.setCornerRadius()
        oneLayerView.layer.cornerRadius = oneLayerView.frame.width/2
        
        
    }
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target:self,selector:#selector(self.tickDown),
                                                       userInfo:nil,repeats:true)
    }
    func tickDown()
    {
        self.timeNumber = self.timeNumber - 1
        if self.timeNumber < 0 {
            self.timeNumber = 20
            AppRequesionConfig.getRequest(urlString: RequestAdress.checkDBURL, params: nil, header: nil, success: { (json) in
                if let obj:CheckDBObject = JSONDeserializer<CheckDBObject>.deserializeFrom(json: json ?? ""){
                    if obj.status == 401 {
                        AppJumpViewControllerManager.shareInsten.exitLogin()
                        VpnManager.shared.disconnect()
                        HUD.showMessageNoImage("賬號異常請，請重新登錄！")
                        self.timer.invalidate()
                        self.timer = nil 
                    }else{
                        
                    }
                }
            }) { (error) in
                HUD.showMessageNoImage("連接失敗")
            }
        }
    }
    func getRequestData()  {
       
        if let obj = AppJumpViewControllerManager.shareInsten.userObject  {
            if obj.transferEnable != nil {
                if obj.transferEnable! % 3 != 0 {
                     self.remainingTraffic.text = "無限流量"
                }else{
                    let a = (((obj.transferEnable ?? 0)-(obj.u ?? 0)-(obj.d ?? 0))/1024/1024/1024)
                    self.remainingTraffic.text = "\(a)G"
                }

            }

            if obj.expTime != nil {
                self.setComplete(dateString: obj.expTime!)
            }
            if obj.switch2 == 0 {
                self.switchDelect.isOn = false
            }else{
                self.switchDelect.isOn = true
            }
            VpnManager.shared.ss_port = obj.port ?? 0
            VpnManager.shared.ss_password = obj.passwd ?? ""
        }
        
        
       
        let para = ["nodeClient":"ios"]
        AppRequesionConfig.getRequest(urlString: RequestAdress.serverListURL, params: para, header: nil, success: { (json) in
            
            if let obj:[ServerListObject] = JSONDeserializer<ServerListObject>.deserializeModelArrayFrom(json: json, designatedPath: "data") as? [ServerListObject]{
                self.serverList = obj
                if self.serverList.count > 0 {
                    self.serverName.text = obj[0].nodeName
                    VpnManager.shared.ss_address = obj[0].nodeServer
                    let str = obj[0].nodeMethod.replacingOccurrences(of: "-", with: "")
                    let l = Locale.current
                    VpnManager.shared.ss_method = str.uppercased(with: l)
                }else{
                    self.serverName.text = ""
                }
                
            }
            
        }) { (error) in
            
        }
    }
    func setComplete(dateString:String)  {
        
        let calendar = Calendar.current
        let nowComp = calendar.dateComponents([.year,.month,.day], from: NSDate() as Date)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let date = dformatter.date(from: dateString)
        let comp1 = calendar.dateComponents([.year,.month,.day], from: date!)
        PrintLog(message: dateString)
        //开始比较
        if nowComp.year ?? 0 <= comp1.year ?? 0  {
            if nowComp.year ?? 0 == comp1.year ?? 0 {
                if nowComp.month ?? 0 <= comp1.month ?? 0{
                    if nowComp.month ?? 0 == comp1.month ?? 0{
                        if nowComp.day ?? 0 == comp1.day ?? 0{
                            self.validTime.text = "已過期"
                        }else{
                            self.validTime.text = dateString
                        }
                    }else{
                        self.validTime.text = dateString
                    }
                }else{
                    self.validTime.text = dateString
                }
            }else{
                self.validTime.text = dateString
            }
           
        }else {
            self.validTime.text = "已過期"
        }
    }
    func onVPNStatusChanged(){
        self.status = VpnManager.shared.vpnStatus
    }
    
    func updateConnectButton(){
        switch status {
        case .connecting:
            connectButton.setTitle("連接中...", for: UIControlState())
        case .disconnecting:
            connectButton.setTitle("斷開中...", for: UIControlState())
        case .on:
            connectButton.setTitle("已連接", for: UIControlState())
            oneLayerView.layer.removeAllAnimations()
            HUD.showMessageNoImage("連接成功")
        case .off:
            connectButton.setTitle("點擊鏈接", for: .normal)
            oneLayerView.layer.removeAllAnimations()
            HUD.showMessageNoImage("已斷開！")
        case .fail:
            connectButton.setTitle("點擊鏈接", for: .normal)
            oneLayerView.layer.removeAllAnimations()
            HUD.showMessageNoImage("連接失敗，請重新連接！")
        }
        connectButton.isEnabled = [VPNStatus.on,VPNStatus.off,VPNStatus.fail].contains(VpnManager.shared.vpnStatus)
    }
    
    @IBAction func connectTap(_ sender: AnyObject) {
        //开始连接
        self.oneLayerView.strartLoading()
        AppRequesionConfig.getRequest(urlString: RequestAdress.checkDBURL, params: nil, header: nil, success: { (json) in
            if let obj:CheckDBObject = JSONDeserializer<CheckDBObject>.deserializeFrom(json: json ?? ""){
                if obj.status == 401 {
                    AppJumpViewControllerManager.shareInsten.exitLogin()
                    VpnManager.shared.disconnect()
                    HUD.showMessageNoImage("賬號異常請，請重新登錄！")
                    self.oneLayerView.layer.removeAllAnimations()
                }else{
                    if(VpnManager.shared.vpnStatus == .off || VpnManager.shared.vpnStatus == .fail){
                        VpnManager.shared.connect()
                    }else{
                        VpnManager.shared.disconnect()
                    }
                }
            }
        }) { (error) in
            HUD.showMessageNoImage("連接失敗")
            
        }
       
    }
    @IBAction func selectServerListButtonClick(_ sender: UIButton) {
        AppJumpViewControllerManager.shareInsten.gotoServerListViewController(curViewController: self, serverList: self.serverList, selectButtonIndex: self.selectButtonIndex) { (index) in
            self.serverName.text = self.serverList[index].nodeName
            let str = self.serverList[index].nodeMethod.replacingOccurrences(of: "-", with: "")
            let l = Locale.current
            VpnManager.shared.ss_method = str.uppercased(with: l)
            VpnManager.shared.ss_address = self.serverList[index].nodeServer
            
            PrintLog(message: str.uppercased(with: l))
            self.selectButtonIndex = index
            
        }

        
    }
}

