//
//  BasketCell.swift
//  BuyFood
//
//  Created by Ilkin Murtuzayev on 22.12.22.
//

import UIKit
import Kingfisher

class BasketCell: UITableViewCell {
   static let indentifier = "BasketCell"
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var basketTotal: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    @IBOutlet weak var basketName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    public func configure(food: CartModel) {
        productImageView.kf.setImage(with: food.image.myImageUrl)
        basketName.text = food.name
        basketTotal.text = "Total Price: \(food.orderAmount * food.price)$"
        basketPrice.text = "\(food.price)$"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
