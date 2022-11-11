//
//  ViewController.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var pastTaskTableView: UITableView!
    @IBOutlet var todoTableView: UITableView!
    var todos = [
        Todo(title: "Medication for C1-23"),
        Todo(title: "Medication for C1-22"),
        Todo(title: "Medication for C1-21"),
        Todo(title: "Medication for C1-20"),
        Todo(title: "Medication for C1-19"),
        Todo(title: "Medication for C1-18"),
        Todo(title: "Medication for C1-17"),
        Todo(title: "Medication for C1-16"),
        Todo(title: "Medication for C1-15"),
    ]
    
    var pastTasks = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
            case pastTaskTableView:
                return 40
            case todoTableView:
                return 70
            default:
                return 70
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
            case pastTaskTableView:
                return pastTasks.count
            case todoTableView:
                return todos.count
            default:
                return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
            case pastTaskTableView:
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "pastTask cell", for: indexPath) as! PastTaskTableViewCell
                cell.set(task: pastTasks[indexPath.row])
                return cell
                
            case todoTableView:
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoTask cell", for: indexPath) as! TodoTableViewCell
                let todo = todos[indexPath.row]
                _ = DateFormatter()
                cell.set(title: todo.title, date: "15/12/2022")
                return cell
                
            default:
                let pCell = UITableViewCell()
                var content = pCell.defaultContentConfiguration()
                content.text = "dafault"
                pCell.contentConfiguration = content
                return pCell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch tableView {
            case todoTableView:
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
                    let test =  self.todos[indexPath.row]
                    self.pastTasks.append(test)
                    self.todos.remove(at: indexPath.row)
                    self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
                    self.pastTaskTableView.reloadData()
                    completion(true)
                }
                
                let doneAction = UIContextualAction(style: .normal, title: "Done") { _, _, completion in
                    var test =  self.todos[indexPath.row]
                    test.isComplete = true
                    self.pastTasks.append(test)
                    self.todos.remove(at: indexPath.row)
                    self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
                    self.pastTaskTableView.reloadData()
                    completion(true)
                }
                doneAction.backgroundColor = .systemGreen
                
                let config = UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
                config.performsFirstActionWithFullSwipe = false
                return config
            
            default:
                let config = UISwipeActionsConfiguration(actions: [])
                return config
        }
    }
}
