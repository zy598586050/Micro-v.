//
//  ModifyViewController.swift
//  微诉
//
//  Created by ibokan on 16/7/9.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var img: UIButton!
    @IBOutlet var chumodi: UITextField!
    @IBOutlet var gongsi: UITextField!
    @IBOutlet var zhiye: UITextField!
    @IBOutlet var aihao: UITextField!
    @IBOutlet var ganqing: UITextField!
    @IBOutlet var qianmin: UITextField!
    @IBOutlet var xuexiao: UITextField!
    var JSimg = ""
    var JSchumodi = ""
    var JSgongsi = ""
    var JSzhiye = ""
    var JSaihao = ""
    var JSganqing = ""
    var JSqianmin = ""
    var JSxuexiao = ""
    
    /**
     *弹出本地相册方法
     - parameter sender: UIButton
     */
    @IBAction func touxiang(sender: UIButton) {
        
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
     *修改方法
     - parameter sender: UIButton
     */
    @IBAction func xiugai(sender: UIButton) {
        
        let todo = AVObject(className: "_User",objectId: ObjectId)
        todo.setObject(qianmin.text, forKey: "qianming")
        todo.setObject(ganqing.text, forKey: "qinggan")
        todo.setObject(aihao.text, forKey: "aihao")
        todo.setObject(zhiye.text, forKey: "zhiye")
        todo.setObject(gongsi.text, forKey: "gongsi")
        todo.setObject(chumodi.text, forKey: "dizhi")
        todo.setObject(xuexiao.text, forKey: "xuexiao")
        todo.saveInBackground()
        //关闭当前窗口
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qianmin.text = JSqianmin
        ganqing.text = JSganqing
        aihao.text = JSaihao
        zhiye.text = JSzhiye
        gongsi.text = JSgongsi
        chumodi.text = JSchumodi
        xuexiao.text = JSxuexiao
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //空白收起键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
                let url = file.url
                //更新头像
                let todo = AVObject(className: "_User",objectId: ObjectId)
                todo.setObject(url, forKey: "portrait")
                todo.saveInBackground()
            })
            //图片上传进度
            file.saveInBackgroundWithBlock({(succeeded,error) in
                if(succeeded){
                    ProgressHUD.showSuccess("头像上传成功")
                }else{
                    ProgressHUD.showError("头像上传失败")
                }
                }, progressBlock: {(percentDone) in
                    print(percentDone)
                    //self.shangchuan.setTitle("\(percentDone)%", forState: UIControlState.Disabled)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
