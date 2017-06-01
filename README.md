# CXMChartView
一个简易的轻量级的画折线图类库
前几天接到业务需求 需要画折线图，网上也看了许多的资料，也有许多封装好的第三方类库比如`AAChartKit `、`XYPieChart`、`PNChart`等好多，不过这些类库大多封装的太厉害了，我这边的业务需求有比较简单，就是单纯的绘制折线图并保证是平滑的曲线，而且要有添加渐变阴影。说下我的思路：
* 先画整个表的横纵坐标系
* 画出纵坐标延伸的网格线
* 添加横纵坐标数字
* 绘制折线
* 变成平滑曲线
* 绘制渐变阴影
最后得到效果是这样的

![animiation.gif](http://upload-images.jianshu.io/upload_images/1977395-de6821625821ae3d.gif?imageMogr2/auto-orient/strip)
