//
//  Repo.swift
//  BuyFood
//
//  Created by Macbook 2018 on 18.12.22.
//

import Foundation
import Alamofire
import RxSwift

class Repository {
    
    let baseURL = "http://kasimadalan.pe.hu/foods/"
    
    func getFoods() -> [Food]{
        let url = baseURL + "getAllFoods.php"
        
        var foods = [Food]()
        AF.request(url, method: .get).response {response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(FoodsModel.self, from: data)
                    foods = result.foods
                }catch {
                    print(error)
                }
            }
            
        }
        return foods
    }
    
    public func addToCart(food: Food, orderAmount: Int, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let fullURL = baseURL + "insertFood.php"
        let parameters: [String: Any] = [
            "name": food.name,
            "image": food.image,
            "price": food.price,
            "category": food.category,
            "orderAmount": orderAmount,
            "userName": "ilkinmurtuzayev"
        ]
        AF.request(fullURL, method: .post, parameters: parameters).response {res in
        }
    }
    
}
