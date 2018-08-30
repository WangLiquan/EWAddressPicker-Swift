//
//  ViewController.swift
//  EWAddressPicker
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 250, width: ScreenInfo.Width - 100, height: 50))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor.colorWithRGBA(r: 255, g: 51, b: 102, a: 1)
        return label
    }()
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 450, width: ScreenInfo.Width - 200, height: 50))
        button.addTarget(self, action: #selector(onClickSelectButton), for: .touchUpInside)
        button.setTitleColor(UIColor.colorWithRGBA(r: 255, g: 51, b: 102, a: 1), for: .normal)
        button.setTitle("选择地址", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(label)
        self.view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func onClickSelectButton(){
        let addressPicker = EWAddressViewController()
        addressPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        // 返回选择数据,地址,省,市,区
        addressPicker.backLocationStringController = { (address,province,city,area) in
            self.label.text = address
        }
        self.present(addressPicker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

