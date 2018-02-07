//
//  GroupCell.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 06.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class GroupCell: BaseCell {
    
    var group: GroupModel? {
        didSet {
            titleLabel.text = group?.title
            imageView.image = group?.image.fetch()
        }
    }
}

