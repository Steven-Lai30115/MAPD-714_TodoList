//
//  TodoTableViewCell.swift
//  MAPD714-TodoList
//
//  Created by chin wai lai on 9/11/2022.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    
    @IBOutlet weak var editButton: UIButton!
    
    
    func set(title: String, date: String){
        titleLabel.text = title
        dueDateLabel.text = date
    }
    
    
    @IBAction func onEditButtonClick(_ sender: UIButton) {
        
    }
}
