# EWAddressPicker
[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)

Swift.地址选择器

## 实现效果:
controller弹出时:半透明背景渐变展示.地址选择器从下方弹出.

地址选择器:以省份,城市,地区三级进行选择,数据来自本地plist文件.有12个热门城市供快速选择,选择错误可以回选.

选择地区时进行将数据回调到上一控制器,点击页面空白区域退出controller.

controller消失时:背景渐变消失,地址选择器向下退出.

  
![效果图预览](https://github.com/WangLiquan/EWAddressPicker/raw/master/images/demonstration.gif)

## 使用方法:
将EWAddressPicker文件夹拖入项目,调用时:
```
let addressPicker = EWAddressViewController()
/*** 可使用这种init方法自定制选中颜色,不填写selectColor默认颜色为UIColor(red: 79/255, green: 176/255, blue: 255/255, alpha: 1),蓝色
let addressPicker = EWAddressViewController(selectColor: UIColor.yellow)
*/
// 返回选择数据,地址,省,市,区
addressPicker.backLocationStringController = { (address,province,city,area) in
    self.label.text = address
}
self.present(addressPicker, animated: true, completion: nil)
```

## 另:
OC版本: [EWAddressPicker-OC](https://github.com/WangLiquan/EWAddressPicker-OC)
