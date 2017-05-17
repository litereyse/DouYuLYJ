//
//  PageTitleView.swift
//  DYLYJ
//
//  Created by Student on 2017/5/17.
//  Copyright © 2017年 lyj. All rights reserved.
//  封装顶部PageTitleView,为了其他界面也可以复用，单独封装

import UIKit

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {
   
    //定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles:[String]
    
    //懒加载属性--滑块view
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //添加顶部线
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView()
       scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
   
    //构造函数
    init(frame: CGRect , titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{
    fileprivate func setupUI(){
        //1.添加UIscrollView
      addSubview(scrollView)
      scrollView.frame = bounds
      
    }

    fileprivate func setupTitleLabels(){
        //确定label的一些frame的值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        //动态加载标题
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.blue
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            
            
        }
        
        
        
    
    
    }
    


}
