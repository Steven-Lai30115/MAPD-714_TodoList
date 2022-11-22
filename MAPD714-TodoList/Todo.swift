//
//  Todo.swift
//  MAPD714-TodoList
//
//  Created by Pui Yan Cheung (301252393), Man Nok PUN (301269138), chin wai lai(301257824).
//

import Foundation

struct Todo{
    // firebase id
    var id: String = ""
    
    // firebase data
    var name: String = ""
    var isCompleted: Bool = false
    var notes: String = ""
    var hasDueDate: Bool = true
    var isDeleted: Bool = false
    var dueDate: Date? = Calendar.current.date(byAdding: .day, value: 10, to: Date())!
}
