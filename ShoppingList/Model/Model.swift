//
//  Model.swift
//  WorkingWithFirebase
//
//  Created by Sergey Lukaschuk on 08.10.2021.
//

import Foundation
import Firebase

class Model {
    
    var list = [Todo]()
    
    init() {
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("todos").getDocuments { snapshot, error in
            // Check for errors
            if error == nil {
                // not errors
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { doc in
                            // Create a Todo item for each document returned
                            return Todo(id: doc.documentID,
                                        name: doc["name"] as? String ?? "",
                                        notes: doc["notes"] as? String ?? "")
                        }
                    }
                    
                    
                       
                }
            } else {
                fatalError()
            }
        }
    }
}
