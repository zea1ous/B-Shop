//
//  GroupViewController.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 01.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "GroupCell"

class GroupViewController: UIViewController {
    
    var category: CategoryModel? {
        didSet {
            category?.fetchGroups() { (groups, error) in
                if let error = error {
                    print(error)
                } else {
                    self.self.groups = groups
                }
            }
            navigationItem.title = category?.title
        }
    }
    
    var groups: [GroupModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        var height: CGFloat = 0
        if let navBarHeight = navigationController?.navigationBar.frame.height {
            height = (view.frame.height - (navBarHeight + 20)) / 3 - 20/3
        }
        
        layout.itemSize = CGSize(width: view.frame.width, height: height)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GroupCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        self.view.addSubview(collectionView)
    }
}

extension GroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = groups?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GroupCell
        
        if let group = groups {
            cell.group = group[indexPath.item]
        }
        
        return cell
    }
}

extension GroupViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productTableViewController = ProductTableViewController()
        productTableViewController.group = groups?[indexPath.item]
        
        self.navigationController?.pushViewController(productTableViewController, animated: true)
    }
}
