//
//  TaskDefaultHelper.swift
//  Projeto-ToDoList
//
//  Created by Marcylene Barreto on 04/04/22.
//

import Foundation

class TaskDefaultHelper {
    let taskKey: String = "taskKey"
    
    public func saveListTask(list: [Task]) {
        do {
            let listAux = try JSONEncoder().encode(list)
            UserDefaults.standard.setValue(listAux, forKey: self.taskKey)
        } catch {
            
        }
    }
    
    public func getListTask() -> [Task] {
        do {
            guard let list = UserDefaults.standard.object(forKey: self.taskKey) else { return [] }
            let listAux = try JSONDecoder().decode([Task].self, from: list as! Data)
            return listAux
        } catch {
            print(error)
        }
        
        return []
    }
    
    public func updateTask(task: Task) {
        var list: [Task] = self.getListTask()
        list.removeAll { taskList in
            return taskList.id == task.id
        }
        list.append(task)
        self.saveListTask(list: list)
    }
    
    public func deleteTask(task: Task) {
        var list: [Task] = self.getListTask()
        list.removeAll { taskList in
            return taskList.id == task.id
        }
        self.saveListTask(list: list)
    }
    
    public func getNextID() -> Int {
        let list: [Task] = self.getListTask()
        for index in 0...list.count {
            let listAux = list.filter { $0.id == index}
            if listAux.count == 0 {
                return index
            }
        }
        return 0
    }
}
