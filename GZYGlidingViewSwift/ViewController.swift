//
//  ViewController.swift
//  GZYGlidingViewSwift
//
//  Created by zhiyuan gao on 2019/5/26.
//  Copyright © 2019 Zhiyuan Gao. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var top: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var bottom: UIButton!
    @IBOutlet weak var left: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(view1)
        view1.snp.makeConstraints({ (make) in
            make.bottom.equalTo(top.snp_top).offset(0)
            make.size.equalTo(CGSize.init(width: 200, height: 120))
            make.centerX.equalToSuperview()
        })
        view1.pdViewArrowPosition = 100
        view1.pdViewArrowDirection = .Bottom
        
        
        
        view.addSubview(view2)
        view2.snp.makeConstraints({ (make) in
            make.top.equalTo(bottom.snp_bottom).offset(0)
            make.size.equalTo(CGSize.init(width: 200, height: 120))
            make.centerX.equalToSuperview()
        })
        view2.pdViewArrowPosition = 100
        view2.pdViewArrowDirection = .Top
        
        
        view.addSubview(view3)
        view3.snp.makeConstraints({ (make) in
            make.left.equalTo(right.snp_right).offset(0)
            make.size.equalTo(CGSize.init(width: 100, height: 200))
            make.centerY.equalToSuperview()
        })
        view3.pdViewArrowPosition = 100
        view3.pdViewArrowDirection = .Left
        
        view.addSubview(view4)
        view4.snp.makeConstraints({ (make) in
            make.right.equalTo(left.snp_left).offset(0)
            make.size.equalTo(CGSize.init(width: 100, height: 200))
            make.centerY.equalToSuperview()
        })
        view4.pdViewArrowPosition = 100
        view4.pdViewArrowDirection = .Right
        
    }
    
    
    /// 根据tag上右下左轮着来
    ///
    /// - Parameter sender: sender description
    @IBAction func dd(_ sender: UIButton) {
        if sender.tag == 1{
            if view1.pdViewIsHidden {
                view1.showWithPopAnimation()
            }else{
                view1.hiddenViewWithPopAnimation()
            }
        }else if sender.tag == 2{
            if view3.pdViewIsHidden {
                view3.showWithPopAnimation()
            }else{
                view3.hiddenViewWithPopAnimation()
            }
        }else if sender.tag == 3{
            if view2.pdViewIsHidden {
                view2.showWithPopAnimation()
            }else{
                view2.hiddenViewWithPopAnimation()
            }
        }else{
            if view4.pdViewIsHidden {
                view4.showWithPopAnimation()
            }else{
                view4.hiddenViewWithPopAnimation()
            }
        }
    }
    
    var view1 : GZYPullDownListView = GZYPullDownListView.init()
    var view2 : GZYPullDownListView = GZYPullDownListView.init()
    var view3 : GZYPullDownListView = GZYPullDownListView.init()
    var view4 : GZYPullDownListView = GZYPullDownListView.init()
}

