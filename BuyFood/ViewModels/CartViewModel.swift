//
//  CartViewModel.swift
//  BuyFood
//
//  Created by Macbook 2018 on 18.12.22.
//

import Foundation
import Alamofire
import RxSwift

class CartViewModel {
    let repo = Repository()
    
    var cartProducts = BehaviorSubject<[CartModel]>(value: [])
    
    func getCart() {
        AF.upload(multipartFormData: { multiFormData in
            multiFormData.append(Data("ilkinmurtuzayev".utf8), withName: "userName")
        }, to: "http://kasimadalan.pe.hu/foods/getFoodsCart.php").responseDecodable(of: BasketModel.self) {response in
            if let data = response.data {
                print("cart products fetched!")
                do {
                    let result = try JSONDecoder().decode(BasketModel.self, from: data)
                    var tempBasketFoods = [CartModel]()
                    result.foods_cart.forEach { food in
                        print("foodName>>>\(food?.name)")
                        if food != nil {
                            tempBasketFoods.append(food!)
                        }
                    }
                    self.cartProducts.onNext(tempBasketFoods)
                }catch {
                    self.cartProducts.onNext([])
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteFromCart(cartId: Int) {
        let parameters: [String: Any] = [
            "cartId": cartId,
            "userName": "ilkinmurtuzayev"
        ]
        
        AF.request("http://kasimadalan.pe.hu/foods/deleteFood.php", method: .post, parameters: parameters).response {res in
            if res.response?.statusCode == 200 {
                self.getCart()
            }
        }
    }
}
