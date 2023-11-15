//
//  TodViewModel.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

enum ViewStates {
    case loading
    case error
    case loaded
    case emptyView
}

@MainActor
final class TodosViewModel: ObservableObject {
    
    private let networkClient: NetworkClientContract
    private let localCacheManager: LocalCacheManagerContract

    @Published private(set) var viewState: ViewStates = .loaded
    private(set) var todos: [Todo] = []
    
    init(networkClient: NetworkClientContract = NetworkClient(), localCacheManager: LocalCacheManagerContract = CacheManager()) {
        self.networkClient = networkClient
        self.localCacheManager = localCacheManager
    }
}

extension TodosViewModel {

    func getTodos() async {
        let request = TodoRequest()
        do {
            let response = try await networkClient.request(request)
            let todos = try JSONDecoder().decode([Todo].self, from: response)
            self.todos = todos
            viewState = .loaded
            localCacheManager.saveTodo(todos: todos)
        } catch {
            todos =  localCacheManager.fetchTodos()
            viewState = todos.isEmpty ? .emptyView: .loaded
        }
    }
    
    func deleteTodo(index: Int) {
        let todo = self.todos[index]
        let todosRequest =  TodoDeleteRequest(todoId: todo.id)
        Task {
            do {
                let _ = try await networkClient.request(todosRequest)
                await getTodos()
            } catch {
                
            }
        }
    }
}
