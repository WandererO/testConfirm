//
//  WebViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/11.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: BaseViewController {
    var titleLabel: String? = ""
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
        
    }
    func setViewUI()  {
        self.title = titleLabel
        let wkWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(wkWebView)
        if let url = url{
            let request = URLRequest.init(url: URL.init(string: url)!)
            wkWebView.load(request)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
