//
//  leftViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/15.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class leftViewController: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var gender: UIImageView!
    @IBOutlet var qianmin: UILabel!
    @IBOutlet var qinggan: UILabel!
    @IBOutlet var aihao: UILabel!
    @IBOutlet var zhiye: UILabel!
    @IBOutlet var gongsi: UILabel!
    @IBOutlet var xuexiao: UILabel!
    @IBOutlet var dizhi: UILabel!
    @IBOutlet weak var imgtx: UIImageView!
    
    /**
     *下方退出按钮退出方法
     - parameter sender: UIButton
     */
    @IBAction func tuichu(sender: UIButton) {
        
        let a = UIStoryboard(name: "Main", bundle: nil)
        let b = a.instantiateViewControllerWithIdentifier("login") as! LogingViewController
        self.presentViewController(b, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *设置头像的边框粗细
         *设置头像的边框颜色
         */
        imgtx.layer.masksToBounds = true
        imgtx.layer.borderWidth = 2
        imgtx.layer.borderColor = UIColor.whiteColor().CGColor
        imgtx.layer.cornerRadius = 37
        
        //计时器
        //NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(leftViewController.jiazai), userInfo: nil, repeats: true)
    }
    
    /**
     *延时加载个人资料
     */
    func jiazai(Timer:NSTimer){
        
        let query = AVQuery(className: "_User")
        query.whereKey("username", equalTo: Me)
        query.getFirstObjectInBackgroundWithBlock({(object,error) in
            self.name.text = String(object["name"])
            self.qianmin.text = String(object["qianming"])
            self.qinggan.text = String(object["qinggan"])
            self.aihao.text = String(object["aihao"])
            self.zhiye.text = String(object["zhiye"])
            self.gongsi.text = String(object["gongsi"])
            self.xuexiao.text = String(object["xuexiao"])
            self.dizhi.text = String(object["dizhi"])
            self.imgtx.sd_setImageWithURL(NSURL(string:Touxiang),placeholderImage: UIImage(named: "touxiangxx"))
            let genderr = String(object["Gender"])
            print(genderr)
            if(genderr == "1"){
                self.gender.image = UIImage(named: "男")
            }else if (genderr == "0"){
                self.gender.image = UIImage(named: "女")
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "xiugai"){
                
            let dev = segue.destinationViewController as! ModifyViewController
            dev.JSchumodi = dizhi.text!
            dev.JSxuexiao = xuexiao.text!
            dev.JSgongsi = gongsi.text!
            dev.JSzhiye = zhiye.text!
            dev.JSaihao = aihao.text!
            dev.JSganqing = qinggan.text!
            dev.JSqianmin = qianmin.text!
        }
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
