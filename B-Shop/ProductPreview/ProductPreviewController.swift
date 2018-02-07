//
//  ProductPreviewController.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 01.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class ProductPreviewController: UIViewController {

    var navBarTitle: String?

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(22)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        
        var topInset: String = ""
        if let navBarHeight = self.navigationController?.navigationBar.frame.height {
            topInset = String(Int(navBarHeight) + 20 + 16)
        }
        let frameHeight = view.frame.height * 0.55
        let viewHeight: String = String(Int(frameHeight))
        
        navigationItem.title = navBarTitle
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: imageView)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: priceLabel)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: descriptionLabel)
        view.addConstraintsWithFormat(format: "V:|-\(topInset)-[v0(\(viewHeight))]-8-[v1(40)]-8-[v2]-8-|", views: imageView, priceLabel, descriptionLabel)
    }
}
