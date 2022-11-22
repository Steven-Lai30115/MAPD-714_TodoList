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
import RxSwift

class TodoDatabase : ObservableObject
{
    var dbName = "todos";
    
    func getTodoList() -> Observable<[Any]>
    {
        let db = Firestore.firestore()
        return Observable.create
        { observer in
            db.collection(self.dbName).addSnapshotListener
            { querySnapshot, error in
                if let error = error {
                    observer.onError(error)
                }
                let dataRows: [Todo] = querySnapshot!.documents.map(
                    {doc in let row = doc.data()
                        var date: Date? = Date()
                        if (row["hasDueDate"] as! Bool ) {
                            let d = row["dueDate"] as! Timestamp
                            date = d.dateValue()
                        } else {
                            date = nil
                        }
                        return Todo(
                            id: doc.documentID,
                            name: row["name"] as! String,
                            isCompleted: row["isCompleted"] as! Bool,
                            notes: row["notes"] as! String,
                            hasDueDate: row["hasDueDate"] as! Bool,
                            dueDate: date
                        )
                    }
                )
                observer.onNext(dataRows)
            }
            return Disposables.create()
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
        if (todo.hasDueDate == true)
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
