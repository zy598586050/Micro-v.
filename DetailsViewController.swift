//
//  DetailsViewController.swift
//  微诉
//
//  Created by ibokan on 16/7/19.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ewenTextView:EwenTextView!
    
    let kScreenBounds = UIScreen.mainScreen().bounds
    var kScreenwidth:CGFloat!
    var kScreenheight:CGFloat!
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        kScreenwidth = kScreenBounds.size.width
        kScreenheight = kScreenBounds.size.height
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
        
        /**
         *设置代理方法
         */
        table.delegate = self
        table.dataSource = self
        
        self.view.addSubview(self.WSewenTextView())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //输入框方法
    func WSewenTextView() -> EwenTextView {
        if (ewenTextView == nil) {
            self.ewenTextView = EwenTextView(frame: CGRectMake(0, kScreenheight - 49, kScreenwidth, 49))
            self.ewenTextView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            self.ewenTextView.setPlaceholderText("请输入文字")
            self.ewenTextView.EwenTextViewBlock = {(test) -> Void in
                print("\(test)")
            }
        }
        return ewenTextView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailsTableViewCell
        
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
