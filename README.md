# EWAddressPicker
<h3>Swift.地址选择器</h3>

# 实现效果:
controller弹出时:半透明背景渐变展示.地址选择器从下方弹出.

地址选择器:以省份,城市,地区三级进行选择,数据来自本地plist文件.有12个热门城市供快速选择,选择错误可以回选.

选择地区时进行将数据回调到上一控制器,点击页面空白区域退出controller.

controller消失时:背景渐变消失,地址选择器向下退出.



<br>

![效果图预览](https://github.com/WangLiquan/EWAddressPicker/raw/master/images/demonstration.gif)

# 使用方法:
将EWAddressPicker文件夹拖入项目,调用时:
```
let addressPicker = EWAddressViewController()
addressPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
// block返回选择数据,address:完整地址,province:省,city:市,area:区
addressPicker.backLocationStringController = { (address,province,city,area) in
    ///在此使用返回数据
    self.label.text = address
}
self.present(addressPicker, animated: true, completion: nil)
```
