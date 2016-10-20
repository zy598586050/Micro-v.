//
//  zhuceViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/12.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

var touxiangurl = ""

class zhuceViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var trueOrfalse:Bool = true
    @IBAction func gender(sender: UISwitch) {
        
        if(sender.on == true){
            trueOrfalse = true
        }else{
            trueOrfalse = false
        }
    }
    
    @IBOutlet weak var shangchuan: UIButton!
    @IBOutlet weak var zhuce1: UIButton!
    @IBOutlet weak var img: UIButton!
    @IBOutlet weak var qrmm: UITextField!
    @IBOutlet weak var nc: UITextField!
    @IBOutlet weak var mobel: UITextField!
    
    @IBOutlet weak var pwd: UITextField!
    
    /**
     *弹出本地相册方法
     - parameter sender: UIButton
     */
    @IBAction func btnimg(sender: UIButton) {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //设置是否允许编辑
            picker.allowsEditing = true
            //弹出控制器，显示界面
            self.presentViewController(picker,animated:true,completion:{() -> Void in
                
            })
        }else{
            print("读取失败")
        }
        
    }
    
    /**
     *选择图片成功后方法
     - parameter picker: UIImagePickerController
     - parameter info:   [String : AnyObject]
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //获取选择的原图并编辑
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        img.imageView?.image = image
        //图片控制器退出
        picker.dismissViewControllerAnimated(true, completion: {() -> Void in
            
            //开始上传图片
            let cs = CGSize(width: 100,height: 100)
            let images = self.imageWithImageSimple((self.img.imageView?.image)!, newSize: cs)
            let data = UIImagePNGRepresentation(images)
            let file = AVFile(name: "touxiang.png",data: data)
            file.saveInBackgroundWithBlock({(succeeded,error) in
                //print(file.url)
                touxiangurl = file.url
            })
            //图片上传进度
            file.saveInBackgroundWithBlock({(succeeded,error) in
                if(succeeded){
                    ProgressHUD.showSuccess("头像上传成功")
                    self.zhuce1.enabled = true
                }else{
                    ProgressHUD.showError("头像上传失败")
                }
                }, progressBlock: {(percentDone) in
                    print(percentDone)
            })
        })
    }
    
    //图片等比例压缩
    func imageWithImageSimple(image:UIImage,newSize:CGSize)->UIImage
    {
        var width:CGFloat!
        var height:CGFloat!
        //等比例缩放
        if image.size.width/newSize.width >= image.size.height / newSize.height{
            width = newSize.width
            height = image.size.height / (image.size.width/newSize.width)
        }else{
            height = newSize.height
            width = image.size.width / (image.size.height/newSize.height)
        }
        let sizeImageSmall = CGSizeMake(width, height)
        //end
        print(sizeImageSmall)
        
        UIGraphicsBeginImageContext(sizeImageSmall);
        image.drawInRect(CGRectMake(0,0,sizeImageSmall.width,sizeImageSmall.height))
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return newImage
    }
    
    @IBAction func zhuce(sender: UIButton) {
        
        //self.performSegueWithIdentifier("yanzheng", sender: self)
                
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        zhuce1.enabled = false
        
        nc.becomeFirstResponder()
        
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
     *验证两次输入的密码是否一致
     - parameter segue:  UIStoryboardSegue
     - parameter sender: AnyObject
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(pwd.text == qrmm.text){
            if(segue.identifier == "yanzheng"){
                
                let dev = segue.destinationViewController as! zhuce2ViewController
                dev.phone1 = mobel.text!
                dev.pwd1 = pwd.text!
                dev.nicheng = nc.text!
                dev.Gender = trueOrfalse
                
            }
        }else{
            ProgressHUD.showError("两次密码不一致")
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
