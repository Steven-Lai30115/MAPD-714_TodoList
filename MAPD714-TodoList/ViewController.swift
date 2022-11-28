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
    var todos: [Todo] = []
    var selectedTodo: Todo? = nil
    
    var db: TodoDatabase = TodoDatabase()
    var pastTasks = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        // getting the data from firebase and keep observing data changes
        // todo should be disposal
        var _ = self.db.getTodoList().subscribe
        { event in
            switch event {
            case .next(let rows):
                let todoList = rows as! [Todo]
                self.pastTasks = todoList.filter {
                        row in row.isCompleted || row.isDeleted
                    }
                self.todos = todoList.filter {
                    row in !(row.isCompleted || row.isDeleted)
                }

                // reload table view after data is loaded
                self.todoTableView.reloadData()
                self.pastTaskTableView.reloadData()
                case .error(let error): print("observe error ", error)
                case .completed:  print("observe complete")
            }
          }
    }

    // set tableView's row initial height
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
    
    // based on two different tableview, create it own view cell
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
                cell.set(todo: todo)
            
//                let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//                animation.duration = 0.6
//                animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//                cell.layer.add(animation, forKey: "shake")
            
                selectedTodo = todo
                let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(sender:)))
                cell.addGestureRecognizer(swipeLeft)
            
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
    
    @objc func swipedLeft(sender: UITapGestureRecognizer)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskDetailViewController") as! TaskDetailViewController
        vc.todo = selectedTodo
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // display button when swipe left & set the action when done button and delete button clicked
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch tableView {
            case todoTableView:
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
                    let todo =  self.todos[indexPath.row]
                    self.db.markAsDelete(todo.id, true)
                    //self.pastTaskTableView.reloadData()
                   // self.todoTableView.reloadData()
                    completion(true)
                }
                
                let doneAction = UIContextualAction(style: .normal, title: "Done") { _, _, completion in
                    let todo =  self.todos[indexPath.row]
                    self.db.markAsComplete(todo.id, true)
                   //self.pastTaskTableView.reloadData()
                    //self.todoTableView.reloadData()
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
    
    // segue passing selected task to TaskDetailView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TaskDetailSegue" {
            print("Update todo")
            let button = sender as! UIButton
            let cell = button.superview!.superview! as! TodoTableViewCell
            let detailController = segue.destination as! TaskDetailViewController
            detailController.todo = cell.todo
        } else if segue.identifier == "AddTodoSegue" {
            print("Add todo")
            _ = sender as! UIButton
            _ = segue.destination as! TaskDetailViewController
        }
        
    }
}
