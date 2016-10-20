//
//  rightViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/15.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class rightViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var Name = ["于总","胡志远","白亚杰","olingcat","大众欧巴","暗恋悲剧","宿酒","翠花来杯茶","镜花水月"]
    var Img = ["007","002","003","004","005","006","001","008","009"]

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *设置代理方法
         */
        table.delegate = self
        table.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RightTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.touxiang.image = UIImage(named: Img[indexPath.row])
        cell.name.text = Name[indexPath.row]
        
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
