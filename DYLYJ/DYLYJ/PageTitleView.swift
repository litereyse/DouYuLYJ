//
//  PageTitleView.swift
//  DYLYJ
//
//  Created by Student on 2017/5/17.
//  Copyright © 2017年 lyj. All rights reserved.
//  封装顶部PageTitleView,为了其他界面也可以复用，单独封装

import UIKit
//定义协议
protocol  PageTitleViewDelegate :class {
    func pageTitleView(_ titleView : PageTitleView ,selectIndex index :Int)
}



// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {
   
    //定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles:[String]
    weak var delegate : PageTitleViewDelegate?
    
    //懒加载属性--标签头部
    fileprivate lazy var titleLabels :[UILabel] = [UILabel]()
    
    //懒加载属性--滑块view
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //懒加载属性--添加顶部线
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView()
       scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
   
    //构造函数
    init(frame: CGRect , titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
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
        
        // 2.添加title对应的Label
        setupTitleLabels()
       
        // 3.设置底线和滚动的滑块
        setupBottomLineAndSCrollLine()
    }

    //添加标题标签
    fileprivate func setupTitleLabels(){
        //确定label的一些frame的值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        //动态加载标题
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.blue
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
        }
  
    }
    

    // 设置底线和滚动的滑块
    fileprivate func setupBottomLineAndSCrollLine(){
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.lightGray
        //设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView{

    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        // 0.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex  {
            return
        }
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor.red
        oldLabel.textColor = UIColor.blue
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations:{
           self.scrollLine.frame.origin.x = scrollLineX
        })
        //通知代理
        delegate?.pageTitleView(self, selectIndex: currentIndex)
    }
}
// MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(_ progress : CGFloat,sourceIndex : Int,targetIndex :Int){
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)----未实现

        
        // 4.记录最新的index
        currentIndex = targetIndex
 
    }
}







