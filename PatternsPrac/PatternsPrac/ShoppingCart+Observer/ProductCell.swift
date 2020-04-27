//
//  ProductCell.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class ProductCell: UITableViewCell {
    var minValue: Int = 0
    var product: Product? {
        didSet {
            productImage.image = product?.productImage
            productLabel.text = product?.productName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    lazy var productImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banana"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var productLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var decreaseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(decrease), for: .touchUpInside)
        return button
    }()
    
    lazy var increaseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(increase), for: .touchUpInside)
        return button
    }()
    
    lazy var productQuantity : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "1"
        label.textColor = .black
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decreaseButton, productQuantity, increaseButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    @objc func decrease() {
        changeQuantity(by: -1)
        
    }
    
    @objc func increase() {
        changeQuantity(by: 1)
    }
    
    
    func changeQuantity(by amount: Int) {
        var quanity = Int(productQuantity.text!)!
        quanity += amount
        if quanity < minValue {
            quanity = 0
            productQuantity.text = "0"
        } else {
            productQuantity.text = "\(quanity)"
        }
    }
}


extension ProductCell {
    func layout() {
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            productImage.widthAnchor.constraint(equalToConstant: 90),
            
            productLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 5),
            productLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            productLabel.widthAnchor.constraint(equalToConstant: frame.size.width / 2),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: productLabel.trailingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
        ])
    }
    
    func addSubviews() {
        contentView.addSubview(productImage)
        contentView.addSubview(productLabel)
        contentView.addSubview(decreaseButton)
        contentView.addSubview(productQuantity)
        contentView.addSubview(increaseButton)
        contentView.addSubview(stackView)
    }
}
