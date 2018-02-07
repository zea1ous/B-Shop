//
//  ExtensionGroupViewController.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 06.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit
import CoreData

extension GroupViewController {

    func clearData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let manageContext = appDelegate.persistentContainer.viewContext

        do {

            let entityNames = ["Group", "Product"]

            for entityName in entityNames {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

                let objects = try manageContext.fetch(fetchRequest) as? [NSManagedObject]

                for object in objects! {
                    manageContext.delete(object)
                }
            }

            try manageContext.save()

        } catch let error {
            print(error)
        }

    }

    func setupData() {

        loadData()
    }

    func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let manageContext = appDelegate.persistentContainer.viewContext

        // Fetch array of products
        if let _ = fetchProducts() {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")

            do {
                products = try manageContext.fetch(fetchRequest) as? [Product]
            } catch let error {
                print(error)
            }
        }
    }

    private func fetchProducts() -> [Product]? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")

            do {

                return try context.fetch(request) as? [Product]

            } catch let error {
                print(error)
            }

        }
        return nil
    }
}

