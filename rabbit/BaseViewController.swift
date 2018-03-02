//
//  BaseViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/12.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var leftBarBtn = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGroundImage()
        setLeftBarButton()
        
    }
    func setBackGroundImage() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let dict:NSDictionary = [NSForegroundColorAttributeName: UIColor.black,NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [String : Any]
    }
    func setLeftBarButton(){
        leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
                                         action: #selector(backToPrevious))
        leftBarBtn.image = UIImage(named: "返回")?.withRenderingMode(.alwaysOriginal)
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -10;
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        }
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
