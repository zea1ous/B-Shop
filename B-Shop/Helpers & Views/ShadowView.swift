//
//  ShadowView.swift
//  B-Shop
//
//  Created by Alexander Kolovatov on 07.02.18.
//  Copyright © 2018 Alexander Kolovatov. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 4
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

