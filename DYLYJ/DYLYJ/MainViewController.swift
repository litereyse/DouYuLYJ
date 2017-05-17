//
//  MainViewController.swift
//  DYLYJ
//
//  Created by Student on 2017/5/17.
//  Copyright © 2017年 lyj. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    fileprivate func addChildVC(storyName:String) {
//        //1.通过 UIStoryboard 获取控制器
//        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
//        //2.将 childVC 作为自控制器
//        addChildViewController(childVC)
//        
//    }
    fileprivate func addChildVc(_ storyName : String) {
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVc作为子控制器
        addChildViewController(childVc)
    }
 

}
