//
//  NoteView.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import SwiftUI

enum NavigationTrack {
    case addNotes
}

struct NotesView: View {
    @StateObject var viewModel: NotesViewModel
    @State private var isErrorOccured = true
    @State var path: [NavigationTrack] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded:
                    NotesListView()
                case .error:
                    showErrorView()
                case .emptyView:
                    EmptyView()
                }
            }.toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button {
                        path.append(.addNotes)
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement:.navigationBarLeading) {
                    EditButton()
                }
            }
            .navigationTitle(Text(LocalizedStringKey("Notes")))
            .navigationDestination(for: NavigationTrack.self) { page in
                switch page {
                case .addNotes:
                    AddNoteView(path: $path)
                }
            }.onAppear {
                Task {
                    await viewModel.getNotes()
                }
            }
        }
    }
    @ViewBuilder
    func NotesListView() -> some View {
        List {
            ForEach(viewModel.notes) { note in
                NavigationLink {
                    Text(note.name)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(note.name )
                            Text(note.description )
                        }
                        Spacer()
                    }
                }
            }
            .onDelete { offSet in
                if let index = offSet.first {
                    viewModel.deleteNote(index: index)
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

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(viewModel: NotesViewModel())
    }
}
