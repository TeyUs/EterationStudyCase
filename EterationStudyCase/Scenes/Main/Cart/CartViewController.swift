//
//  CartViewController.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import UIKit

class CartViewController: UIViewController, StoryboardLoadable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var viewModel: CartViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "E-Market"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.viewWillDisappear()
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        
    }
}

extension CartViewController: CartViewControllerProtocol {
    func setTotalPrice(_ price: String) {
        DispatchQueue.main.async { [weak self] in
            self?.totalPriceLabel.text = price
        }
    }
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.itemsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        let item = (viewModel?.item(at: indexPath.row))!
        cell.setUI(product: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        return emptyView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel?.item(at: indexPath.row) else { return }
        let view = UIStoryboard.loadViewController() as ProductDetailViewController
        view.viewModel = ProductDetailViewModel(view: view, model: model)
        self.show(view, sender: nil)
    }
}
