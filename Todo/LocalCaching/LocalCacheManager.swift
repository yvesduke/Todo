//
//  LocalCacheManager.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

protocol LocalCacheManagerContract {
    func saveTodo(todos: [Todo])
    func fetchTodos()-> [Todo]
    func deleteTodos()
}

class CacheManager: LocalCacheManagerContract {
    func saveTodo(todos: [Todo]) {
        deleteTodos()
        try? ETodos.saveTodos(todos, moc: PersistenceController.shared.container.viewContext)
    }
    func fetchTodos()-> [Todo] {
       let items =  ETodos.fetchTodos(moc: PersistenceController.shared.container.viewContext)
        
        return items.map { $0.toTodo() }
    }
    func deleteTodos() {
        try? ETodos.deleteTodosRecords(moc: PersistenceController.shared.container.viewContext)
    }
}
