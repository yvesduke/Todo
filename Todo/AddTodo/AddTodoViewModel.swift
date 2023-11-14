//
//  AddTodoViewModel.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

@MainActor
class AddTodoViewModel: ObservableObject {
    private let networkClient: NetworkClientContract
    private let localCacheManager: LocalCacheManagerContract

    @Published private(set) var viewState: ViewStates = .loading
    private(set) var todos: [Todo] = []
    
    init(networkClient: NetworkClientContract = NetworkClient(), localCacheManager: LocalCacheManagerContract = CacheManager()) {
        self.networkClient = networkClient
        self.localCacheManager = localCacheManager
    }
}

extension AddTodoViewModel {
    func addTodo(name: String, desc: String) {
        viewState =  .loading
        let todoAddRequest = TodoAddRequest(name:name, desc: desc)
        Task {
            do {
                let _ = try await networkClient.request(todoAddRequest)
                viewState = .loaded
            } catch {
                viewState = .error
            }
        }
    }
}
