//
//  HomeViewController.swift
//  DYLYJ
//
//  Created by Student on 2017/5/17.
//  Copyright © 2017年 lyj. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {
 
    let  titles = ["小学","初中","高中"]
    
    fileprivate lazy var pageTitleView :PageTitleView = {
     [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavBarH - kTitleViewH - kTabBarH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendVc())
        childVcs.append(HandsVC())
//        childVcs.append(AmuseVC())
//        childVcs.append(GameVC())
//        childVcs.append(FunnyVC())
        //        for _ in 0..<(self?.titles.count)! {
        //            let vc = UIViewController()
        //            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        //            childVcs.append(vc)
        //        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        contentView.delegate = self
        return contentView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController{
    fileprivate func setupUI(){
       automaticallyAdjustsScrollViewInsets = false
       view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectIndex index: Int) {
       pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController :PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

