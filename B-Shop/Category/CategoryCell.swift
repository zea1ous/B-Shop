//
//  CategoryCell.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 01.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class CategoryCell: BaseCell {
    
    var category: CategoryModel? {
        didSet {
            titleLabel.text = category?.title
            imageView.image = category?.image.fetch()
        }
    }
}
