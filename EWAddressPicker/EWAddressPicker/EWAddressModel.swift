//
//  EWAddressModel.swift
//  EWAddressPicker
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation

struct EWCountryModel {
    var countryDictionary: [String:EWProvincesModel] = [:]
    var provincesArray: [String] = []
    init(dic: [String:[String:[String]]]) {
        for (key,value) in dic {
            let model = EWProvincesModel(dic: value)
            countryDictionary[key] = model
            provincesArray.append(key)
        }
    }
}
struct EWProvincesModel {
    var provincesDictionary: [String: EWCityModel] = [:]
    var cityArray: [String] = []
    init(dic:[String: [String]]) {
        for (key,value) in dic {
            let model = EWCityModel(Arr: value)
            provincesDictionary[key] = model
            cityArray.append(key)
        }
    }
}
struct EWCityModel {
    var areaArray: [String] = []
    init(Arr: [String]) {
        for str in Arr {
            areaArray.append(str)
        }
    }
}
