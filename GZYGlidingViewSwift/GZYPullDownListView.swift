//
//  GZYPullDownListView.swift
//  WalDiamond
//
//  Created by ios004 on 2019/5/24.
//  Copyright © 2019 Wal-Diamond. All rights reserved.
//

import UIKit

enum PDViewArrowDirection {
    case Top
    case Left
    case Right
    case Bottom
}

class GZYPullDownListView: UIView {
    
    /** 箭头顶点偏移量 */
    var pdViewArrowPosition : CGFloat = 0
    /** 圆角弧度 */
    var pdViewCornerRadius: CGFloat = 5.0
    /** 箭头大小(请将箭头朝上的视角设置) */
    var pdViewArrowSize : CGSize = CGSize.init(width: 8.0, height: 9.0)
    /** 是否隐藏*/
    var pdViewIsHidden : Bool = true
    /** 箭头方向 默认朝上*/
    var pdViewArrowDirection : PDViewArrowDirection = PDViewArrowDirection.Top
    /** 视图高度*/
    private var viewTopY : CGFloat = 0.0
    private var viewBottomY : CGFloat = 0.0
    private var viewLeftX : CGFloat = 0.0
    private var viewRightX : CGFloat = 0.0
    private var arrowBeginPoint : CGPoint = CGPoint.init(x: 0, y: 0)
    private var arrowEndPoint : CGPoint = CGPoint.init(x: 0, y: 0)
    
    /** 箭头位置*/
    private var customPoint : CGPoint = CGPoint.init(x: 0, y: 0)
    
    private var drawRectCompelete : Bool = false
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        self.isHidden = true
        pdViewIsHidden = true
    }
    /// 解档
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /// swift控件懒加载和定义写在一起
    lazy private var tableView : UITableView = {
        let tableView = UITableView.init(frame: self.frame, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

}

extension GZYPullDownListView : UITableViewDelegate ,UITableViewDataSource{
    
    /// 添加控件
    private func addUI(){
        self.addSubview(tableView)
    }
    
    /// tableview 的 datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    /// tableview 的 delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


// MARK: - 画界面的扩展
extension GZYPullDownListView{
    
    /// 动画展示视图
    func showWithPopAnimation(){
        showWithPopAnimation(position: pdViewArrowPosition)
    }
    
    /// 动画展示视图
    ///
    /// - Parameter arrowPoint: 箭头位置
    func showWithPopAnimation(position : CGFloat){
        showWithPopAnimation(position: pdViewArrowPosition, cornerRadius: pdViewCornerRadius)
    }
    
    /// 动画展示视图
    ///
    /// - Parameters:
    ///   - arrowPoint: 箭头位置
    ///   - cornerRadius: 圆角度数
    func showWithPopAnimation(position : CGFloat ,cornerRadius : CGFloat){
        pdViewCornerRadius = cornerRadius
        pdViewArrowPosition = position
        setNeedsLayout()
        layoutIfNeeded()
        if !self.drawRectCompelete {
            calculateOrigin()
            drawView()
        }
        
        let oldFrame = self.frame
        self.isHidden = false
        pdViewIsHidden = false
        layer.anchorPoint = CGPoint.init(x: customPoint.x / frame.width, y: customPoint.y / frame.height)
        frame = oldFrame
        transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    /// 隐藏视图
    func hiddenViewWithPopAnimation(){
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        }) { (compelete) in
            self.isHidden = true
            self.pdViewIsHidden = true
            self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }
    }
    
    private func drawView(){
        let maskPath = UIBezierPath()
        drawLeftTopCorner(maskPath: maskPath) // 左上
        if pdViewArrowDirection == .Top {
            drawArrow(maskPath: maskPath)
        }
        drawRightTopCorner(maskPath: maskPath) // 右上
        if pdViewArrowDirection == .Right {
            drawArrow(maskPath: maskPath)
        }
        drawRightBottomCorner(maskPath: maskPath) // 右下
        if pdViewArrowDirection == .Bottom {
            drawArrow(maskPath: maskPath)
        }
        drawLeftBottomCorner(maskPath: maskPath) // 左下
        if pdViewArrowDirection == .Left {
            drawArrow(maskPath: maskPath)
        }
        
        maskPath.close()
        
        /// ⤵️截取圆角和箭头
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        // 圆角
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = self.bounds
        shapeLayer.path = maskPath.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
        
        drawRectCompelete = true
    }
    
    //MARK:画圆角的方法
    private func drawLeftTopCorner(maskPath : UIBezierPath){
        // 左上圆角
        maskPath.move(to: CGPoint.init(x: viewLeftX, y: pdViewCornerRadius + viewTopY))
        maskPath.addArc(withCenter: CGPoint.init(x: pdViewCornerRadius + viewLeftX, y: pdViewCornerRadius + viewTopY), radius: pdViewCornerRadius, startAngle: CGFloat(180 * Double.pi/180), endAngle: CGFloat(270 * Double.pi / 180), clockwise: true)
    }
    
    private func drawRightTopCorner(maskPath : UIBezierPath){
        // 右上圆角
        maskPath.addLine(to: CGPoint.init(x: viewRightX - pdViewCornerRadius, y: viewTopY))
        maskPath.addArc(withCenter: CGPoint.init(x: viewRightX - pdViewCornerRadius, y: pdViewCornerRadius + viewTopY), radius: pdViewCornerRadius, startAngle: CGFloat(270 * Double.pi/180), endAngle: CGFloat(0 * Double.pi / 180), clockwise: true)
    }
    
    private func drawRightBottomCorner(maskPath : UIBezierPath){
        // 右下圆角
        maskPath.addLine(to: CGPoint.init(x: viewRightX, y: viewBottomY - pdViewCornerRadius))
        maskPath.addArc(withCenter: CGPoint.init(x: viewRightX - pdViewCornerRadius, y: viewBottomY - pdViewCornerRadius), radius: pdViewCornerRadius, startAngle: CGFloat(0 * Double.pi/180), endAngle: CGFloat(90 * Double.pi / 180), clockwise: true)
    }
    
    private func drawLeftBottomCorner(maskPath : UIBezierPath){
        // 左下圆角
        maskPath.addLine(to: CGPoint.init(x: pdViewCornerRadius + viewLeftX, y: viewBottomY))
        maskPath.addArc(withCenter: CGPoint.init(x: pdViewCornerRadius + viewLeftX, y: viewBottomY - pdViewCornerRadius), radius: pdViewCornerRadius, startAngle: CGFloat(90 * Double.pi/180), endAngle: CGFloat(180 * Double.pi / 180), clockwise: true)
    }
    
    
    //MARK:画箭头的方法
    private func drawArrow(maskPath : UIBezierPath){
        
        maskPath.addLine(to: arrowBeginPoint)
        maskPath.addLine(to: customPoint)
        maskPath.addLine(to: arrowEndPoint)
        
//        maskPath.addQuadCurve(to: CGPoint.init(x:customPoint.x - 1, y: 1), controlPoint: CGPoint.init(x: customPoint.x - 2, y: arrowH - 2))
//        
//        maskPath.addQuadCurve(to: CGPoint.init(x:customPoint.x + 1, y:1), controlPoint: customPoint)
//
//        maskPath.addQuadCurve(to: CGPoint.init(x: customPoint.x + arrowW, y: arrowH), controlPoint: CGPoint.init(x: customPoint.x + arrowW / 2 + 2, y: arrowH + 2))
    }
    
    /// 计算视图如何画出来
    private func calculateOrigin(){
        switch pdViewArrowDirection {
        case .Right:
            viewTopY = 0
            customPoint = CGPoint.init(x: self.frame.width, y: pdViewArrowPosition)
            viewBottomY = self.frame.height
            arrowBeginPoint = CGPoint.init(x: self.frame.width - pdViewArrowSize.height, y: pdViewArrowPosition - pdViewArrowSize.width / 2)
            arrowEndPoint = CGPoint.init(x: self.frame.width - pdViewArrowSize.height, y: pdViewArrowPosition + pdViewArrowSize.width / 2)
            viewLeftX = 0
            viewRightX = self.frame.width - pdViewArrowSize.width
            break
        case .Left:
            viewTopY = 0
            customPoint = CGPoint.init(x: 0, y: pdViewArrowPosition)
            viewBottomY = self.frame.height
            arrowBeginPoint = CGPoint.init(x: pdViewArrowSize.height, y: pdViewArrowPosition + pdViewArrowSize.width / 2)
            arrowEndPoint = CGPoint.init(x: pdViewArrowSize.height, y: pdViewArrowPosition - pdViewArrowSize.width / 2)
            viewLeftX = pdViewArrowSize.height
            viewRightX = self.frame.width
            break
        case .Bottom:
            customPoint = CGPoint.init(x: pdViewArrowPosition, y: self.frame.height)
            viewTopY = 0
            viewBottomY = self.frame.height - pdViewArrowSize.height
            arrowBeginPoint = CGPoint.init(x: customPoint.x + pdViewArrowSize.width/2, y: self.frame.height - pdViewArrowSize.height)
            arrowEndPoint = CGPoint.init(x: customPoint.x - pdViewArrowSize.width/2, y: self.frame.height - pdViewArrowSize.height)
            viewRightX = self.frame.width
            break
        default:
            customPoint = CGPoint.init(x: pdViewArrowPosition, y: 0)
            viewTopY = pdViewArrowSize.height
            viewBottomY = self.frame.height
            viewRightX = self.frame.width
            arrowBeginPoint = CGPoint.init(x: customPoint.x - pdViewArrowSize.width/2, y: pdViewArrowSize.height)
            arrowEndPoint = CGPoint.init(x: customPoint.x + pdViewArrowSize.width/2, y: pdViewArrowSize.height)
            break
        }
    }
}
