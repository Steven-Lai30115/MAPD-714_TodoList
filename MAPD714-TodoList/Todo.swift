//
//  Todo.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import Foundation
// TodoTask object
struct Todo{
    // firebase id
    var id: String = ""
    
    // firebase data
    var name: String = ""
    var isCompleted: Bool = false
    var notes: String = ""
    var hasDueDate: Bool = false
    var isDeleted: Bool = false
    var dueDate: Date?
}

extension Todo {
    var serialize: [String: Any] {
        var d:[String: Any] = [
            "name": self.name,
            "isCompleted": self.isCompleted,
            "notes": self.notes,
            "hasDueDate": self.hasDueDate,
            "isDeleted": self.isDeleted,
        ]
        if (self.hasDueDate == true)
        {
            d["dueDate"] = self.dueDate! as Date
        }
        return d
    }
}
