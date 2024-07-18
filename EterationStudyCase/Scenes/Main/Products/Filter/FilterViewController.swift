//
//  FilterViewController.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 17.07.2024.
//

import UIKit

class FilterViewController: UIViewController, StoryboardLoadable {

    var viewModel: FilterViewModelProtocol?
    
    @IBOutlet var sortButtons: [UIButton]!
    @IBOutlet weak var brandSearchBar: UISearchBar!
    @IBOutlet weak var modelSearchBar: UISearchBar!
    
    @IBOutlet weak var brandTableView: UITableView!
    @IBOutlet weak var modelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brandTableView.delegate = self
        brandTableView.dataSource = self
        
        modelTableView.delegate = self
        modelTableView.dataSource = self
        
        let nib = UINib(nibName: "FilterTableViewCell", bundle: nil)
        brandTableView.register(nib, forCellReuseIdentifier: "FilterTableViewCell")
        modelTableView.register(nib, forCellReuseIdentifier: "FilterTableViewCell")
        
        viewModel?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.viewWillDisappear()
    }
    
    @IBAction func sortButtonsTapped(_ sender: UIButton) {
        viewModel?.sortButtonsTapped(tag: sender.tag)
        for button in sortButtons {
            button.setImage(.checkboxEmpty, for: .normal)
        }
        let selectedBtn = sortButtons.first { $0.tag == sender.tag }
        selectedBtn?.setImage(.checkboxFilled, for: .normal)
    }
    
    @IBAction func finisFilterTapped(_ sender: Any) {
        viewModel?.finisFilterTapped()
        dismiss(animated: true)
    }
}

extension FilterViewController: FilterViewControllerProtocol {
    func reload() {
        brandTableView.reloadData()
        modelTableView.reloadData()
    }
}

extension FilterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == brandSearchBar {
            viewModel?.brand.searchBarTextDidChange(searchText) { [weak self] in
                self?.brandTableView.reloadData()
            }
        } else {
            viewModel?.model.searchBarTextDidChange(searchText) { [weak self] in
                self?.modelTableView.reloadData()
            }
        }
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == brandTableView {
            viewModel?.brand.itemsCount ?? 0
        } else {
            viewModel?.model.itemsCount ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
        
        var item: FilterModel? {
            if tableView == brandTableView {
                return viewModel?.brand.item(at: indexPath.row)
            } else {
                return viewModel?.model.item(at: indexPath.row)
            }
        }
        if let item {
            cell.setUI(name: item.name, isChecked: item.isChecked)
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == brandTableView {
            viewModel?.brand.selectedRow(at: indexPath.row)
        } else {
            viewModel?.model.selectedRow(at: indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
