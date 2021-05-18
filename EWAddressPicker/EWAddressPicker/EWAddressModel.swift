//
//  EWAddressModel.swift
//  EWAddressPicker
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation

struct EWCountryModel {
    var provincesArray: [EWProvincesModel] = []
    init(dic: [String:[String:[String]]]) {
        for (key,value) in dic {
            let model = EWProvincesModel(name: key, dic: value)
            provincesArray.append(model)
            provincesArray.sort { a, b in
                a.provincesName < b.provincesName
            }
        }
    }
}

struct EWProvincesModel {
    var provincesName: String = ""
    var cityArray: [EWCityModel] = []
    init(name : String ,dic:[String: [String]]) {
        provincesName = name
        for (key,value) in dic {
            let model = EWCityModel(name: key, Arr: value)
            cityArray.append(model)
            cityArray.sort { a, b in
                a.cityName < b.cityName
            }
        }
    }
}

struct EWCityModel {
    var cityName: String = ""
    var areaArray: [String] = []
    init(name: String,Arr: [String]) {
        cityName = name
        for str in Arr {
            areaArray.append(str)
        }
        areaArray.sort(by: <)
    }
}
