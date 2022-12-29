//
//  Extension.swift
//  BuyFood
//
//  Created by Ilkin Murtuzayev on 18.12.22.
//

import Foundation
extension String {
    var myImageUrl:URL? {
        return URL(string: "http://kasimadalan.pe.hu/foods/images/\(self)")
    }
}
