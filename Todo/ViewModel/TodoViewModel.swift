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
final class NotesViewModel: ObservableObject {
    
    private let networkClient: NetworkClientContract
    private let localCacheManager: LocalCacheManagerContract

    @Published private(set) var viewState: ViewStates = .loaded
    private(set) var notes: [Note] = []
    
    init(networkClient: NetworkClientContract = NetworkClient(), localCacheManager: LocalCacheManagerContract = CacheManager()) {
        self.networkClient = networkClient
        self.localCacheManager = localCacheManager
    }
}

extension NotesViewModel {

    func getNotes() async {
        let request = NoteRequest()
        do {
            let response = try await networkClient.request(request)
            let notes = try JSONDecoder().decode([Note].self, from: response)
            self.notes = notes
            viewState = .loaded
            localCacheManager.saveNote(notes: notes)
        } catch {
            notes =  localCacheManager.fetchNotes()
            viewState = notes.isEmpty ? .emptyView: .loaded
        }
    }
    
    func deleteNote(index: Int) {
        let note = self.notes[index]
        let notesRequest =  NoteDeleteRequest(noteId: note.id)
        Task {
            do {
                let _ = try await networkClient.request(notesRequest)
                await getNotes()
            } catch {
                
            }
        }
    }
}
