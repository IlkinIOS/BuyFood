import Foundation

struct FoodsModel: Codable {
    var foods: [Food]
}

struct Food: Codable {
    var id:Int
    var name:String
    var image:String
    var price:Int
    var category:String
    
}
