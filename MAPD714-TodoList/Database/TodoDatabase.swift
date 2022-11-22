//
//  TodoDatabase.swift
//  MAPD714-TodoList
//
//  Created by Charlene Cheung on 21/11/2022.
//

import FirebaseFirestore
import UIKit
import Foundation
import FirebaseCore
//import RxSwift

class TodoDatabase : ObservableObject
{
    var dbName = "todos";
//    var todos : Observable<[Todo]>
    var todoList: [Todo] = []

    init()
    {
        self.getTodoList(true)
//        self.insertTodo(
//            Todo(
//                name: "abc",
//                isCompleted: true,
//                notes: "hahhaha",
//                hasDueDate: true ,
//                dueDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())
//            )
//        )
//        self.insertTodo(
//            Todo(
//                name: "cba",
//                isCompleted: false,
//                notes: "lalal",
//                hasDueDate: false
//            )
//        )
    }
    
    func getTodoList(_ isCompleted: Bool)
    {

        let db = Firestore.firestore()
        db.collection(self.dbName).getDocuments()
        { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let item = Todo(
                        name: document.data()["name"] as! String,
                        isCompleted: document.data()["isCompleted"] as! Bool,
                        notes: document.data()["notes"] as! String,
                        hasDueDate: document.data()["hasDueDate"] as! Bool,
                        dueDate: document.data()["dueDate"] as? Date
                    )
                    // todo todo list should be observable
                    self.todoList.append(item)
                    print("\(document.documentID) => \(document.data()) => \(document)")
                }
            }
        }
    }
    
    func insertTodo(_ todo: Todo)
    {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        var data: [String: Any]  = [
            "name": todo.name,
            "isCompleted": todo.isCompleted,
            "notes": todo.notes,
            "hasDueDate": todo.hasDueDate
        ]
        if (todo.hasDueDate)
        {
            data["dueDate"] = todo.dueDate! as Date
        }

        ref = db.collection(self.dbName)
            .addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
