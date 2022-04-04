//
//  Task.swift
//  Projeto-ToDoList
//
//  Created by Marcylene Barreto on 04/04/22.
//

import Foundation

class Task: Codable {
    
    var id: Int
    var title: String
    var time: String
    var date: String
    
    init(id: Int, title: String, time: String, date: String) {
        self.id = id
        self.title = title
        self.time = time
        self.date = date
    }
}
