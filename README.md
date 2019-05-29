# SwiftPulldownMenu
## swift编写  动画式展示一个带有箭头的视图  需要自定义视图内部的内容   提供箭头方向、视图圆角、箭头大小等一些设置(详见demo) 
## 注意：在视图内添加控件需要流出箭头高度（后期会修改此bug）
<img src="https://github.com/imzhiyuanxiaopo/SwiftPulldownMenu/blob/master/GZYGlidingViewSwift/demo.gif" width="300" height="550" />

示例：
~~~
view1.pdViewArrowDirection = .Bottom
        view1.backgroundColor = UIColor.yellow
        view1.pdViewBorderWidth = 4
        view1.pdViewBorderColor = UIColor.gray.cgColor
        view1.pdViewArrowPosition = 50
        view1.pdViewCornerRadius = 20
~~~

