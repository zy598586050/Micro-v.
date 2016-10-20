//
//  DongtaiViewController.swift
//  微诉
//
//  Created by ibokan on 16/7/16.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import KGFloatingDrawer
import Canvas

var start:Bool = true

var WSCellContents = [(String,String,String)]()

class DongtaiViewController: UIViewController,UICollectionViewDataSource {
    
    var ShadowView: UIView!
    
    //拿到两个值
    let user = NSUserDefaults.standardUserDefaults().valueForKey("UserNameKey") as! String!
    let pwd = NSUserDefaults.standardUserDefaults().valueForKey("PwdKey") as! String!
    /**
     *分享方法
     */
    @IBAction func fenxiang(sender: UIButton) {
        
        TC()
        
    }
    
    /**
     *详情
     */
    func xiangqing(){
        let a = UIStoryboard(name: "Home", bundle: nil)
        let b = a.instantiateViewControllerWithIdentifier("details") as! DetailsNavigationController
        self.presentViewController(b, animated: true, completion: nil)
    }
    
    
    func TC(){
        
        //创建毛玻璃
        let shadowView = UIToolbar()
        //设置位置尺寸
        shadowView.frame = UIScreen.mainScreen().bounds
        //添加window时为力全局覆盖，包括导航栏，让界面控件全部都不可用，除了广告关闭按钮
        UIApplication.sharedApplication().keyWindow?.addSubview(shadowView)
        //赋值
        ShadowView = shadowView
        
        //分享界面上边图片
        let fximg = UIImageView()
        fximg.frame = CGRectMake(60, 50, 200, 80)
        fximg.image = UIImage(named: "compose_slogan")
        ShadowView.addSubview(fximg)
        
        //创建分享按钮
        let view1 = CSAnimationView()
        view1.frame = CGRectMake(10, 250, 100, 100)
        view1.backgroundColor = UIColor.clearColor()
        //创建动画
        view1.duration = 2.1
        view1.type = "bounceUp"
        view1.startCanvasAnimation()
        let btn1 = UIButton(type: .Custom)
        btn1.setImage(UIImage(named: "wechat"), forState: .Normal)
        btn1.frame = CGRectMake(0, 0, 100, 100)
        btn1.addTarget(self, action: Selector("weixin"), forControlEvents: .TouchUpInside)
        //添加
        ShadowView.addSubview(view1)
        view1.addSubview(btn1)
        
        let view2 = CSAnimationView()
        view2.frame = CGRectMake(110, 250, 100, 100)
        view2.backgroundColor = UIColor.clearColor()
        //设置动画
        view2.duration = 0.5
        view2.type = "bounceUp"
        view2.startCanvasAnimation()
        let btn2 = UIButton(type: .Custom)
        btn2.setImage(UIImage(named: "weibo"), forState: .Normal)
        btn2.frame = CGRectMake(0, 0, 100, 100)
        btn2.addTarget(self, action: Selector("weibo"), forControlEvents: .TouchUpInside)
        //添加
        ShadowView.addSubview(view2)
        view2.addSubview(btn2)
        
        let view3 = CSAnimationView()
        view3.frame = CGRectMake(200, 250, 100, 100)
        //设置动画
        view3.duration = 1.3
        view3.type = "bounceUp"
        view3.startCanvasAnimation()
        view3.backgroundColor = UIColor.clearColor()
        let btn3 = UIButton(type: .Custom)
        btn3.setImage(UIImage(named: "qq-1"), forState: .Normal)
        btn3.frame = CGRectMake(0, 0, 100, 100)
        btn3.addTarget(self, action: Selector("qq"), forControlEvents: .TouchUpInside)
        //添加
        ShadowView.addSubview(view3)
        view3.addSubview(btn3)
        
        
        let view4 = CSAnimationView()
        view4.frame = CGRectMake(110,150, 100, 100)
        //设置动画
        view4.duration = 0.9
        view4.type = "bounceUp"
        view4.startCanvasAnimation()
        view4.backgroundColor = UIColor.clearColor()
        let btn4 = UIButton(type: .Custom)
        btn4.setImage(UIImage(named: "friendquan"), forState: .Normal)
        btn4.frame = CGRectMake(0, 0, 100, 100)
        btn4.addTarget(self, action: Selector("friendquan"), forControlEvents: .TouchUpInside)
        //添加
        ShadowView.addSubview(view4)
        view4.addSubview(btn4)
        
        let view5 = CSAnimationView()
        view5.frame = CGRectMake(110,350, 100, 100)
        //设置动画
        view5.duration = 1.7
        view5.type = "bounceUp"
        view5.startCanvasAnimation()
        view5.backgroundColor = UIColor.clearColor()
        let btn5 = UIButton(type: .Custom)
        btn5.setImage(UIImage(named: "qqzone"), forState: .Normal)
        btn5.frame = CGRectMake(0, 0, 100, 100)
        btn5.addTarget(self, action: Selector("qqzone"), forControlEvents: .TouchUpInside)
        //添加
        ShadowView.addSubview(view5)
        view5.addSubview(btn5)
        
        
        //关闭按钮
        let closeview = UIView()
        closeview.backgroundColor = UIColor.clearColor()
        closeview.frame = CGRectMake(110, 460, 100, 100)
        let close = UIButton(type: .Custom)
        close.setImage(UIImage(named: "tabbar_compose_background_icon_add"), forState: .Normal)
        close.frame = CGRectMake(0, 0, 100, 100)
        close.addTarget(self, action: Selector("close"), forControlEvents: .TouchUpInside)
        ShadowView.addSubview(closeview)
        closeview.addSubview(close)
        
        //旋转动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //旋转角度
        anim.toValue = 0.25 * M_PI
        //旋转指定角度需要的时间
        anim.duration = 1
        //旋转重复次数
        anim.repeatCount = 1
        //动画执行完之后不移除
        anim.fillMode = kCAFillModeForwards
        anim.removedOnCompletion = false
        //将动画添加到视图上
        closeview.layer.addAnimation(anim, forKey: nil)
    }
    
    //关闭弹窗
    func close(){
        self.ShadowView.removeFromSuperview()
    }
    
    //分享方法
    func share(type:SSDKPlatformType){
        
        let shareParams = NSMutableDictionary()
        shareParams.SSDKSetupShareParamsByText("分享内容", images: UIImage(named: "touxiang"), url: NSURL(string:"http://www.zhangyubk.com"), title: "标题", type: SSDKContentType.Image)
        ShareSDK.share(type, parameters: shareParams) {(state,userData,contentEntity,error) -> Void in
            
            switch state{
            case SSDKResponseState.Success:
                ProgressHUD.showSuccess("分享成功")
                break
            case SSDKResponseState.Fail:
                ProgressHUD.showError("分享失败")
                break
            case SSDKResponseState.Cancel:
                ProgressHUD.showError("取消了分享")
                break
            default:
                break
            }
            
        }
    }
    
    //QQ分享
    func qq(){
        share(.SubTypeQQFriend)
    }
    //QQ空间
    func qqzone(){
        share(.TypeTencentWeibo)
    }
    //微信分享
    func weixin(){
        share(.TypeWechat)
    }
    //朋友圈
    func friendquan(){
        share(.SubTypeWechatTimeline)
    }
    //微博分享
    func weibo(){
        share(.TypeSinaWeibo)
    }
    
    /**
     *打开发表动态界面方法
     - parameter sender: UIBarButtonItem
     */
    @IBAction func right(sender: UIBarButtonItem) {
        
        let a = UIStoryboard(name: "Home", bundle: nil)
        let b = a.instantiateViewControllerWithIdentifier("shuoshuo") as! PublishNavigationController
        self.presentViewController(b, animated: true, completion: nil)
    }
    
    /**
     *打开左侧侧滑菜单方法
     */
    func left() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void
            in
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
         *首次加载打开引导页,再次打开将不显示引导页
         *首次登录弹出登录界面，再次打开将不显示登录界面，自动登录
         */
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.boolForKey("GuiderShowed") {
            
            
            if(start == true){
                
                let login = NSUserDefaults.standardUserDefaults()
                
                if(login.boolForKey("RmbPwdKey")){
                    
                    let query = AVQuery(className: "_User")
                    query.whereKey("username", equalTo: user)
                    query.getFirstObjectInBackgroundWithBlock({(object,error) in
                        
                        if((error) != nil){
                            
                            ProgressHUD.showError("没有此用户")
                            
                        }else{
                            
                            let name = object["name"]
                            let portrait = object["portrait"]
                            Name = name as! String
                            Touxiang = portrait as! String
                            
                            //连接容云服务器
                            RCIM.sharedRCIM().connectWithToken(self.Token(), success: {(userId) -> Void in
                                
                                print("登陆成功。当前登录的用户ID：\(userId)")
                                Me = userId
                                ProgressHUD.showSuccess("登录成功")
                                //获取用户id用来存储位置
                                let query = AVQuery(className: "_User")
                                query.whereKey("username", equalTo: Me)
                                query.getFirstObjectInBackgroundWithBlock({(object,error) in
                                    ObjectId = object.objectId
                                })
                                //左边图片按钮
                                let img = UIImageView()
                                img.frame = CGRectMake(0, 0, 35, 35)
                                img.layer.masksToBounds = true
                                img.layer.cornerRadius = 17
                                img.layer.borderWidth = 1
                                img.layer.borderColor = UIColor.whiteColor().CGColor
                                img.sd_setImageWithURL(NSURL(string:Touxiang),placeholderImage: UIImage(named: "touxiangxx"))
                                //绑定点击事件
                                let tap = UITapGestureRecognizer(target: self,action: Selector("left"))
                                img.addGestureRecognizer(tap)
                                img.userInteractionEnabled = true
                                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:img)
                                
                                AVUser.logInWithUsernameInBackground(self.user, password: self.pwd, block: {(user,error) in
                                    
                                    if ((error) != nil){
                                        
                                        ProgressHUD.showError("登录失败")
                                        
                                    }else{
                                        //设置当前登陆用户的信息
                                        RCIM.sharedRCIM().currentUserInfo = RCUserInfo.init(userId: userId, name: Name, portrait: Touxiang)
                                        
                                    }
                                    
                                })
                                
                                }, error: {(status) -> Void in
                                    
                                    print("登陆的错误码为:\(status.rawValue)")
                                    
                                }, tokenIncorrect: {
                                    //token过期或者不正确。
                                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                                    ProgressHUD.showError("token错误")
                                    
                            })
                            
                        }
                    })
                    
                }else{
                    
                    let sb = UIStoryboard(name: "Main", bundle:nil)
                    let vc = sb.instantiateViewControllerWithIdentifier("login") as! LogingViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }else{
            
            let a = UIStoryboard(name: "Main", bundle: nil)
            let b = a.instantiateViewControllerWithIdentifier("GuideController") as! PageViewController
            self.presentViewController(b, animated: true, completion: nil)
            
        }
        
        
    }
    
    /**
     *获取Token
     *获取融云分配的Token
     - returns: Token
     */
    func Token() -> String{
        
        // 获取HTML内容
        let urlstring = "http://www.zhangyubk.com/test.php?userid=" + user
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        //查询用户
        let query = AVQuery(className: "_User")
        query.selectKeys(["title"])
        query.selectKeys(["portrait"])
        query.selectKeys(["img"])
        query.findObjectsInBackgroundWithBlock({(objects,error) in
            
            obcount = objects.count
            
            for avObject in objects{
                WSCellContents.append((String(avObject["img"]),String(avObject["portrait"]),String(avObject["title"])))
            }
            collectionView.reloadData()
        })
        
        return obcount
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: RGCollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier("reuse", forIndexPath: indexPath) as! RGCollectionViewCell)
        self.configureCell(cell, indexPath: indexPath)
        cell.yuan.layer.cornerRadius = 30
        cell.yuan.layer.masksToBounds = true
        cell.yuan.layer.borderWidth = 2
        cell.yuan.layer.borderColor = UIColor.whiteColor().CGColor
        cell.xiangqing.addTarget(self, action: Selector("xiangqing"), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func configureCell(cell:RGCollectionViewCell,indexPath:NSIndexPath){
        /*let subview: UIView = cell.contentView.viewWithTag(0)!
         subview.removeFromSuperview()*/
        
        func WScase(bigimg:String,touxiang:String,title:String) {
        cell.imageView.sd_setImageWithURL(NSURL(string:bigimg),placeholderImage: UIImage(named: "i1"))
            cell.yuan.sd_setImageWithURL(NSURL(string:touxiang),placeholderImage: UIImage(named: "i1"))
            cell.mainLabel.text = title
        }
        
        WScase(WSCellContents[indexPath.section].0,touxiang: WSCellContents[indexPath.section].1,title: WSCellContents[indexPath.section].2)
        
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
