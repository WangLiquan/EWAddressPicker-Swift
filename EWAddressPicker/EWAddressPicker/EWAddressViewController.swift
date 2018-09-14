//
//  EWAddressViewController.swift
//  EWAddressPicker
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class EWAddressViewController: UIViewController {

    var backLocationStringController: ((String,String,String,String)->())?

    lazy var containV: EWAddressPickView = {
        let view = EWAddressPickView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 550, width: UIScreen.main.bounds.width, height: 550))
        view.backOnClickCancel = {
            self.onClickCancel()
        }
        /// 成功选择后将数据回调,并推出视图
        view.backLocationString = { (address,province,city,area) in
            if self.backLocationStringController != nil{
                self.backLocationStringController!(address,province,city,area)
                self.onClickCancel()
            }
        }
        return view
    }()
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
        // Do any additional setup after loading the view.
    }
    func drawMyView()   {
        self.view.insertSubview(self.backgroundView, at: 0)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom//viewcontroller弹出后之前控制器页面不隐藏 .custom代表自定义
        self.view.addSubview(self.containV)
        // 转场动画代理
        self.transitioningDelegate = self
    }

    ///点击推出
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: onClick
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK: - 转场动画delegate
extension EWAddressViewController:UIViewControllerTransitioningDelegate{
    /// 推入动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = EWAddressPickerPresentAnimated(type: .present)
        return animated
    }
    /// 推出动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = EWAddressPickerPresentAnimated(type: .dismiss)
        return animated
    }
}

