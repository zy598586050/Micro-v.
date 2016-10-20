//
//  LogingViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/12.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
var Me = ""

class LogingViewController: UIViewController,RCAnimatedImagesViewDelegate {
    
    var WS = ""

    @IBOutlet var qq: UIImageView!
    @IBOutlet var weibo: UIImageView!
    @IBOutlet var weixin: UIImageView!
    @IBOutlet weak var bgview: RCAnimatedImagesView!
    
    @IBOutlet weak var user: UITextField!
    
    @IBOutlet weak var touxiang: UIImageView!
    
    @IBOutlet weak var pwd: UITextField!
    
    @IBOutlet weak var lnview: UIView!
    
    @IBOutlet weak var login: UIButton!
    
    @IBAction func loging(sender: UIButton) {
        
        
    //查询
    let query = AVQuery(className: "_User")
    query.whereKey("username", equalTo: user.text)
    query.getFirstObjectInBackgroundWithBlock({(object,error) in
    if((error) != nil){
        
        ProgressHUD.showError("没有此用户")
        
    }else{
        
      let name = object["name"]
      let portrait = object["portrait"]
      Name = name as! String
      Touxiang = portrait as! String
                
      //连接容云服务器
      RCIM.sharedRCIM().connectWithToken(self.Token1(), success: {(userId) -> Void in
                    
      print("登陆成功。当前登录的用户ID：\(userId)")
      Me = userId
        //获取用户id用来存储位置
        let query = AVQuery(className: "_User")
        query.whereKey("username", equalTo: Me)
        query.getFirstObjectInBackgroundWithBlock({(object,error) in
            ObjectId = object.objectId
        })
        
      AVUser.logInWithMobilePhoneNumberInBackground(self.user.text, password: self.pwd.text, block: {(user,error) in
                        
      if ((error) != nil){
        
        ProgressHUD.showError("登录失败")
                        }else{
        
        ProgressHUD.showSuccess("登录成功")
        
     //自动登录
     NSUserDefaults.standardUserDefaults().setObject(self.user.text, forKey: "UserNameKey")
     NSUserDefaults.standardUserDefaults().setObject(self.pwd.text, forKey: "PwdKey")
     NSUserDefaults.standardUserDefaults().setBool(true, forKey: "RmbPwdKey")
     //设置当前登陆用户的信息
     RCIM.sharedRCIM().currentUserInfo = RCUserInfo.init(userId: userId, name: Name, portrait: Touxiang)
     //关闭当前窗口
     self.dismissViewControllerAnimated(true, completion:nil)
     start = false
     //停止RCAnimatedImages
     self.bgview.delegate = nil
     self.bgview.stopAnimating()
                            
                }
                        
    })
                    
}, error: {(status) -> Void in
                        
        print("登陆的错误码为:\(status.rawValue)")
                        
    }, tokenIncorrect: {
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        self.errorNotice("token错误")
                })
            }
        })
        
}
    
    /**
     *获取Token1
     - returns: Token1
     */
    func Token1() -> String{
        
        // 获取HTML内容
        let urlstring = "http://www.zhangyubk.com/test.php?userid=" + user.text!
        let url = NSURL(string: urlstring)
        let data = NSData(contentsOfURL: url!)
        let htmlContent = String(NSString(data: data!, encoding: NSUTF8StringEncoding))
        // 截取JSON
        let rangeOfJSON = (htmlContent.rangeOfString("{")?.startIndex)!..<(htmlContent.rangeOfString("}")?.endIndex)!
        // 解析
        let jsonData = htmlContent.substringWithRange(rangeOfJSON).dataUsingEncoding(NSUTF8StringEncoding)
        let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments)
        let token = json.objectForKey("token") as! String
        return token
        
    }
    
    
    /**
     *获取Token2
     - returns: Token2
     */
    func Token2() -> String{
        
        // 获取HTML内容
        let urlstring = "http://www.zhangyubk.com/test.php?userid=" + WS
        let url = NSURL(string: urlstring)
        let data = NSData(contentsOfURL: url!)
        let htmlContent = String(NSString(data: data!, encoding: NSUTF8StringEncoding))
        // 截取JSON
        let rangeOfJSON = (htmlContent.rangeOfString("{")?.startIndex)!..<(htmlContent.rangeOfString("}")?.endIndex)!
        // 解析
        let jsonData = htmlContent.substringWithRange(rangeOfJSON).dataUsingEncoding(NSUTF8StringEncoding)
        let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments)
        let token = json.objectForKey("token") as! String
        return token
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置头像信息
        touxiang.layer.masksToBounds = true
        touxiang.layer.borderWidth = 4
        touxiang.layer.borderColor = UIColor.whiteColor().CGColor
        touxiang.layer.cornerRadius = 50
        lnview.layer.cornerRadius = 6
        login.layer.cornerRadius = 4
        
        
        //第三方登录按钮点击手势
        //QQ
        let tap = UITapGestureRecognizer(target: self,action: Selector("QQ"))
        self.qq.addGestureRecognizer(tap)
        self.qq.userInteractionEnabled = true
        
        //微博
        let tap2 = UITapGestureRecognizer(target: self,action: Selector("Weibo"))
        self.weibo.addGestureRecognizer(tap2)
        self.weibo.userInteractionEnabled = true
        
        //微信
        let tap3 = UITapGestureRecognizer(target: self,action: Selector("Weixin"))
        self.weixin.addGestureRecognizer(tap3)
        self.weixin.userInteractionEnabled = true
        
    }
    
    /**
     *点击微博方法
     */
    func Weibo(){
        WSLogin(SSDKPlatformType.TypeSinaWeibo)
    }
    
    /**
     *点击微信方法
     */
    func Weixin(){
        ProgressHUD.showError("经费不足无法开通此服务")
        let arry:Array = ["1","2","3"]
        let todo = AVObject(className: "_User",objectId: "576390cdd342d30058dd3497")
        todo.setObject(arry, forKey: "friend")
        todo.saveInBackground()
    }
    
    /**
     *点击QQ方法
     */
    func QQ(){
        WSLogin(SSDKPlatformType.TypeQQ)
    }
    
    /**
     *第三方登录方法
     - parameter type: SSDKPlatformType
     */
    func WSLogin(type:SSDKPlatformType ){
        ShareSDK.getUserInfo(type) {(state,user,error) in
            if (state == SSDKResponseState.Success) {
                print("用户标识uid:\(user.uid)")
                self.WS = user.uid
                print("昵称:\(user.nickname)")
                print("头像:\(user.icon)")
                print("性别:\(user.gender.rawValue)")
                var WSgender:Bool = true
                if(user.gender.rawValue == 0){
                    WSgender = true
                }else if(user.gender.rawValue == 1){
                    WSgender = false
                }
                
                //保存信息
                let WSuser = AVUser()
                WSuser.username = self.WS
                WSuser.password = "WS123"
                WSuser["name"] = user.nickname
                WSuser["portrait"] = user.icon
                WSuser["Gender"] = WSgender
                WSuser.signUpInBackgroundWithBlock({ (succeeded, error) in
                    //成功OR失败
                    if(succeeded){
                        
                    }else{
                        
                    }
                })
                
                
                //查询
                let query = AVQuery(className: "_User")
                query.whereKey("username", equalTo: user.uid)
                query.getFirstObjectInBackgroundWithBlock({(object,error) in
                    if((error) != nil){
                        
                        ProgressHUD.showError("没有此用户")
                        
                    }else{
                        
                        let name = object["name"]
                        let portrait = object["portrait"]
                        Name = name as! String
                        Touxiang = portrait as! String
                        
                        //连接容云服务器
                        RCIM.sharedRCIM().connectWithToken(self.Token2(), success: {(userId) -> Void in
                            
                            print("登陆成功。当前登录的用户ID：\(userId)")
                            Me = userId
                            
                            //获取用户id用来存储位置
                            let query = AVQuery(className: "_User")
                            query.whereKey("username", equalTo: Me)
                            query.getFirstObjectInBackgroundWithBlock({(object,error) in
                                ObjectId = object.objectId
                            })
                            
                            AVUser.logInWithUsernameInBackground(self.WS, password: "WS123", block: {(user,error) in
                                
                                if ((error) != nil){
                                    print("iserror:\(error)")
                                    ProgressHUD.showError("登录失败")
                                }else{
                                    
                                    ProgressHUD.showSuccess("登录成功")
                                    
                                    //自动登录
                                    NSUserDefaults.standardUserDefaults().setObject(self.WS, forKey: "UserNameKey")
                                    NSUserDefaults.standardUserDefaults().setObject("WS123", forKey: "PwdKey")
                                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "RmbPwdKey")
                                    //设置当前登陆用户的信息
                                    RCIM.sharedRCIM().currentUserInfo = RCUserInfo.init(userId: userId, name: Name, portrait: Touxiang)
                                    //关闭当前窗口
                                    self.dismissViewControllerAnimated(true, completion:nil)
                                    start = false
                                    //停止RCAnimatedImages
                                    self.bgview.delegate = nil
                                    self.bgview.stopAnimating()
                                    
                                }
                                
                            })
                            
                            }, error: {(status) -> Void in
                                
                                print("登陆的错误码为:\(status.rawValue)")
                                
                            }, tokenIncorrect: {
                                //token过期或者不正确。
                                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                                self.errorNotice("token错误")
                        })
                    }
                })
                
                
            }
            else
            {
                print("没有成功：\(error)");
            }
        }
    }
    
    //空白收起键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "login\(index + 1)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.bgview.delegate = self
        self.bgview.startAnimating()
        
        
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        
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
