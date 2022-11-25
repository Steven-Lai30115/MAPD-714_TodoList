//
//  TaskDetailViewController.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var todo: Todo? = nil
    var db = TodoDatabase()

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    
    @IBOutlet weak var hasDueDateSwitch: UISwitch!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.underlined()
        descriptionTextView.underlined()
        dueDateTextField.underlined()
        
        
        setDatePicker()
       
        if todo != nil {
            taskNameTextField.text = todo!.name
            descriptionTextView.text = todo!.notes
            
            // todo pass string
            //        dueDateTextField.text = String(todo?.dueDate)
            
            isCompletedSwitch.setOn(todo!.isCompleted, animated: true)
            hasDueDateSwitch.setOn(todo!.hasDueDate, animated: true)
            if(todo!.hasDueDate){ dueDateTextField.text = formatDate(date: todo!.dueDate!)}
        } else {
            deleteBtn.setTitle("Reset", for: .normal )
            titleLabel.text = "Create task"
            saveBtn.setTitle("Create", for: .normal)
            taskNameTextField!.text! = ""
            descriptionTextView!.text = ""
            isCompletedSwitch.isOn = false
            hasDueDateSwitch.isOn = false
        }
        
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
    
    func toDate(dateStr: String) -> Date
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.date(from: dateStr)!
    }
        
    @IBAction func onHasDueDateChanged(_ sender: UISwitch) {
        if(!sender.isOn) {
            dueDateTextField.text = ""
            todo?.dueDate = nil
        }
    }
    
    @IBAction func onDueDateEntry(_ sender: UITextField) {
        if(!hasDueDateSwitch.isOn) { hasDueDateSwitch.isOn = true }
    }
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        if (!inputChanged())
        {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let alert = UIAlertController(
            title: "Alert",
            message: "Are you sure to discard the changes?",
            preferredStyle: .alert
        )
        
        // You can add actions using the following code
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Yes", comment: "Positive"),
                style: .default,
                handler: {
                    _ in self.navigationController?.popViewController(animated: true)
                }
            )
        
        )
        // You can add actions using the following code
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("No", comment: "Negative"),
                style: .default,
                handler: { _ in print("Cancelled") }
            )
        )

        // This part of code inits alert view
        present(alert, animated: true, completion: nil)

    }
    
    func inputChanged() -> Bool {
        if ( todo != nil
            && (
                todo!.name != taskNameTextField!.text!
                || todo!.notes != descriptionTextView!.text
                || todo!.isCompleted != isCompletedSwitch.isOn
                || todo!.hasDueDate != hasDueDateSwitch.isOn
                || ( todo!.hasDueDate && formatDate(date: todo!.dueDate!) != dueDateTextField.text )
            )
        ) { return true }
        
        if (
            todo == nil
            && (
                taskNameTextField!.text!.isEmpty
                || descriptionTextView!.text!.isEmpty
                || isCompletedSwitch.isOn == true
                || hasDueDateSwitch.isOn == true
                || dueDateTextField.text!.isEmpty
            )
        ) { return true}
        
        return false
    }

    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        
        if (!inputChanged()) {
            print("input not change!!!!")
            return
        }
                
        var alertMessage: String
        let create : Bool = todo == nil
        
        if (!create)
        {
            alertMessage = "Are you sure to update the details?"
        }
        else
        {
            todo = Todo()
            alertMessage = "Are you sure to create the task?"
        }
        
        let alert = UIAlertController(
            title: "Alert",
            message: alertMessage,
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(
            title: NSLocalizedString("Yes", comment: "Positive"),
            style: .default,
            handler:
                { _ in
                    self.todo!.name = self.taskNameTextField!.text!
                    self.todo!.notes = self.descriptionTextView!.text
                    self.todo!.isCompleted = self.isCompletedSwitch.isOn
                    self.todo!.hasDueDate = self.hasDueDateSwitch.isOn
                    if (!self.dueDateTextField.text!.isEmpty)
                    {
                        self.todo!.dueDate = self.toDate(
                            dateStr: self.dueDateTextField.text!
                        )
                        self.todo!.hasDueDate = true
                    } else { self.todo!.hasDueDate = false }
                    
                    // todo update or create
                    if ( create )
                    {
                        self.db.insertTodo(self.todo!)
                    } else
                    {
                        self.db.updateTodo(self.todo!)
                    }
                    self.navigationController?.popViewController(animated: true)
                }
            )
        
        let cancelAction = UIAlertAction(
            title: NSLocalizedString("No", comment: "Negative"),
            style: .default,
            handler: { _ in print("Cancelled") }
        )
        
        // You can add actions using the following code
        alert.addAction(confirmAction)
        
        // You can add actions using the following code
        alert.addAction(cancelAction)
        
        // This part of code inits alert view
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func onDeleteButtonClick(_ sender: UIButton) {
        var alertMsg : String
        var action : UIAlertAction
        if (todo != nil)
        {
            alertMsg = "Are you sure to delete the task?"
            action = UIAlertAction(
                title: NSLocalizedString("Yes", comment: "Positive"),
                style: .default,
                handler: { _ in
                    self.db.markAsDelete(self.todo!.id, true)
                    self.navigationController?.popViewController(animated: true)
                }
            )
        }
        else
        {
            alertMsg = "Are you sure to reset the details?"
            action = UIAlertAction(
                title: NSLocalizedString("Yes", comment: "Positive"),
                style: .default,
                handler: { _ in
                    self.taskNameTextField!.text! = ""
                    self.descriptionTextView!.text = ""
                    self.isCompletedSwitch.isOn = false
                    self.hasDueDateSwitch.isOn = false
                }
            )
        }
        
        let alert = UIAlertController(
            title: "Alert",
            message: alertMsg,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("No", comment: "Negative"),
                style: .default,
                handler: { _ in print("Cancelled") }
            )
        )
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

