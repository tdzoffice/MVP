//
//  Shop.swift
//  MVP
//
//  Created by MAC on 01/03/2024.
//

import Foundation

struct Shop {
    var address: String
    var cluster: String
    var shopDescription: String
    var expireOn: String
    var foodCategory: String
    var shopID: String
    var img1: String
    var img2: String
    var img3: String
    var isHalalCertified: Bool
    var latitude: String
    var longitude: String
    var name: String
    var phone: String
    var preserved1: String
    var preserved2: String
    var remark: String
    var shopType: String
    var socialMediaLink: String
    
    init(address: String, cluster: String, shopDescription: String, expireOn: String, foodCategory: String, shopID: String, img1: String, img2: String, img3: String, isHalalCertified: Bool, latitude: String, longitude: String, name: String, phone: String, preserved1: String, preserved2: String, remark: String, shopType: String, socialMediaLink: String) {
        self.address = address
        self.cluster = cluster
        self.shopDescription = shopDescription
        self.expireOn = expireOn
        self.foodCategory = foodCategory
        self.shopID = shopID
        self.img1 = img1
        self.img2 = img2
        self.img3 = img3
        self.isHalalCertified = isHalalCertified
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.phone = phone
        self.preserved1 = preserved1
        self.preserved2 = preserved2
        self.remark = remark
        self.shopType = shopType
        self.socialMediaLink = socialMediaLink
    }
}
