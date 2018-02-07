//
//  CategoryModel.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 06.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

let FetchFromServer = false // Switch loading data form device
var DelayTime: UInt32 = 0 // Imitation loading from server
let ServerURL = "http://localhost:3000"

struct ImageModel {
    
    var str: String?
    
    init(with str: String?) {
        self.str = str
    }
    
    func fetch() -> UIImage? {
        if FetchFromServer {
            
            var image = UIImage()
            
            if let str = str {
                let imgURL = ServerURL + str
                guard let url = URL(string: imgURL) else {
                    return nil
                }
                
                Alamofire.request(url).responseData { (response) in
                    if response.error == nil {
                        print(response.result)
                    }
                    if let data = response.data {
                        image = UIImage(data: data)!
                    }
                }
            }
            return image
        } else {
            if let imagePath = str {
                return UIImage(named: imagePath)
            } else {
                return nil
            }
        }
    }
}

struct ProductJson: Decodable {
    let id: Int16
    let title: String
    let image: String
    let price: Double
    let descript: String
}

struct ProductModel {
    
    var id: Int16?
    var title: String?
    var image: ImageModel
    var price: Double?
    var descript: String?
    
    init(with coreData: Product) {
        self.id = coreData.id
        self.title = coreData.title
        self.image = ImageModel(with: coreData.image)
        self.price = coreData.price
        self.descript = coreData.descript
    }
    
    init(with json: ProductJson) {
        self.id = json.id
        self.title = json.title
        self.image = ImageModel(with: json.image)
        self.price = json.price
        self.descript = json.descript
    }
}

struct GroupJson: Decodable {
    let id: Int16
    let title: String
    let image: String
}

struct GroupModel {
    
    var id: Int16?
    var title: String?
    var image: ImageModel
    
    private var coreData: Group?
    
    init(with coreData: Group) {
        self.id = coreData.id
        self.title = coreData.title
        self.image = ImageModel(with: coreData.image)
        self.coreData = coreData
    }
    
    init(with json: GroupJson) {
        self.id = json.id
        self.title = json.title
        self.image = ImageModel(with: json.image)
    }
    
    func fetchProducts(completion: @escaping ([ProductModel]?, Error?) -> Void) {
        if FetchFromServer {
            
            // https://localhost:3000/products?group_id=:group_id
            let productsURL = ServerURL + "/products?group_id=" + String(describing: self.id)
            guard let url = URL(string: productsURL) else {
                completion(nil, nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {
                    completion(nil, err)
                    return
                }
                
                do {
                    let products = try
                        JSONDecoder().decode([ProductJson].self, from: data)
                    
                    var models = [ProductModel]()
                    for p in products {
                        models.append(ProductModel(with: p))
                    }
                    
                    completion(models, nil)
                    
                } catch let jsonErr {
                    completion(nil, jsonErr)
                }
            }
        } else {
            var models = [ProductModel]()
            if let products = coreData?.products?.allObjects {
                for p in products {
                    if let pp = p as? Product {
                        models.append(ProductModel(with: pp))
                    }
                }
            }
            
            sleep(DelayTime)
            completion(models, nil)
        }
    }
}

struct CategoryJson: Decodable {
    let id: Int16
    let title: String
    let image: String
}

struct CategoryModel {
    
    static let categoriesEnd = "/categories"
    
    var id: Int16?
    var title: String?
    var image: ImageModel
    
    private var coreData: Category?
    
    init(with coreData: Category) {
        self.id = coreData.id
        self.title = coreData.title
        self.image = ImageModel(with: coreData.image)
        self.coreData = coreData
    }
    
    init(with json: CategoryJson) {
        self.id = json.id
        self.title = json.title
        self.image = ImageModel(with: json.image)
    }
    
    
    func fetchGroups(completion: @escaping ([GroupModel]?, Error?) -> Void) {
        if FetchFromServer {
            
            // https://localhost:3000/categories/:id/groups
            let groupsURL = ServerURL + CategoryModel.categoriesEnd + "\(String(describing: self.id))/groups"
            guard let url = URL(string: groupsURL) else {
                completion(nil, nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {
                    completion(nil, err)
                    return
                }
                
                do {
                    
                    let groups = try
                        JSONDecoder().decode([GroupJson].self, from: data)
                    
                    var models = [GroupModel]()
                    for g in groups {
                        models.append(GroupModel(with: g))
                    }
                    
                    completion(models, nil)
                    
                } catch let jsonErr {
                    completion(nil, jsonErr)
                }
            }
            
        } else {
            var models = [GroupModel]()
            if let groups = coreData?.groups?.allObjects {
                for g in groups {
                    if let gg = g as? Group {
                        models.append(GroupModel(with: gg))
                    }
                }
            }
            sleep(DelayTime)
            completion(models, nil)
        }
    }
    
    static func fetchAll(completion: @escaping ([CategoryModel]?, Error?) -> Void) {
        
        if FetchFromServer {
            
            let categoriesURL = ServerURL + categoriesEnd
            guard let url = URL(string: categoriesURL) else {
                completion(nil, nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {
                    completion(nil, err)
                    return
                }
                
                do {
                    
                    let categories = try
                        JSONDecoder().decode([CategoryJson].self, from: data)
                    
                    var models = [CategoryModel]()
                    for c in categories {
                        models.append(CategoryModel(with: c))
                    }
                    
                    completion(models, nil)
                    
                } catch let jsonErr {
                    completion(nil, jsonErr)
                }
            }
            
        } else {
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
                
                do {
                    let categories = try
                        context.fetch(request) as? [Category]
                    
                    var models = [CategoryModel]()
                    if let categories = categories {
                        for c in categories {
                            models.append(CategoryModel(with: c))
                        }
                    }
                    sleep(DelayTime)
                    completion(models, nil)
                    
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}


