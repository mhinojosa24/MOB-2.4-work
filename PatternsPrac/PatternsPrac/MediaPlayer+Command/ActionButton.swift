//
//  ActionButton.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


enum ButtonType {
    case backwardArrow
    case forwardArrow
    case pause
    case play
}

class ActionButton: BounceableOpacityView {
    let imageView = UIImageView()
    var currentType: ButtonType!
    
    var type: ButtonType {
        didSet {
            switch type {
            case .play:
                currentType = .play
                imageView.image = UIImage(named: "play")?.scaled(with: 1.5)
            case .pause:
                currentType = .pause
                imageView.image = UIImage(named: "pause")?.scaled(with: 1.5)
            case .forwardArrow:
                currentType = .forwardArrow
                imageView.image = UIImage(named: "forward")
            case .backwardArrow:
                currentType = .backwardArrow
                imageView.image = UIImage(named: "backward")
            }
        }
    }
    
    init(type: ButtonType) {
        self.type = type
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        currentType = type
        layout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func layout() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .play:
            imageView.image = UIImage(named: "play")?.scaled(with: 1.5)
        case .pause:
            imageView.image = UIImage(named: "pause")?.scaled(with: 1.5)
        case .forwardArrow:
            imageView.image = UIImage(named: "forward")?.scaled(with: 0.5)
        case .backwardArrow:
            imageView.image = UIImage(named: "backward")?.scaled(with: 0.5)
        }
        
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: 40)
        ])
    }
}
