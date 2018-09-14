//
//  EWAddressModel.swift
//  EWAddressPicker
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation

struct EWCountryModel {
    var countryDictionary: Dictionary<String,EWProvincesModel> = [:]
    var provincesArray: [String] = []
    init(dic:Dictionary<String,Dictionary<String,Array<String>>>){
        for (key,value) in dic{
            let model = EWProvincesModel(dic: value)
            countryDictionary[key] = model
            provincesArray.append(key)
        }
    }
}
struct EWProvincesModel{
    var provincesDictionary: Dictionary<String,EWCityModel> = [:]
    var cityArray: [String] = []
    init(dic:Dictionary<String,Array<String>>){
        for (key,value) in dic{
            let model = EWCityModel(Arr: value)
            provincesDictionary[key] = model
            cityArray.append(key)
        }
    }
}
struct EWCityModel{
    var areaArray: Array<String> = []
    init(Arr:Array<String>){
        for str in Arr{
            areaArray.append(str)
        }
    }
}

