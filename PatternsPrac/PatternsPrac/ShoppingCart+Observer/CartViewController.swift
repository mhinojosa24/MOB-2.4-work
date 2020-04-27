//
//  CartViewController.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class CartViewController: UITableViewController, CartSubscriber {
    
    open override var description: String { return "cartViewContrller" }
    let cartManager = CartManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.description())
        tableView.rowHeight = 100
        setupNavbar()
        cartManager.add(subscriber: self)
    }
    
    func setupNavbar() {
        let barbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewProduct))
        navigationItem.rightBarButtonItem = barbutton
        title = "My Cart"
    }
    
    @objc func addNewProduct() {
        let alert = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            let productID = UUID().uuidString
            let newProduct = Product(id: productID, productName: alert.textFields![0].text ?? "", productImage: nil)
            self.cartManager.add(product: newProduct)
        }
        
        alert.addTextField { (textfield) in
            textfield.textColor = .white
            textfield.placeholder = "Product title"
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }
    
    func accept(changed cart: [Product]) {
        print("CartViewController: Updating an appearance of a list view with products")
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CartViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartManager.cart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.description(), for: indexPath) as! ProductCell
        cell.productLabel.text = cartManager.cart[indexPath.row].productName
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = cartManager.cart[indexPath.row]
            cartManager.remove(product: product)
        }
    }
}

