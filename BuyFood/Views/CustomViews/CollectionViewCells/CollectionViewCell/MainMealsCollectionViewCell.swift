//
//  MainMealsCollectionViewCell.swift
//  BuyFood
//
//  Created by Ilkin Murtuzayev on 20.12.22.
//

import UIKit
import Kingfisher

class MainMealsCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainMealsCollectionViewCell"
    
    let homeViewModel = HomeViewModel()
    
    var food: Food?
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    
 
    
    func setup(MainMeals:Food) {
        food = MainMeals
        foodImage.kf.setImage(with: MainMeals.image.myImageUrl)
        foodName.text = MainMeals.name
        foodPrice.text = "$\(MainMeals.price)"
        
            
    }
    
    
    @IBAction func btnAddMeal(_ sender: UIButton) {
        if food != nil {
            homeViewModel.addToCart(food: food!, orderAmount: 1)
        }
    }
    
}
