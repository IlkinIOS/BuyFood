//
//  ViewController.swift
//  BuyFood
//
//  Created by Ilkin Murtuzayev on 18.12.22.
//

import UIKit

class HomeViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
   
    var foods = [Food]()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        MyCollectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        _ = homeViewModel.foods.subscribe(onNext: { allFoods in
            self.foods = allFoods
            DispatchQueue.main.async {
                self.MyCollectionView.reloadData()
            }
        })
        
        MyCollectionView.register(UINib(nibName: MainMealsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MainMealsCollectionViewCell.identifier)
       MyCollectionView.delegate = self
       MyCollectionView.dataSource = self
        MyCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let data = sender as? Food {
                    let productDetailsScreen = segue.destination as! DetailViewController
                    productDetailsScreen.foodDetails = data
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: MainMealsCollectionViewCell.identifier, for: indexPath) as! MainMealsCollectionViewCell
           cell.setup(MainMeals: foods[indexPath.row])
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetail = foods[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: foodDetail)
        MyCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columns:CGFloat
        columns = 2
        
        let spacing:CGFloat = 5
        let totalHorizontalSpacing = (columns - 1) * spacing
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing)/columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth*1.2)
        return itemSize
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
