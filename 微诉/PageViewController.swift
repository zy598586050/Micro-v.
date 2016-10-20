//
//  PageViewController.swift
//  微诉
//
//  Created by ibokan on 16/6/12.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    var images = ["地图","个人资料","聊天","分享-1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置代理
        dataSource = self
        
        if let staringVC = viewControllerAtIndex(0) {
            setViewControllers([staringVC], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuiderViewController).index
        
        index += 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuiderViewController).index
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> GuiderViewController? {
        if case 0 ..< images.count = index {
            if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuidContentController") as? GuiderViewController {
                contentVC.imageName = images[index]
                contentVC.index = index
                return contentVC
            }
        }
        return nil
    }
    
    /*func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
