//
//  zhuce2ViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/13.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class zhuce2ViewController: UIViewController {

    //@IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var yanzheng1: UIButton!
    var phone1 = ""
    var pwd1 = ""
    var nicheng = ""
    var Gender:Bool = true
    var Seconds = 60
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var yanzhengma: UITextField!
    
    /**
     *短信验证方法
     - parameter sender: UIButton
     */
    @IBAction func yanzheng(sender: UIButton) {
        
        yanzheng1.enabled = false
        
        let user = AVUser()
        user.username = phone.text
        user.password = pwd1
        user["name"] = nicheng
        user["Gender"] = Gender
        user["portrait"] = touxiangurl
        user.mobilePhoneNumber = phone.text
        user.signUp(nil)
        
        //计时器
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(zhuce2ViewController.tickDown), userInfo: nil, repeats: true)
        
    }
    
    /**
     *验证码计时方法
     - parameter Timer: NSTimer
     */
    func tickDown(Timer:NSTimer){
        
        Seconds -= 1
        yanzheng1.setTitle("(\(Seconds))秒后重发", forState: UIControlState.Disabled)
        
        if(Seconds == 0){
            Timer.invalidate()
            Seconds = 60
            yanzheng1.enabled = true
            yanzheng1.setTitle("获取验证码", forState: UIControlState.Normal)
        }
        
    }
    
    /**
     *注册方法
     - parameter sender: UIButton
     */
    @IBAction func queding(sender: UIButton) {
        
        AVUser.verifyMobilePhone(yanzhengma.text, withBlock: {(succeeded: Bool, error: NSError?) in
            if(succeeded){
                ProgressHUD.showSuccess("注册成功")
                
                let a = UIStoryboard(name: "Main", bundle: nil)
                let b = a.instantiateViewControllerWithIdentifier("login") as! LogingViewController
                self.presentViewController(b, animated: true, completion: nil)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phone.text = phone1
        print(touxiangurl)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
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
