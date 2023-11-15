//
//  TodoView.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import SwiftUI

enum NavigationTrack {
    case addTodos
}

struct TodosView: View {
    @StateObject var viewModel: TodosViewModel
    @State private var isErrorOccured = true
    @State var path: [NavigationTrack] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded:
                    TodosListView()
                case .error:
                    showErrorView()
                case .emptyView:
                    EmptyView()
                }
            }.toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button {
                        path.append(.addTodos)
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement:.navigationBarLeading) {
                    EditButton()
                }
            }
            .navigationTitle(Text(LocalizedStringKey("Todos")))
            .navigationDestination(for: NavigationTrack.self) { page in
                switch page {
                case .addTodos:
                    AddTodoView(path: $path)
                }
            }.onAppear {
                Task {
                    await viewModel.getTodos()
                }
            }
        }
    }
    @ViewBuilder
    func TodosListView() -> some View {
        List {
            ForEach(viewModel.todos) { todo in
                NavigationLink {
                    Text(todo.title)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(todo.title )
                            Text(todo.title )
                        }
                        Spacer()
                    }
                }
            }
            .onDelete { offSet in
                if let index = offSet.first {
                    viewModel.deleteTodo(index: index)
                }
            }
        }
    }
    @ViewBuilder
    func showErrorView() -> some View {
        ProgressView().alert(isPresented: $isErrorOccured){
            Alert(title: Text("Error Occured"),message: Text("Something went wrong"),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView(viewModel: TodosViewModel())
    }
}
