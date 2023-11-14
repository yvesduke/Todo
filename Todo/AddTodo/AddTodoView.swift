//
//  AddTodoView.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.

import SwiftUI

struct AddTodoView: View {
    @State var name: String = ""
    @State var desc: String = ""
    @Binding var path: [NavigationTrack]
    @StateObject var viewModel = AddTodoViewModel()
    
    var body: some View {
        showAddTodosView()
        .padding()
        .toolbar {
            ToolbarItem {
                Button(action: saveTodos) {
                    Text("Save")
                }
            }
        }
    }
    
    @ViewBuilder
    func showAddTodosView() -> some View {
        VStack {
            TextField("Name", text: $name)     .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $desc)
                    .padding()
                    .frame(height:200.0)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                if desc.isEmpty {
                    Text("Add Desc")
                        .foregroundColor(.gray)
                        .padding(.leading, 25)
                }
            }
            Spacer()
        }
    }
    private func saveTodos() {
        if !name.isEmpty && !desc.isEmpty {
            withAnimation {
                viewModel.addTodo(name: name, desc: desc)
                path.removeLast()
            }
        }
    }
}

