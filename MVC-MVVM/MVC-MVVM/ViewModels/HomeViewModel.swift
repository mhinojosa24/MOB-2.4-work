//
//  ViewControllerViewModel.swift
//  MVC-MVVM
//
//  Created by Student Loaner 3 on 4/13/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation
import UIKit


protocol HomeViewModelProtocol: class {
    var title: String? { get }
    var dataSource: [MessierDataModel] { get }
}


class HomeViewModel: HomeViewModelProtocol {
    var dataSource: [MessierDataModel] = [Messier1, Messier8, Messier57]
    
    var title: String? {
        return "Nebula Updates"
    }
}
