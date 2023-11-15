//
//  ETodos+Extension.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation
import CoreData

extension ETodos {
    
    static func saveTodos(_ todos: [Todo], moc: NSManagedObjectContext) throws {
        
        todos.forEach { todo in
            let eTodo = ETodos(context: moc)
            eTodo.name = todo.title
            eTodo.desc = todo.title
            eTodo.id = Int16(todo.id)
//            eTodo.timestamp = todo.userID
        }
   
        try moc.save()
    }
    
    static func fetchTodos(moc: NSManagedObjectContext)-> [ETodos] {
        let fr = ETodos.fetchRequest()
        return (try? moc.fetch(fr)) ?? []
    }
    
    static func deleteTodosRecords(moc: NSManagedObjectContext) throws {
        let items =  ETodos.fetchTodos(moc: moc)
        items.forEach {
            moc.delete($0)
        }
        try moc.save()
    }
    
    func toTodo()-> Todo {
//        return Todo(id: Int(id), name: name ?? "", description: desc ?? "", timeStamp: timestamp ?? "")
        return Todo(userID: Int(id), id: Int(id), title: "", completed: false)
    }
}
