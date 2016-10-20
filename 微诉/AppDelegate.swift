//
//  AppDelegate.swift
//  微诉
//
//  Created by ibokan on 16/6/12.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import AVOSCloud
import KGFloatingDrawer
import TZImagePickerController
import MJRefresh

var Name = ""
var Portrait = ""
var Touxiang = ""
var obcount:Int = 0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RCIMUserInfoDataSource{

    var window: UIWindow?
    
    private var _drawerViewController: KGDrawerViewController?
    var drawerViewController: KGDrawerViewController {
        get {
            if let viewController = _drawerViewController {
                return viewController
            }
            return prepareDrawerViewController()
        }
    }
    
    func prepareDrawerViewController() -> KGDrawerViewController {
        
        let drawerViewController = KGDrawerViewController()
        drawerViewController.centerViewController = viewControllerForStoryboardId("center")
        drawerViewController.leftViewController = viewControllerForStoryboardId("left")
        drawerViewController.rightViewController = viewControllerForStoryboardId("right")
        //背景图片
        drawerViewController.backgroundImage = UIImage(named: "login3")
        
        _drawerViewController = drawerViewController
        return drawerViewController
    }
    private func drawerStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        return storyboard
    }
    private func viewControllerForStoryboardId(storyboardId: String) -> UIViewController {
        let viewController: UIViewController = drawerStoryboard().instantiateViewControllerWithIdentifier(storyboardId) 
        return viewController
    }
    
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Tab Bar
        UITabBar.appearance().tintColor = UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
        
        //连接LeanCloud
        AVOSCloud.setApplicationId("Ss3dcllv5ddRMzTUiYh8pHXq-gzGzoHsz", clientKey: "QXLoIFjH14If7i2vUKiYswmF")
        //连接融云
        RCIM.sharedRCIM().initWithAppKey("pvxdm17jxyq5r")
        
        //设置用户信息提供者，需要提供正确的用户信息，否则SDK无法显示用户头像、用户名和本地通知
        
        RCIM.sharedRCIM().userInfoDataSource = self
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = drawerViewController
        window?.makeKeyAndVisible()
        
        
        /**
         *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
         *  在将生成的AppKey传入到此方法中。
         *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
         *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
         *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
         */
        
        ShareSDK.registerApp("149c2b9567338",
                             //新浪微博，腾讯微博，QQ，微信
                             activePlatforms: [SSDKPlatformType.TypeSinaWeibo.rawValue,
                                SSDKPlatformType.TypeTencentWeibo.rawValue,SSDKPlatformType.TypeQQ.rawValue,
                                SSDKPlatformType.TypeWechat.rawValue,],
                             onImport: {(platform : SSDKPlatformType) -> Void in
                                
                                switch platform{
                                    
                                case SSDKPlatformType.TypeWechat:
                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                    
                                case SSDKPlatformType.TypeQQ:
                                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                                case SSDKPlatformType.TypeSinaWeibo:
                                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                                default:
                                    break
                                }
            },
                             onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                                switch platform {
                                    
                                case SSDKPlatformType.TypeSinaWeibo:
                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                    appInfo.SSDKSetupSinaWeiboByAppKey("3317729855",
                                        appSecret : "ecd60b2919d198027ddec49b00cea66c",
                                        redirectUri : "https://api.weibo.com/oauth2/default.html",
                                        authType : SSDKAuthTypeBoth)
                                    break
                                    
                                case SSDKPlatformType.TypeWechat:
                                    //设置微信应用信息
                                    appInfo.SSDKSetupWeChatByAppId("wxcc309116e7c06a1e", appSecret: "0ab50ffdff9555953e8f42f602479472")
                                    break
                                    
                                case SSDKPlatformType.TypeTencentWeibo:
                                    //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                                    appInfo.SSDKSetupTencentWeiboByAppKey("801307650",
                                        appSecret : "ae36f4ee3946e1cbb98d6965b0b2ff5c",
                                        redirectUri : "http://www.sharesdk.cn")
                                    break
                                case SSDKPlatformType.TypeQQ:
                                    //设置QQ应用信息
                                    appInfo.SSDKSetupQQByAppId("1105520506", appKey: "RzEmp91TOnLw58Ku", authType: "http://www.zhangyubk.com")
                                    break
                                default:
                                    break
                                    
                                }
        })
        
        return true
    }
    
    
    //用户信息提供者。您需要在completion中返回userId对应的用户信息，SDK将根据您提供的信息显示头像和用户名
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        print("用户信息提供者，getUserInfoWithUserId:\(userId)")
        //查询
        let query = AVQuery(className: "_User")
        query.whereKey("username", equalTo: userId)
        query.getFirstObjectInBackgroundWithBlock({(object,error) in
            let uname = object["name"] as! String
            let ttxiang = object["portrait"] as! String
            completion(RCUserInfo(userId: userId, name: uname, portrait: ttxiang))
        })
        
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    

}

