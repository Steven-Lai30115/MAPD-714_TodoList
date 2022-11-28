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
        
    var todo : Todo = Todo()
    
    
    func set(todo: Todo){
        nameLabel.text = todo.name
        
        if (todo.hasDueDate) {
            let now = Date()
            let dueDate = todo.dueDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd hh:mm"
            var dateLabel = ""
            if (now > dueDate) {
                dateLabel = "[OVERDUE] "
                dueDateLabel.textColor = UIColor.red
            } else {
                dueDateLabel.textColor = UIColor.black
            }
            
            dateLabel = dateLabel + dateFormatter.string(from: todo.dueDate!)
            dueDateLabel.text = dateLabel
        }
        else{
            dueDateLabel.text = ""
        }
        self.todo = todo
    }
    
}
