//
//  DetailViewControllerViewModel.swift
//  MVC-MVVM
//
//  Created by Student Loaner 3 on 4/13/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    
    init(model: MessierDataModel)
}

class DetailViewModel: DetailViewModelProtocol {
    var model: MessierDataModel!
    
    required init(model: MessierDataModel) {
        self.model = model
    }
}
