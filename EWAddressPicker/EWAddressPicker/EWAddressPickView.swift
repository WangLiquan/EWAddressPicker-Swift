//
//  EWAddressPickView.swift
//  EWAddressPicker
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit
///  view的三种状态,控制tableView展示效果与数据
enum EWLocationPickViewTableViewType {
    case provinces  //省份
    case city       //城市
    case area       //地区
}

class EWAddressPickView: UIView {
    /// 返回数据回调
    public var backLocationString: ((String,String,String,String)->())?
    /// 推出回调
    public var backOnClickCancel: (()->())?
    /// title选中以及下滑线颜色
    public var selectColor: UIColor 

    private var tableViewType: EWLocationPickViewTableViewType = .provinces{
        didSet{
            switch tableViewType {
            case .provinces:
                /// 选择省份时,有上面的热门城市view.没有滚动选择type的titleScrollView.没有已选择label.
                self.tableView.tableHeaderView = tableViewHeaderView
                self.tableView.frame = CGRect(x: 0, y: 42, width: UIScreen.main.bounds.width, height: 458)
                self.titleSV.isHidden = true
                self.leftLabel.isHidden = true
                /// 将所有选中数据清空
                self.provincesModel = nil
                self.selectedProvince = ""
                self.selectedCity = ""
                self.selectedArea = ""
                self.cityModel = nil
                // 将titleSV中所有button的title重置
                // 并将第一个button设置为选中状态,已保证选择城市后button下的横线有滚动效果.
                for button in buttonArr {
                    button.setTitle("请选择", for: .normal)
                    button.isSelected = false
                    if button.tag == 0{
                        button.isSelected = true
                    }
                }
                self.underLine.center = CGPoint(x: self.buttonArr[1].center.x, y: self.underLine.center.y)
                self.dataArray = locationModel?.provincesArray
                self.tableView.reloadData()
            case .city:
                /// 选择城市时没有热门城市view,并将titleSV显示出来
                self.tableView.tableHeaderView = UIView()
                self.tableView.frame = CGRect(x: 0, y: 136, width: UIScreen.main.bounds.width, height: 367)
                self.titleSV.isHidden = false
                self.leftLabel.isHidden = false
                /// 将省份选择保留,将城市与地区数据清空
                self.selectedCity = ""
                self.selectedArea = ""
                self.cityModel = nil
                /// 通过修改titleSV中button的选中状态来修改它的颜色
                for button in buttonArr {
                    button.isSelected = false
                    if button.tag != 0{
                        button.setTitle("请选择", for: .normal)
                    }
                    if button.tag == 1{
                        button.isSelected = true
                    }
                }
                /// 滚动titleSV中button下滚动的Line
                UIView.animate(withDuration: 0.3, animations: {() -> Void in
                    self.underLine.center = CGPoint(x: self.buttonArr[1].center.x, y: self.underLine.center.y)
                })
                self.dataArray = provincesModel?.cityArray
                self.tableView.reloadData()
            case .area:
                /// 选择地区时没有上方热门城市View,有titleSV
                self.tableView.tableHeaderView = UIView()
                self.tableView.frame = CGRect(x: 0, y: 136, width: UIScreen.main.bounds.width, height: 367)
                self.titleSV.isHidden = false
                self.leftLabel.isHidden = false
                /// 通过修改titleSV中button的选中状态来修改它的颜色
                for button in buttonArr {
                    button.isSelected = false
                    if button.tag == 2{
                        button.isSelected = true
                    }
                }
                /// 滚动titleSV中button下滚动的Line
                UIView.animate(withDuration: 0.3, animations: {() -> Void in
                    self.underLine.center = CGPoint(x: self.buttonArr[2].center.x, y: self.underLine.center.y)
                })
                self.dataArray = cityModel?.areaArray
                self.tableView.reloadData()
            }
        }
    }
    /// titleSV上的三个button,通过array保存,更好操作
    private var buttonArr = [UIButton]()
    /// 已选中的省份
    private var selectedProvince = ""{
        didSet{
            /// 当选中赋值时,将titleSV上第一个button.title改为省份名
            for button in buttonArr{
                if button.tag == 0{
                    button.setTitle(selectedProvince, for: .normal)
                }
            }
        }
    }
    /// 已选中城市
    private var selectedCity = ""{
        didSet{
            /// 当选中赋值时,将titleSV上第二个button.title改为城市名
            for button in buttonArr{
                if button.tag == 1{
                    button.setTitle(selectedCity, for: .normal)
                }
            }
        }
    }
    private var selectedArea = ""
    /// 总城市数据
    private var locationModel: EWCountryModel?
    /// 省份数据
    private var provincesModel: EWProvincesModel?
    /// 城市数据
    private var cityModel: EWCityModel?
    /// 当前tableView使用的数据源
    private var dataArray: Array<String>?
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - 100) / 2, y: 9, width: 100, height: 24))
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.text = "选择国家地区"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private let rightCancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 42, y: 11, width: 18, height: 18))
        button.setImage(UIImage(named: "BaseVC_cancel"), for: .normal)
        return button
    }()
    private let leftLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 24, y: 43, width: 40, height: 18))
        label.text = "已选择"
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    /// 热门城市数组,可修改,若修改数量需要修改下方tableViewHeaderView.frame;若修改城市需要修改onClickHotCity()方法来实现点击跳转功能
    private let hotCityArray = ["北京","上海","广州","深圳","杭州","南京","苏州","天津","武汉","长沙","重庆","成都"]
    private lazy var tableViewHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160))
        let label = UILabel(frame: CGRect(x: 24, y: 0, width: 50, height: 18))
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "热门城市"
        view.addSubview(label)
        for i in 0..<12 {
            let button: UIButton = UIButton(frame: CGRect(x: CGFloat(24 + 80 * (i % 4)), y: CGFloat(28 + 40 * (i / 4)), width: 80, height: 40))
            button.setTitle(hotCityArray[i], for: .normal)
            button.setTitleColor(UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.addTarget(self, action: #selector(onClickHotCity(sender:)), for: .touchUpInside)
            button.tag = i
            view.addSubview(button)
        }
        return view
    }()
    /// 上方选择省份城市地区的滚动scrollView
    private var titleSV: UIScrollView!
    /// titleSV上button下的滚动线
    private var underLine = UIView()
    private var tableView = UITableView(frame: CGRect(x: 0, y:42 , width: UIScreen.main.bounds.width, height: 458))

    init(frame: CGRect, selectColor: UIColor) {
        self.selectColor = selectColor
        super.init(frame: frame)
        initLocationData()
        drawMyView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawMyView(){
        self.backgroundColor = UIColor.white
        buildTitleScrollView()
        drawTableView()
        self.addSubview(titleLabel)
        self.addSubview(rightCancelButton)
        rightCancelButton.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
        self.addSubview(leftLabel)
    }
    private func buildTitleScrollView() {
        if titleSV != nil {
            titleSV.removeFromSuperview()
        }
        buttonArr = []
        titleSV = UIScrollView(frame: CGRect(x: 0, y: 72, width: UIScreen.main.bounds.width, height: 44))
        self.underLine = UIView(frame: CGRect(x: 0, y: 40, width: 30, height: 2))
        self.underLine.backgroundColor = selectColor
        for i in 0..<3{
            let button = UIButton(frame: CGRect(x: 24 + CGFloat(i) * (UIScreen.main.bounds.width - 47) / 3, y: 0, width: UIScreen.main.bounds.width / 3, height: 44))
            button.tag = Int(i)
            if i == 1 {
                button.isSelected = true
                underLine.center.x = button.center.x
            }
            button.setTitle("请选择", for: .normal)
            button.setTitleColor(UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1), for: .normal)
            button.setTitleColor(selectColor, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.addTarget(self, action: #selector(onClickTitlebutton(sender:)), for: .touchUpInside)
            buttonArr.append(button)
            titleSV.addSubview(button)
        }
        titleSV.showsVerticalScrollIndicator = false
        titleSV.addSubview(self.underLine)
        titleSV.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
        titleSV.isHidden = true
        self.addSubview(titleSV)
    }
    private func drawTableView(){
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = tableViewHeaderView
        tableView.showsVerticalScrollIndicator = false
        tableView.register(EWAddressPickViewTableViewCell.self, forCellReuseIdentifier: EWAddressPickViewTableViewCell.identifier)
        tableView.register(EWAddressPickViewFirstTableViewCell.self, forCellReuseIdentifier: EWAddressPickViewFirstTableViewCell.identifier)
    }
    /// 退出
    @objc private func onClickCancelButton(){
        if self.backOnClickCancel != nil{
            backOnClickCancel!()
        }
    }
    @objc private func onClickHotCity(sender: UIButton){
        switch sender.tag {
        case 0:
            setHotCityData(province: "北京市", city: "北京市")
        case 1:
            setHotCityData(province: "上海市", city: "上海市")
        case 2:
            setHotCityData(province: "广东省", city: "广州市")
        case 3:
            setHotCityData(province: "广东省", city: "深圳市")
        case 4:
            setHotCityData(province: "浙江省", city: "杭州市")
        case 5:
            setHotCityData(province: "江苏省", city: "南京市")
        case 6:
            setHotCityData(province: "江苏省", city: "苏州市")
        case 7:
            setHotCityData(province: "天津市", city: "天津市")
        case 8:
            setHotCityData(province: "湖北省", city: "武汉市")
        case 9:
            setHotCityData(province: "湖南省", city: "长沙市")
        case 10:
            setHotCityData(province: "重庆市", city: "重庆市")
        case 11:
            setHotCityData(province: "四川省", city: "成都市")
        default:
            break
        }
        self.tableViewType = .area
    }
    /// 选择view.type
    @objc private func onClickTitlebutton(sender: UIButton){
        guard !sender.isSelected else { return }
        switch sender.tag {
        case 0:
            self.tableViewType = .provinces
        case 1:
            self.tableViewType = .city
        default:
            break
        }
    }
    /// 点击热门城市中的城市
    private func setHotCityData(province: String,city: String){
        self.provincesModel = self.locationModel?.countryDictionary[province]
        self.selectedProvince = province
        self.cityModel = self.provincesModel?.provincesDictionary[city]
        self.selectedCity = city
    }
    /// 从area.plist获取全部地区数据
    private func initLocationData(){
        let dic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "area", ofType: "plist")!) as! Dictionary<String,Any>
        locationModel = EWCountryModel(dic: dic as! Dictionary<String, Dictionary<String, Array<String>>>)
        dataArray = locationModel?.provincesArray
    }
}
extension EWAddressPickView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)! + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  EWAddressPickViewFirstTableViewCell.identifier) as? EWAddressPickViewFirstTableViewCell else {
                return EWAddressPickViewFirstTableViewCell()
            }
            cell.label.text = "请选择"
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  EWAddressPickViewTableViewCell.identifier) as? EWAddressPickViewTableViewCell else {
            return EWAddressPickViewTableViewCell()
        }
        cell.label.text = self.dataArray?[indexPath.row - 1]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        switch tableViewType {
        case .provinces:
            /// 当前为选择省份状态时,保存选中省份,刷新状态为选择城市
            selectedProvince = (self.locationModel?.provincesArray[indexPath.row - 1])!
            self.provincesModel = self.locationModel?.countryDictionary[selectedProvince]
            self.tableViewType = .city
        case .city:
            /// 当前为选择城市状态时,保存选中城市,刷新状态为选择地区
            selectedCity = (self.provincesModel?.cityArray[indexPath.row - 1])!
            self.cityModel = self.provincesModel?.provincesDictionary[selectedCity]
            self.tableViewType = .area
        case .area:
            /// 当前为选择地区状态时,保存选中地区,执行回调block.将选中数据回调
            selectedArea = self.dataArray![indexPath.row - 1]
            let selectLocation = selectedProvince + " " + selectedCity + " " + selectedArea
            if backLocationString != nil{
                backLocationString!(selectLocation,selectedProvince,selectedCity,selectedArea)
            }
            break
        }

    }
}

