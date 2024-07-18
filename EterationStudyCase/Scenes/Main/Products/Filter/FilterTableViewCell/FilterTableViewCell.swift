//
//  FilterTableViewCell.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 17.07.2024.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkBox.image = .checkboxFilled
            } else {
                checkBox.image = .checkboxEmpty
            }
        }
    }
    
    func setUI(name: String, isChecked: Bool = false) {
        self.isChecked = isChecked
        nameLabel.text = name
    }
}
