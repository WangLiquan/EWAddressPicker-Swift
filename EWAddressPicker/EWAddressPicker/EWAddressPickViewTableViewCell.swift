//
//  CRLocationPickViewTableViewCell.swift
//  Group
//
//  Created by 新用户 on 2018/8/2.
//  Copyright © 2018年 Chuangrong. All rights reserved.
//

import UIKit

class EWAddressPickViewTableViewCell: UITableViewCell {
    static let identifier = "EWAddressPickViewTableViewCell"

    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 42, y: 8, width: 200, height: 24))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.x333333
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        drawMyView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawMyView() {
        self.addSubview(label)
    }
}

class EWAddressPickViewFirstTableViewCell: UITableViewCell {
    static let identifier = "EWAddressPickViewFirstTableViewCell"

    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 24, y: 11.5, width: 100, height: 17))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.x666666
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        drawMyView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawMyView() {
        self.addSubview(label)
    }
}
