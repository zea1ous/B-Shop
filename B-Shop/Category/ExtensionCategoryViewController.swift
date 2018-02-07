//
//  ExtensionCategoryViewController.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 04.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit
import CoreData

extension CategoryViewController {
    
    func clearData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        do {
            
            let entityNames = ["Category", "Group", "Product"]
            
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

        clearData()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // MARK: - Categories
        let bags = NSEntityDescription.insertNewObject(forEntityName: "Category", into: manageContext) as! Category
        bags.id = 0
        bags.title = "Bags & Luggage"
        bags.image = "bags_category_image"
        
        let snowboarding = NSEntityDescription.insertNewObject(forEntityName: "Category", into: manageContext) as! Category
        snowboarding.id = 12
        snowboarding.title = "Snowboarding gear"
        snowboarding.image = "snowboarding_category_image"
        
        let outwear = NSEntityDescription.insertNewObject(forEntityName: "Category", into: manageContext) as! Category
        outwear.id = 22
        outwear.title = "Outwear"
        outwear.image = "outwear_category_image"
        
        // MARK: - Groups
        // bags groups
        let backpacksGroup = createGroupWith(id: 1, title: "Backpacks", image: "backpacks_group_image", category: bags, context: manageContext)
        let duffelBagsGroup = createGroupWith(id: 5, title: "Duffel bags", image: "duffel_group_image", category: bags, context: manageContext)
        let boardBagsGroup = createGroupWith(id: 9, title: "Board bags", image: "boardbags_group_image", category: bags, context: manageContext)
        
        // snowboarding groups
        let snowboardsGroup = createGroupWith(id: 13, title: "Snowboards", image: "snowboards_group_image", category: snowboarding, context: manageContext)
        let bindingsGroup = createGroupWith(id: 16, title: "Bindings", image: "bindings_group_image", category: snowboarding, context: manageContext)
        let bootsGroup = createGroupWith(id: 19, title: "Boots", image: "boots_group_image", category: snowboarding, context: manageContext)
        
        // outwear groups
        let hatsGroup = createGroupWith(id: 23, title: "Hats & Beanies", image: "hats_group_image", category: outwear, context: manageContext)
        let pantsGroup = createGroupWith(id: 28, title: "Pants", image: "pants_group_image", category: outwear, context: manageContext)
        let jacketsGroup = createGroupWith(id: 31, title: "Jackets", image: "jackets_group_image", category: outwear, context: manageContext)
        
        // MARK: - Bag products
        // BackpackGroup products
        createProductWith(id: 2, title: "Tinder Green", image: "tinder_backpack_image", descript: "Green backpack", price: 199.95, group: backpacksGroup, context: manageContext)
        createProductWith(id: 3, title: "Burton Prospect", image: "prospect_backpack_image", descript: "Cool backpack prospect", price: 169.75, group: backpacksGroup, context: manageContext)
        createProductWith(id: 4, title: "Canyon Navy", image: "canyon_backpack_image", descript: "Military backpack", price: 249.95, group: backpacksGroup, context: manageContext)
        
        // DuffelBagsGroup products
        createProductWith(id: 6, title: "Backhill", image: "backhill_duffel_image", descript: "Good duffel bag for training", price: 469.45, group: duffelBagsGroup, context: manageContext)
        createProductWith(id: 7, title: "Outpost", image: "outpost_duffel_image", descript: "White duffel bag", price: 369.45, group: duffelBagsGroup, context: manageContext)
        createProductWith(id: 8, title: "Performer", image: "performer_duffel_image", descript: "Good choise for travel", price: 411.75, group: duffelBagsGroup, context: manageContext)
        
        // BoardBagsGroup products
        createProductWith(id: 10, title: "Antigua", image: "antigua_boardbag_image", descript: "Very cpacy bag for you lovely snowboard and other stuff.", price: 647.25, group: boardBagsGroup, context: manageContext)
        createProductWith(id: 11, title: "Rasta", image: "rasta_boardbag_image", descript: "Rasta colored bag for those who loves to smoke weed everyday.", price: 558.85, group: boardBagsGroup, context: manageContext)
        
        // MARK: - Snowboarding products
        // Snowboards
        createProductWith(id: 14, title: "Burton XC", image: "xc_board_image", descript: "Amazing board for powder.", price: 847.25, group: snowboardsGroup, context: manageContext)
        createProductWith(id: 15, title: "Burton Zero", image: "zero_board_image", descript: "Amazing board for slalom.", price: 787.95, group: snowboardsGroup, context: manageContext)
        
        // Bindings
        createProductWith(id: 17, title: "Misson EST", image: "mission_bindings_image", descript: "Very hard blue bindings.", price: 447.25, group: bindingsGroup, context: manageContext)
        createProductWith(id: 18, title: "Malavita", image: "malavita_bindings_image", descript: "Military bindings to those who loves to ride among forest.", price: 447.25, group: bindingsGroup, context: manageContext)
        
        // Boots
        createProductWith(id: 20, title: "Moto Green", image: "moto_boots_image", descript: "Medium hardeness boots.", price: 347.25, group: bootsGroup, context: manageContext)
        createProductWith(id: 21, title: "Sapphire", image: "sapphire_boots_image", descript: "High hardeness boots.", price: 397.75, group: bootsGroup, context: manageContext)
        
        // MARK: - Outwear poducts
        // Hats & Beanies
        createProductWith(id: 24, title: "Marcy beanie", image: "marcy_beanie_image", descript: "Adult beanie for girls.", price: 97.25, group: hatsGroup, context: manageContext)
        createProductWith(id: 25, title: "Boys beanie", image: "boys_beanie_image", descript: "Beanie for girls.", price: 67.25, group: hatsGroup, context: manageContext)
        createProductWith(id: 26, title: "Nana beanie", image: "nana_beanie_image", descript: "Colored beanie for girls.", price: 77.25, group: hatsGroup, context: manageContext)
        createProductWith(id: 27, title: "Penalty hat", image: "penalty_hat_image", descript: "Baseball cap.", price: 47.25, group: hatsGroup, context: manageContext)
        
        // Pants
        createProductWith(id: 29, title: "AK-2L Swash", image: "swash_pant_image", descript: "Men's warm pant.", price: 197.25, group: pantsGroup, context: manageContext)
        createProductWith(id: 30, title: "Covert Silver", image: "covert_pant_image", descript: "Men's pant for cold weather.", price: 237.25, group: pantsGroup, context: manageContext)
        
        // Jackets
        createProductWith(id: 32, title: "Frontier", image: "frontier_jacket_image", descript: "Men's warm orange jacket.", price: 337.25, group: jacketsGroup, context: manageContext)
        createProductWith(id: 33, title: "Hoosick", image: "hoosick_jacket_image", descript: "Men's warm red jacket.", price: 347.25, group: jacketsGroup, context: manageContext)
        
        do {
            try manageContext.save()
        } catch let error {
            print(error)
        }
    }
    
    private func createGroupWith(id: Int16, title: String, image: String, category: Category, context: NSManagedObjectContext) -> Group {
        let group = NSEntityDescription.insertNewObject(forEntityName: "Group", into: context) as! Group
        group.id = id
        group.title = title
        group.image = image
        group.category = category
        return group
    }
    
    private func createProductWith(id: Int16, title: String, image: String, descript: String, price: Double, group: Group, context: NSManagedObjectContext) {
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context) as! Product
        product.id = id
        product.title = title
        product.image = image
        product.descript = descript
        product.price = price
        product.group = group
    }
    
}


