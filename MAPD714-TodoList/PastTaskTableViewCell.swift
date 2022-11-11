//
//  PastTaskTableViewCell.swift
//  MAPD714-TodoList
//
//  Created by chin wai lai on 10/11/2022.
//

import UIKit

class PastTaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pastTaskLabel: UILabel!
    
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    
    func set(task: Todo){
        pastTaskLabel.attributedText = getPastTaskText(task: task)
        

        if(task.isComplete){
            
            checkMarkImage.image = UIImage(named: "checkMark")
            pastTaskLabel.textColor = .systemGreen
        } else {
            pastTaskLabel.textColor = .systemGray2
        }
        
    }
    
    
    func getPastTaskText(task: Todo) -> NSAttributedString {
        if task.isComplete {
            let attributedText = NSAttributedString(
                string: task.title,
                attributes: [.underlineStyle: NSUnderlineStyle.single]
            )
            
            return attributedText
        }
        
        let attributedText = NSAttributedString(
            string: task.title,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        return attributedText
    }
    
}
