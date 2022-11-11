//
//  TaskDetailViewController.swift
//  MAPD714-TodoList
//
//  Created by chin wai lai on 11/11/2022.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDateTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.underlined()
        descriptionTextView.underlined()
        dueDateTextField.underlined()
        
        
        setDatePicker()
    }
    
    func setDatePicker(){
        
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for:
                                UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        datePicker.contentHorizontalAlignment = .center
        dueDateTextField.inputView = datePicker
    }
    

    @objc func dateChange(datePicker: UIDatePicker){
        dueDateTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: date)
    }
        
   
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

