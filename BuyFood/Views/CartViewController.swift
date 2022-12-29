//
//  CartViewController.swift
//  BuyFood
//
//  Created by Macbook 2018 on 18.12.22.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  let cartViewModel = CartViewModel()
    
    
    var cartFoods: [CartModel] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName:BasketCell.indentifier, bundle: nil), forCellReuseIdentifier: BasketCell.indentifier)
        tableView.delegate = self
        tableView.dataSource = self
        _ = cartViewModel.cartProducts.subscribe( onNext: { cartFoods in
            self.cartFoods = cartFoods
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel.getCart()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = cartFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.indentifier, for: indexPath) as! BasketCell
        cell.configure(food: product)
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, bool in
            let cartId = self.cartFoods[indexPath.row].cartId
            self.cartViewModel.deleteFromCart(cartId: cartId)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
