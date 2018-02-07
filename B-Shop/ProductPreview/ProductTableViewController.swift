//
//  ProductTableViewController.swift
//  B-shop
//
//  Created by Alexander Kolovatov on 01.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

private let tableCellIdentifer = "TableCell"

class ProductTableViewController: UITableViewController {
    
    var group: GroupModel? {
        didSet {
            group?.fetchProducts() { (products, error) in
                if let error = error {
                    print(error)
                } else {
                    self.self.products = products
                }
            }
            navigationItem.title = group?.title
        }
    }
    
    var products: [ProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableCellIdentifer)
        tableView.reloadData()
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        if let products = products {
            let tableItem = products[indexPath.item]
            
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = tableItem.title
            cell.detailTextLabel?.text = String(format: "$%.2f", tableItem.price!)
            cell.imageView?.image = tableItem.image.fetch()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = products?.count{
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: tableCellIdentifer)
        
        
        self.configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height / 6
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productViewController = ProductPreviewController()
        
        let tableItem = products![indexPath.row]
        productViewController.imageView.image = tableItem.image.fetch()
        productViewController.priceLabel.text = "Price: " + String(format: "$%.2f", tableItem.price!)
        productViewController.descriptionLabel.text = tableItem.descript
        productViewController.navBarTitle = tableItem.title
        
        self.navigationController?.pushViewController(productViewController, animated: true)
    }
    
}

