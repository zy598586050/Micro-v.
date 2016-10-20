//
//  mapViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/15.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import KGFloatingDrawer
import Canvas

var ObjectId = ""

class mapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,DIOpenSDKDelegate {
    
    //弹出视图
    var BackgroundView: UIView!
    //阴影视图
    var ShadowView: UIView!
    
    var mainMapView: MKMapView!
    //定位管理器
    let locationManager:CLLocationManager = CLLocationManager()
    

    @IBOutlet weak var leftimg: UIBarButtonItem!
    @IBOutlet weak var rightimg: UIBarButtonItem!
    
    /**
     *左上角按钮点击事件
     */
    func left() {
        //展开左侧侧滑菜单
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void
            in
        }
        
    }
    
    /**
     *右上角按钮点击事件
     - parameter sender: UIBarButtonItem
     */
    @IBAction func right(sender: UIBarButtonItem) {
        //展开右侧侧滑菜单
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Right, animated: true) { (finished) -> Void in
        }
    }
    
    
    /**
     *定位方法
     - parameter sender: AnyObject
     */
    func button(){
        
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.01
        let longDelta = 0.01
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //定义地图区域和中心坐标（
        //使用当前位置
        let center = locationManager.location?.coordinate
        //使用自定义位置
        //let center:CLLocation = CLLocation(latitude: weidu, longitude: jindu)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center!,
                                                                  span: currentLocationSpan)
        
        //设置显示区域
        self.mainMapView.setRegion(currentRegion, animated: true)
        

    }
    
    /**
     *嘀嘀打车方法
     - parameter sender: AnyObject
     */
    func dache(sender: AnyObject){
        
        DIOpenSDK.registerApp("didi4A482F5A5A33703931446973544D3244", secret: "86e3e24914a8db1c26c3e8ef08e6b4f9")
        
        let option = DIOpenSDKRegisterOptions()
        
        DIOpenSDK.showDDPage(self, animated: true, params: option, delegate: self)
        
    }
    
    /**
     *3D俯视图方法
     - parameter sender: AnyObject
     */
    func fushi(sender: AnyObject){
        
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = (locationManager.location?.coordinate)!
        mapCamera.pitch = 45
        mapCamera.altitude = 500
        mapCamera.heading = -45
        mainMapView.setCamera(mapCamera, animated: true)

    }
    /**
     *发表说说方法
     - parameter sender: AnyObject
     */
    func shuoshuo(sender: AnyObject){

        let a = UIStoryboard(name: "Home", bundle: nil)
        let b = a.instantiateViewControllerWithIdentifier("shuoshuo") as! PublishNavigationController
        self.presentViewController(b, animated: true, completion: nil)
        
    }
    
    //
    func refreshView(notification:NSNotification){
        //self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //通知中心
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.refreshView), name: "refreshView", object: nil)
        
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
        
        
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        //创建一个打车按钮
        let taxi = UIButton(frame: CGRect(x: width-50, y: height-160, width: 35, height: 35))
        //设置按钮图片
        taxi.setImage(UIImage(named: "打车"), forState: UIControlState.Normal)
        taxi.addTarget(self, action: #selector(mapViewController.dache(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //创建一个3D俯视按钮
        let brid = UIButton(frame: CGRect(x: width-50, y: height-110, width: 35, height: 35))
        //设置按钮图片
        brid.setImage(UIImage(named: "3d"), forState: UIControlState.Normal)
        brid.addTarget(self, action: #selector(mapViewController.fushi(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //创建一个输入框按钮
        let textField = UIButton(frame: CGRect(x: width/2 - 95, y: 80, width: 200, height: 35))
        //设置按钮图片
        textField.setImage(UIImage(named: "shurukuang"), forState: UIControlState.Normal)
        textField.addTarget(self, action: #selector(mapViewController.shuoshuo(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //创建一个图片加文字的按钮
        let btn:UIButton = UIButton(frame: CGRect(x: width-300, y: height-110, width: 35, height: 35))
        btn.setImage(UIImage(named: "dingwei"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        btn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        btn.addTarget(self, action: Selector("button"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //使用代码创建
        self.mainMapView = MKMapView(frame:self.view.frame)
        //地图类型设置 - 标准地图
        self.mainMapView.mapType = MKMapType.Standard
        self.view.addSubview(self.mainMapView)
        self.view.addSubview(btn)
        self.view.addSubview(brid)
        self.view.addSubview(taxi)
        self.view.addSubview(textField)
        //大头针
        datouzheng()
        
        
        self.navigationItem.title = "地图"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
        //设置标题颜色
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
    }
    
    
    
    //获取设备是否允许使用定位服务
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.NotDetermined || status == CLAuthorizationStatus.Denied{
            ProgressHUD.showError("没有授权定位服务")
        }else{
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("方向定位开始")
            
            //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
            let latDelta = 0.01
            let longDelta = 0.01
            let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            
            //定义地图区域和中心坐标
            //使用当前位置
            let center = locationManager.location?.coordinate
            let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center!,span: currentLocationSpan)
            
            //设置显示区域
            self.mainMapView.setRegion(currentRegion, animated: true)
            
            //创建大头针
            cjdatouzheng()
                        
            //指定自定义大头针代理MKMapViewDelegate
            self.mainMapView.delegate = self
        }
    }
    
    
    /**
     *设置地图属性
     *开启位置管理器定位
     */
    func datouzheng(){
        
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 50
        //发送授权申请
        locationManager.requestAlwaysAuthorization()
        //判断是否是第一次执行
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("GuiderShowedd") {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("方向定位开始")
            //定位
            button()
            //创建大头针
            cjdatouzheng()
            //指定自定义大头针代理MKMapViewDelegate
            self.mainMapView.delegate = self
        }else{
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "GuiderShowedd")
        }
        
    }
    
    /**
     *循环创建大头针
     *绑定大头针对应数据
     */
    func cjdatouzheng(){
        

        //查询用户
        let query = AVQuery(className: "_User")
        query.selectKeys(["longitude"])
        query.selectKeys(["latitude"])
        query.selectKeys(["title"])
        query.selectKeys(["objectId"])
        query.selectKeys(["username"])
        query.selectKeys(["Motion"])
        query.findObjectsInBackgroundWithBlock({(objects,error) in
            
            for avObject in objects{
                //创建一个大头针对象
                let objectAnnotation = MyMKPointAnnotation()
                let Latitude = Double(String(avObject["latitude"]))
                let Longitude = Double(String(avObject["longitude"]))
                let Title = String(avObject["title"])
                let ID = String(avObject["objectId"])
                let IDD = String(avObject["username"])
                let motion = String(avObject["Motion"])
                print(ID)
                print(IDD)
                print(motion)
                //设置大头针的显示位置
                objectAnnotation.coordinate = CLLocation(latitude: Latitude!,
                    longitude: Longitude!).coordinate
                //设置点击大头针之后显示的标题
                objectAnnotation.title = Title
                //标示符
                objectAnnotation.tag = ID
                objectAnnotation.tag2 = IDD
                objectAnnotation.motion = motion
                //添加大头针
                self.mainMapView.addAnnotation(objectAnnotation)
            }
            
        })
        
    }
    
    //弹窗
    func TC(un:String){
        //查
        let query = AVQuery(className: "_User")
        query.whereKey("username", equalTo: un)
        query.getFirstObjectInBackgroundWithBlock({(object,error) in
            
            //**********
            //创建阴影
            let shadowView = UIView()
            //设置位置尺寸
            shadowView.frame = UIScreen.mainScreen().bounds
            //设置背景
            shadowView.backgroundColor = UIColor.blackColor()
            //设置透明度
            shadowView.alpha = 0.5
            //添加window时为力全局覆盖，包括导航栏，让界面控件全部都不可用，除了广告关闭按钮
            UIApplication.sharedApplication().keyWindow?.addSubview(shadowView)
            //赋值
            self.ShadowView = shadowView
            
            //创建view用来添加广告和关闭按钮
            let view = UIView()
            //设置尺寸和位置
            view.bounds = CGRectMake(0, 0, 227, 295)
            view.center = self.view.center
            UIApplication.sharedApplication().keyWindow?.addSubview(view)
            self.BackgroundView = view
            
            //创建弹出视图
            let bgView = CSAnimationView()
            //设置动画
            bgView.duration = 0.5
            bgView.type = "bounceUp"
            bgView.startCanvasAnimation()
            //设置圆角
            bgView.layer.cornerRadius = 10
            bgView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
            //设置大小尺寸
            bgView.frame = CGRectMake(0, 0, 227, 295)
            //添加到view上
            view.addSubview(bgView)
            
            
            //创建弹窗模版
            let tcimg = UIImageView()
            tcimg.frame = CGRectMake(0, 0, 227, 140)
            //只允许上边圆角
            let maskPath = UIBezierPath(roundedRect: tcimg.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: 10,height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = tcimg.bounds
            maskLayer.path = maskPath.CGPath
            tcimg.layer.mask = maskLayer
            //图片
            tcimg.sd_setImageWithURL(NSURL(string:String(object["img"])),placeholderImage: UIImage(named: "i1"))
            //添加
            bgView.addSubview(tcimg)
            
            //Label
            let label = UILabel()
            label.text = String(object["title"])
            label.textAlignment = NSTextAlignment.Center
            label.center = self.view.center
            label.frame = CGRectMake(0, 160, 227, 20)
            //添加
            bgView.addSubview(label)
            
            //赞，评论，分享
            let btn1 = UIButton(type: .Custom)
            btn1.frame = CGRectMake(33, 200, 35, 35)
            btn1.setImage(UIImage(named: "喜欢"), forState: .Normal)
            //添加
            bgView.addSubview(btn1)
            
            let btn2 = UIButton(type: .Custom)
            btn2.frame = CGRectMake(93, 200, 35, 35)
            btn2.setImage(UIImage(named: "评论"), forState: .Normal)
            btn2.addTarget(self, action: Selector("pinglun"), forControlEvents: .TouchUpInside)
            //添加
            bgView.addSubview(btn2)
            
            let btn3 = UIButton(type: .Custom)
            btn3.frame = CGRectMake(153, 200, 35, 35)
            btn3.setImage(UIImage(named: "分享"), forState: .Normal)
            //添加
            bgView.addSubview(btn3)
            
            //详情
            let btn = UIButton(type: .RoundedRect)
            btn.setTitle("详 情", forState: .Normal)
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            btn.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5)
            btn.layer.cornerRadius = 5
            btn.layer.masksToBounds = true
            btn.frame = CGRectMake(75, 250, 75, 25)
            btn.addTarget(self, action: Selector("xiangqing"), forControlEvents: .TouchUpInside)
            //添加
            bgView.addSubview(btn)
            
            //创建关闭按钮
            let closeBtn = UIButton()
            closeBtn.frame = CGRectMake(200, 7, 20, 20)
            closeBtn.setBackgroundImage(UIImage(named: "alphaClose"), forState: .Normal)
            //添加
            bgView.addSubview(closeBtn)
            //监听关闭按钮
            closeBtn.addTarget(self, action: Selector("closeBtnClick"), forControlEvents: .TouchUpInside)
            //**********
        })
    }
    
    //详情
    func xiangqing(){
        closeBtnClick()
        let a = UIStoryboard(name: "Home", bundle: nil)
        let b = a.instantiateViewControllerWithIdentifier("details") as! DetailsNavigationController
        self.presentViewController(b, animated: true, completion: nil)
    }
    
    //评论
    func pinglun(){
        
    }
    
    
    //监听方法
    func closeBtnClick(){
        //点击关闭按钮，所有view移除
        delay(0, task: {self.BackgroundView.boom()})
        self.ShadowView.removeFromSuperview()
        //self.BackgroundView.removeFromSuperview()
    }
    
    typealias Task = (cancel : Bool) -> ()
    
    func delay(time:NSTimeInterval, task:()->()) ->  Task? {
        
        func dispatch_later(block:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(time * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(),
                block)
        }
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        }
        
        return result;
    }
    
    func cancel(task:Task?) {
        task?(cancel: true)
    }
    
    
    /**
     *视图按钮点击方法
     
     - parameter mapView: MKMapView
     - parameter view:    MKAnnotationView
     - parameter control: UIControl
     */
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {

        let myPoint:MyMKPointAnnotation = view.annotation as! MyMKPointAnnotation
        
        if(control.tag == 1){
            
            TC(myPoint.tag2!)
            
        }else if(control.tag == 2){
            
            //新建一个聊天会话View Controller对象
            let chat = RCConversationViewController()
            //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
            chat.conversationType = RCConversationType.ConversationType_PRIVATE
            //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
            chat.targetId = myPoint.tag2!
            //设置聊天会话界面要显示的标题
            let query = AVQuery(className: "_User")
            query.whereKey("username", equalTo: myPoint.tag2!)
            query.getFirstObjectInBackgroundWithBlock({(object,error) in
                chat.title = String(object["name"])
            })
            //设置头像圆
            chat.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
            //隐藏tab bar
            chat.hidesBottomBarWhenPushed = true
            //显示聊天会话界面
            self.navigationController?.pushViewController(chat, animated: true)

        }
        
    }
    
    
    /**
     *自定义大头针样式
     
     - parameter mapView:    MKMapView
     - parameter annotation: MKAnnotation
     
     - returns: pinView
     */
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation)
        -> MKAnnotationView? {
            let myPoint:MyMKPointAnnotation = annotation as! MyMKPointAnnotation
            if annotation is MKUserLocation {
                return nil
            }
            
            let reuserId = "pin"
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuserId)
            if pinView == nil {
                //创建一个大头针视图
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
                pinView?.canShowCallout = true
                //tag
                let query = AVObject(className: "_User",objectId: myPoint.tag!)
                query.fetchInBackgroundWithBlock({(avObject,error) in
                    print(String(avObject["portrait"]))
                    //替换大头针图片
                    let img = UIImageView()
                    img.sd_setImageWithURL(NSURL(string:String(avObject["portrait"])),placeholderImage: UIImage(named: "touxiangx"))
                    pinView?.image = self.getHeadImage(img.image!,motion: myPoint.motion!)
                    //设置大头针点击注释视图的右侧按钮样式
                    let btnright = UIButton(type: .Custom)
                    btnright.frame = CGRectMake(0, 0, 35, 35)
                    btnright.tag = 2
                    btnright.setImage(UIImage(named: "消息"), forState: .Normal)

                    let btnleft = UIButton(type: .Custom)
                    btnleft.setImage(UIImage(named: "查看2"), forState: .Normal)
                    btnleft.frame = CGRectMake(0, 0, 35, 35)
                    btnleft.tag = 1
                    btnleft.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    
                    pinView?.rightCalloutAccessoryView = btnright
                    pinView?.leftCalloutAccessoryView = btnleft
                    
                })
    
            }else{
                pinView?.annotation = annotation
            }
            
            return pinView
    }

    
    /**
     *大头针头像处理
     */
    func getHeadImage(image:UIImage,motion:String)->UIImage{
        
        let frame = CGRectMake(0, 0, 40, 40)
        UIGraphicsBeginImageContext(frame.size)
        image.drawInRect(frame)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //取到裁剪完的图片
        
        let imageView: UIImageView = UIImageView(image: newImage)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.borderColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1).CGColor
        layer.borderWidth = 1
        layer.cornerRadius = CGFloat(20)
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print("motion"+String(motion))
        //取到圆形的图片
        
        let view = UIView()
        let newImageView = UIImageView()
        let subImage = UIImageView()
        
        if(motion == "1"){
            
            //天使
            view.frame = CGRectMake(0, 0, 60, 53)
            
            newImageView.frame = CGRectMake(10, 13, 40, 40)
            newImageView.image = roundedImage
            view.addSubview(newImageView)
            
            subImage.frame = CGRectMake(0, 0, 60, 53)
            subImage.image = UIImage.init(named: "天使")
            view.addSubview(subImage)
            
        }else if(motion == "0"){
        
            //恶魔
            view.frame = CGRectMake(0, 0, 48, 52)
            
            newImageView.frame = CGRectMake(4, 4, 40, 40)
            newImageView.image = roundedImage
            view.addSubview(newImageView)
            
            subImage.frame = CGRectMake(0, 0, 48, 52)
            subImage.image = UIImage.init(named: "恶魔")
            view.addSubview(subImage)
        }
    
        
        UIGraphicsBeginImageContext(view.frame.size);
        CGContextAddEllipseInRect(UIGraphicsGetCurrentContext(), frame)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newViewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //view 渲染出的图片
        return newViewImage
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /**
     *定位改变执行，可以得到新位置、旧位置
     
     - parameter manager:   CLLocationManager
     - parameter locations: [CLLocation]
     */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        print("经度：\(currLocation.coordinate.longitude)")
        let jindu = currLocation.coordinate.longitude
        //获取纬度
        print("纬度：\(currLocation.coordinate.latitude)")
        let weidu = currLocation.coordinate.latitude
        
        //将位置存储到云
        let todo = AVObject(className: "_User",objectId: ObjectId)
        todo.setObject(weidu, forKey: "latitude")
        todo.setObject(jindu, forKey: "longitude")
        todo.saveInBackground()
        
        NSNotificationCenter.defaultCenter().postNotificationName("refreshView", object: nil)
    }
    
    /**
     *关闭嘀嘀打车界面掉用的方法
     */
    func pageClose() {
        print("用户关闭了打车界面！")
    }
    
    @IBAction func close2(segue:UIStoryboardSegue){
        
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
