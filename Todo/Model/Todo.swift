//
//  Todo.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

struct Todo: Codable {
    
    let userID, id: Int
    let title: String
    let completed: Bool

//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case id, title, completed
//    }
}
