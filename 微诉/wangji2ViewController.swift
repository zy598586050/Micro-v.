//
//  wangji2ViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/15.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class wangji2ViewController: UIViewController {
    
    var yanzheng = ""
    var password = ""

    @IBOutlet weak var newpwd: UITextField!
    @IBOutlet weak var new2pwd: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    /**
     *修改密码方法
     - parameter sender: UIButton
     */
    @IBAction func btnok(sender: UIButton) {
        
        if(newpwd.text == new2pwd.text){
            
            password = new2pwd.text!
            
        }else{
            
            ProgressHUD.showError("两次密码不一致")
            
        }
        
        AVUser.resetPasswordWithSmsCode(yanzheng, newPassword: new2pwd.text, block: {(succeeded,error) in
            
            if(succeeded){
                
                ProgressHUD.showSuccess("修改成功")
                
                let a = UIStoryboard(name: "Main", bundle: nil)
                let b = a.instantiateViewControllerWithIdentifier("login") as! LogingViewController
                self.presentViewController(b, animated: true, completion: nil)
                
            }else{
                
                ProgressHUD.showError("修改失败")
                
            }
            
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
