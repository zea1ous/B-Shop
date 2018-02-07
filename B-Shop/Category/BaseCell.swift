//
//  BaseCell.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 07.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .black
        label.textAlignment = .center
        label.font = label.font.withSize(26)
        return label
    }()
    
    let shadowView: UIView = {
        let view = ShadowView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(shadowView)
        shadowView.addSubview(imageView)
        imageView.addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: shadowView)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: shadowView)
        
        shadowView.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        shadowView.addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        
        imageView.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        imageView.addConstraintsWithFormat(format: "V:[v0(34)]|", views: titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

