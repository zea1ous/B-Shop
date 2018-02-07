//
//  CategoryViewController.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 01.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "CategoryCell"

class CategoryViewController: UICollectionViewController {
    
    var categories: [CategoryModel]?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "BURTON"
        collectionView?.backgroundColor = .white
        
        self.collectionView!.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        CategoryModel.fetchAll() { (categories, error) in
            if let e = error {
                print(e)
            } else {
                self.categories = categories
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()   
    }
}


extension CategoryViewController {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let count = categories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell

        if let category = categories {
            cell.category = category[indexPath.item]
        }

        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var height: CGFloat = 0
       
        if let navBarHeight = navigationController?.navigationBar.frame.height {
            height = (view.frame.height - (navBarHeight + 20)) / 3 - 20/3
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
}

extension CategoryViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let groupViewController = GroupViewController()
        groupViewController.category = categories?[indexPath.item]

        self.navigationController?.pushViewController(groupViewController, animated: true)
    }
}
