//
//  ViewController.swift
//  MVC-MVVM
//
//  Created by Adriana González Martínez on 4/12/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocol!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = HomeViewModel()
        title = viewModel.title
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if segue.identifier == "ShowDetail" {
            if let destinationViewController = segue.destination as? DetailViewController
            {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let index = indexPath.row
                destinationViewController.viewModel = DetailViewModel(model: viewModel.dataSource[index])
            }
        }
    }
}

//MARK: - UITableVieDelegate, UITableViewDataSource Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        tableViewCell?.textLabel?.text = viewModel.dataSource[indexPath.row].commonName
        tableViewCell?.detailTextLabel?.text = viewModel.dataSource[indexPath.row].description
        
        return tableViewCell!
        
    }
}

