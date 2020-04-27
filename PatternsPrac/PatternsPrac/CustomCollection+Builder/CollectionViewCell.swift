//
//  CollectionViewCell.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import UIKit

class CollectionViewCell: BounceableCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        setupLayout()
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let containerView = SubViewFactory.containerView()
    let imageView = SubViewFactory.imageView()
    let label = SubViewFactory.label()
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    
}


private extension CollectionViewCell {
    struct SubViewFactory {
        static func containerView() -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            view.backgroundColor = .red
            return view
        }
        
        static func imageView() -> UIImageView {
            let imageView = UIImageView(image: UIImage(named: "triangle"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            return imageView
        }
        
        static func label() -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "something"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 19)
            label.textAlignment = .center
            return label
        }
    }
}
