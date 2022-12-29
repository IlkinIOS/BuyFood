//
//  DetailViewController.swift
//  BuyFood
//
//  Created by Macbook 2018 on 18.12.22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    let detailViewModel = DetailViewModel()
    var foodDetails: Food?
    
    var quantity = 0

    @IBOutlet weak var detailProductImage: UIImageView!
    @IBOutlet weak var detailPeroductName: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var detailProductPrice: UILabel!
    
    @IBAction func stepper(_ sender: UIStepper) {
        let quantity = Int(sender.value + 1)
        totalPrice.text = "$\(quantity * (foodDetails?.price ?? 1))"
        quantityLbl.text = String(quantity)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPrice.text = "$\(detailProductPrice.text ?? "10")"
        if let food = foodDetails {
            detailPeroductName.text = food.name
            detailProductImage.kf.setImage(with: food.image.myImageUrl)
//            totalPrice.text = String(food.price * Int(quantityLbl.text))
            detailProductPrice.text = "$\(food.price)"
        }
    }
    
 
    @IBAction func barItemClicked(_ sender: UIBarButtonItem) {
        sender.tintColor = .red
    }
    
    @IBAction func btnAddBasket(_ sender: UIButton) {
    if let food = foodDetails, let orderAmount = Int(quantityLbl.text!) {
        print("addToCart called!")
            detailViewModel.addToCart(food: food, orderAmount: orderAmount)
        }
    }
    
}
