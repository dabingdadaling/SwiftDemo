//
//  MainTabBarController.swift
//  XBSwiftTabbarController
//
//  Created by xiebin on 2018/4/5.
//  Copyright © 2018年 xiebin. All rights reserved.
//写于清明节

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置当前控制器对应tabBar的颜色
        tabBar.tintColor = UIColor.orange
         // 1.获取json文件的路径
        let path = Bundle.main.path(forResource: "MainVCSettings.geojson", ofType: nil)
        // 2.通过文件路径创建NSData
        if let jsonPath = path {
            let jsonData = NSData(contentsOfFile: jsonPath)
            do {
                let dictArr = try JSONSerialization.jsonObject(with: jsonData! as Data, options: .mutableContainers)
                for dict in dictArr as! [[String : Any]] {
                    addChildController(VCName: dict["vcName"] as! String, imgName: dict["imageName"] as! String, title: dict["title"] as! String)
                }
            }catch {
                print(error)
            }
        }
        
    }

    //添加子控制器
    func addChildController(VCName : String ,imgName : String,title : String) {
       // -1.动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 0 .将字符串转换为类
        // 0.1默认情况下命名空间就是项目的名称, 但是命名空间名称是可以修改的
        let cls : AnyClass = NSClassFromString(ns + "." + VCName)!
        // 0.2通过类创建对象
        // 0.2.1将AnyClass转换为指定的类型
        let vcCls = cls as! UIViewController.Type
        // 0.2.2通过class创建对象
        let vc = vcCls.init()
        // 设置tabbarItem属性
        vc.tabBarItem.image = UIImage(named: imgName)
        vc.tabBarItem.selectedImage = UIImage(named: imgName + "_highlighted")
        vc.tabBarItem.title = title
        vc.title = title
        let r = CGFloat(arc4random()%256)/255.0
        let g = CGFloat(arc4random()%256)/255.0
        let b = CGFloat(arc4random()%256)/255.0
        
        vc.view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 0.9)
        //嵌套导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        // 添加子控制器
        addChildViewController(nav)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
