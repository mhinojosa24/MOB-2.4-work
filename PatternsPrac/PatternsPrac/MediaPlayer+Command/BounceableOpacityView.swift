//
//  BounceableView.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit



class BounceableOpacityView: UIView, TouchableView {
    var tapGesture: UITapGestureRecognizer?
    var selectBlock: (() -> Void)? {
        didSet {
            guard self.tapGesture == nil else { return }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
            self.addGestureRecognizer(tapGesture)
            self.tapGesture = tapGesture
        }
    }
    
    @objc func pressed() {
        self.selectBlock?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 0.5
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
