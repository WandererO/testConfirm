//
//  PromoteViewController.swift
//  rabbit
//
//  Created by 周城滨 on 2017/12/25.
//  Copyright © 2017年 yicheng. All rights reserved.
//

import UIKit

class PromoteViewController: BaseViewController {

    @IBOutlet weak var urlStr: UILabel!
    var id:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlStr.text = "https://cross.todobo.com/user/register.php?uid=" + "\(id)"
        self.title = "我的推廣碼"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func copyButtonClick(_ sender: UIButton) {
        let paste = UIPasteboard.general
        paste.string = urlStr.text
        HUD.showMessageNoImage("複製成功")
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
