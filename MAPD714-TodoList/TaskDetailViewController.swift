//
//  TaskDetailViewController.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var todo: Todo?

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.underlined()
        descriptionTextView.underlined()
        dueDateTextField.underlined()
        
        
        setDatePicker()
        
        taskNameTextField.text = todo?.title
        dueDateTextField.text = todo?.dueDate
        isCompletedSwitch.setOn(todo!.isComplete, animated: true)
        
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
    
    
    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onDeleteButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

