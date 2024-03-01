//
//  ViewController.swift
//  MVP
//
//  Created by MAC on 28/02/2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var shopListCollectionView: UICollectionView!
    
    var shops: [Shop] = [] // Array to hold shop data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count // Return the number of shops
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue reusable cell of type ShopListCVC
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCVC", for: indexPath) as? ShopListCVC else {
            return UICollectionViewCell()
        }
        
        // Configure cell with shop data at indexPath
        let shop = shops[indexPath.item]
        cell.cellTitle.text = shop.name
        cell.cellDesc.text = shop.shopDescription
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register ShopListCVC nib file
        let nib = UINib(nibName: "ShopListCVC", bundle: nil)
        shopListCollectionView.register(nib, forCellWithReuseIdentifier: "ShopListCVC")
        
        // Set collection view delegate and data source
        shopListCollectionView.delegate = self
        shopListCollectionView.dataSource = self
        
        // Fetch shop data using ShopPresenter
        let presenter = ShopPresenter()
        presenter.delegate = self
        presenter.fetchShopData()
    }
}

// Conform to ShopPresenterDelegate to handle shop data fetching
extension ViewController: ShopPresenterDelegate {
    func shopDataFetchedSuccessfully(_ shops: [Shop]) {
        // Update shops array with fetched data
        self.shops = shops
        
        // Reload collection view on main thread
        DispatchQueue.main.async {
            self.shopListCollectionView.reloadData()
        }
    }
    
    func shopDataFetchingFailed(with error: Error) {
        print("Shop data fetching failed with error: \(error)")
        // Handle error (e.g., show error message to user)
    }
}
