//
//  TodoTableViewCell.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    var todo : Todo = Todo()
    
    
    func set(todo: Todo){
        nameLabel.text = todo.name
        self.todo = todo
    }
    
    
    @IBAction func onEditButtonClick(_ sender: UIButton) {
        
    }
}
