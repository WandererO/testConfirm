//
//  ServerListViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/7.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit
import HandyJSON
class ServerListViewController: BaseViewController {
    @IBOutlet weak var tabelView: UITableView!
    var selectButtonIndex:Int = 0
    var selectBtn:UIButton = UIButton()
    var obj:[ServerListObject] = [ServerListObject]()
    var action:((_ serverName:Int) -> Void)?
    var pingArray:[String : [Double]] = [String : [Double]]()
    var severArray:[String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewUI()
        
    }
    func setViewUI()  {
        self.title = "服務器列表"
        self.calculatePingValue()
        self.tabelView.register(UINib.init(nibName: "ServerListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServerListTableViewCell")
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.separatorStyle = .none
        self.leftBarBtn.action = #selector(self.leftBalckClick)
        
        
    }
    func leftBalckClick()  {
        self.navigationController?.popViewController(animated: true)
        self.action!(self.selectBtn.tag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
extension ServerListViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ServerListTableViewCell = tabelView.dequeueReusableCell(withIdentifier: "ServerListTableViewCell", for: indexPath) as! ServerListTableViewCell
        cell.selectButton.addTarget(self, action: #selector(self.selectorButtonClick(btn:)), for: .touchUpInside)
        cell.selectButton.tag = indexPath.row 
        cell.selectionStyle = .none
        
        if self.obj.count > 0 {
            if indexPath.row == self.selectButtonIndex {
                cell.selectButton.setImage(UIImage.init(named: "选中"), for: .normal)
                self.selectBtn = cell.selectButton
            }
            let data = self.obj[indexPath.row]
            if let pingArray = self.pingArray[data.nodeServer] {
                if pingArray.count > 0  {
                    cell.calculaterLabel.text = "\(String(format: "%.fms", pingArray[0]))"
                }
            }
           
            
            cell.serverName.text = data.nodeName
            cell.numberLabel.text = "\(data.nodeLoad)"
        }
        return cell
    }
    func calculatePingValue() {
        if self.obj.count > 0 {
            for (i,_) in self.obj.enumerated() {
                self.severArray.append(self.obj[i].nodeServer)
                JFPingManager.getFastestAddress(addressList:  self.severArray, finished: { (address) in
                    if let address = address {
                        self.pingArray = address
                    }
                    self.tabelView.reloadData()
                })
            }
        }
    }
    func selectorButtonClick(btn:UIButton) {
        if self.selectBtn.tag != btn.tag {
            btn.setImage(UIImage.init(named: "选中"), for: .normal)
            self.selectBtn.setImage(UIImage.init(named: "选择-2"), for: .normal)
            self.selectBtn = btn
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.obj.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
