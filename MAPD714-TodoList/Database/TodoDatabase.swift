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


class TodoDatabase
{
    init() {

        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
