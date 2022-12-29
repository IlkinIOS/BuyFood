import Foundation
import RxSwift
import Alamofire

class HomeViewModel {
    var foods = BehaviorSubject<[Food]>(value: [Food]())
    let repo = Repository()
    
    
    init() {
        getFoods()
    }
    
    func getFoods(){
        let url = "http://kasimadalan.pe.hu/foods/getAllFoods.php"
        AF.request(url, method: .get).response {response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(FoodsModel.self, from: data)
                    self.foods.onNext(result.foods)
                }catch {
                    print(error)
                }
            }
            
        }
    }
    func addToCart(food: Food, orderAmount: Int) {
        repo.addToCart(food: food, orderAmount: orderAmount) { _, _, _ in
            print("added")
        }
    }
}
