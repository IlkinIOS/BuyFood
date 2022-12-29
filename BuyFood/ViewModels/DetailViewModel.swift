//
//  DetailViewModel.swift
//  BuyFood
//
//  Created by Macbook 2018 on 18.12.22.
//

import Foundation

class DetailViewModel {
    let repo = Repository()
    
    func addToCart(food: Food, orderAmount: Int) {
        repo.addToCart(food: food, orderAmount: orderAmount) { _, _, _ in
            print("added")
        }
    }
}
