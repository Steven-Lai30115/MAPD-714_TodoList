//
//  TodoTableViewCell.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    func set(todo: Todo){
        titleLabel.text = todo.title
        dueDateLabel.text = todo.dueDate
    }
    
    
    @IBAction func onEditButtonClick(_ sender: UIButton) {
        
    }
}
