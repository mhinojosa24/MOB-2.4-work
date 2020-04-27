//
//  Product.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


struct Product {
    var id: String
    var productName: String
    var productImage: UIImage?
}

extension Product {
    func isEqual(to product: Product) -> Bool {
        return id == product.id
    }
}
