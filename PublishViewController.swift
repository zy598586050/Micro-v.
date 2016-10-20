//
//  PublishViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/21.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import TZImagePickerController

class PublishViewController: UIViewController,TZImagePickerControllerDelegate,LLSwitchDelegate {

    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet var WStitle: UITextField!
    @IBOutlet var img: UIButton!
    
    var KG:Bool = true
    
    func valueDidChanged(llSwitch: LLSwitch!, on: Bool) {
        
        KG = on
    }
    
    /**
     *发表方法
     */
    @IBAction func fabiao(sender: UIBarButtonItem) {
        
        //开始上传图片
        let cs = CGSize(width: 201,height: 251)
        let images = self.imageWithImageSimple((self.img.imageView?.image)!, newSize: cs)
        let data = UIImagePNGRepresentation(images)
        let file = AVFile(name: "shuoshuo.png",data: data)
        file.saveInBackgroundWithBlock({(succeeded,error) in
            let url = file.url
            //更新头像
            let todo = AVObject(className: "_User",objectId: ObjectId)
            todo.setObject(url, forKey: "img")
            todo.setObject(self.WStitle.text, forKey: "title")
            todo.setObject(self.textview.text, forKey: "neirong")
            todo.setObject(self.KG, forKey: "Motion")
            todo.saveInBackground()
        })
        //图片上传进度
        file.saveInBackgroundWithBlock({(succeeded,error) in
            if(succeeded){
                ProgressHUD.showSuccess("发表成功")
                self.dismissViewControllerAnimated(true, completion:nil)
            }else{
                ProgressHUD.showError("发表失败")
            }
            }, progressBlock: {(percentDone) in
                print(percentDone)
        })
        
    }
    
    
    /**
     *添加图片方法
     - parameter sender: UIButton
     */
    @IBAction func add(sender: UIButton) {
        
        let img = TZImagePickerController(maxImagesCount: 1,delegate: self)
        self.presentViewController(img, animated: true, completion: nil)
        
    }
    /**
     *选择图片完成后方法
     */
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        print("确定")
        img.setImage(photos[0], forState: .Normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.title = "写说说"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)
        //设置标题颜色
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        //switch
        let llSwitch = LLSwitch(frame: CGRectMake(240,65,70,40))
        self.view.addSubview(llSwitch)
        llSwitch.delegate = self
        llSwitch.setOn(true, animated: true)
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
