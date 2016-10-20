//
//  wangjiViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/12.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class wangjiViewController: UIViewController {

    var Seconds = 60
    
    @IBOutlet weak var mobel: UITextField!
    @IBOutlet weak var yanzhengma: UITextField!
    @IBOutlet weak var yanzheng1: UIButton!
    @IBOutlet weak var button: UIButton!
    
    /**
     *短信验证方法
     - parameter sender: UIButton
     */
    @IBAction func yanzheng(sender: UIButton) {
        
        if(mobel.text != ""){
            AVUser.requestPasswordResetWithPhoneNumber(mobel.text, block: {(succeeded,error) in
                
                if(succeeded){
                    self.yanzheng1.enabled = false
                    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(wangjiViewController.TickDown), userInfo: nil, repeats: true)
                    self.button.enabled = true
                    
                }else{
                    ProgressHUD.showError("输入格式错误")
                }
                
            })
        }else {
            ProgressHUD.showError("未输入手机号")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始按钮不可点击
        button.enabled = false

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
        
        //设置标题颜色
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *跳转到验证界面并传值
     - parameter segue:  UIStoryboardSegue
     - parameter sender: AnyObject
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "tiao" && yanzhengma.text != ""){
            
            let dev = segue.destinationViewController as! wangji2ViewController
            dev.yanzheng = self.yanzhengma.text!
            
        }else {
            ProgressHUD.showError("未输入验证码")
        }
    }
    
    /**
     *验证码计时方法
     - parameter Timer: NSTimer
     */
    func TickDown(Timer:NSTimer){
        
        Seconds -= 1
        yanzheng1.setTitle("(\(Seconds))秒后重发", forState: UIControlState.Disabled)
        
        if(Seconds == 0){
            Timer.invalidate()
            Seconds = 60
            yanzheng1.enabled = true
            yanzheng1.setTitle("获取验证码", forState: UIControlState.Normal)
        }
        
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
