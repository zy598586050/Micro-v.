//
//  XiaoxiViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/16.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import KGFloatingDrawer

class XiaoxiViewController: RCConversationListViewController {

    @IBOutlet weak var lefttx: UIBarButtonItem!
    
    /**
     *左上角按钮点击事件
     - parameter sender: UIBarButtonItem
     */
    func left() {
        //展开左侧侧滑菜单
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void
            in
        }
    }
    @IBOutlet weak var rightdh: UIBarButtonItem!
    
    /**
     *菜单
     - parameter sender: UIBarButtonItem
     */
    @IBAction func right(sender: UIBarButtonItem) {
        
        let menuArray = [KxMenuItem.init("扫一扫",image: UIImage(named: "扫一扫"),target: self,action: "clickMenu"),KxMenuItem.init("加好友",image: UIImage(named: "加好友"),target: self,action: "clickMenu")]
        
        KxMenu.setTitleFont(UIFont(name: "HelveticaNeue", size: 15))
        
        let options = OptionalConfiguration(arrowSize: 9,  //指示箭头大小
            marginXSpacing: 7,  //MenuItem左右边距
            marginYSpacing: 9,  //MenuItem上下边距
            intervalSpacing: 25,  //MenuItemImage与MenuItemTitle的间距
            menuCornerRadius: 6.5,  //菜单圆角半径
            maskToBackground: true,  //是否添加覆盖在原View上的半透明遮罩
            shadowOfMenu: false,  //是否添加菜单阴影
            hasSeperatorLine: true,  //是否设置分割线
            seperatorLineHasInsets: false,  //是否在分割线两侧留下Insets
            textColor: Color(R: 0, G: 0, B: 0),  //menuItem字体颜色
            menuBackgroundColor: Color(R: 1, G: 1, B: 1)  //菜单的底色
        )
        let a = CGRect(x: self.view.frame.width-27, y: 70, width: 0, height: 0)
        KxMenu.showMenuInView(self.view, fromRect: a, menuItems: menuArray, withOptions: options)
    }
    
    /*菜单点击方法*/
    func clickMenu(sender: AnyObject){
        print(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //左边图片按钮
        let img = UIImageView()
        img.frame = CGRectMake(0, 0, 35, 35)
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 17
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.whiteColor().CGColor
        img.sd_setImageWithURL(NSURL(string:Touxiang),placeholderImage: UIImage(named: "touxiangxx"))
        //绑定点击方法
        let tap = UITapGestureRecognizer(target: self,action: Selector("left"))
        img.addGestureRecognizer(tap)
        img.userInteractionEnabled = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:img)
        
        
        //设置需要显示哪些类型的会话
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue,
            RCConversationType.ConversationType_DISCUSSION.rawValue,
            RCConversationType.ConversationType_CHATROOM.rawValue,
            RCConversationType.ConversationType_GROUP.rawValue,
            RCConversationType.ConversationType_APPSERVICE.rawValue,
            RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue,
            RCConversationType.ConversationType_GROUP.rawValue])
        
        
        self.navigationItem.title = "会话列表"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
        //设置标题颜色
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        //self.setConversationAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
        self.refreshConversationTableViewIfNeeded()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //重写RCConversationListViewController的onSelectedTableRow事件
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        //打开会话界面
        let chat = RCConversationViewController(conversationType: model.conversationType, targetId: model.targetId)
        chat.targetId = model.targetId
        chat.userName = model.conversationTitle
        chat.title = model.conversationTitle
        //设置背景
        //chat.conversationMessageCollectionView.backgroundColor = UIColor.blueColor()
        //设置头像圆
        chat.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
        //隐藏tab bar
        chat.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(chat, animated: true)
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
