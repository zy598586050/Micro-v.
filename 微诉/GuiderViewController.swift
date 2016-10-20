//
//  GuiderViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/12.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class GuiderViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var page: UIPageControl!
    
    @IBOutlet weak var btn: UIButton!
    
    /**
     *跳转到主界面
     - parameter sender: UIButton
     */
    @IBAction func btnok(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "GuiderShowed")
    }
    
    var index = 0
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.layer.cornerRadius = 4;
        page.currentPage = index
        img.image = UIImage(named: imageName)
        
        if index == 3 {
            btn.hidden = false
            btn.setTitle("  马上体验  ", forState: .Normal)
        }else{
            btn.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
