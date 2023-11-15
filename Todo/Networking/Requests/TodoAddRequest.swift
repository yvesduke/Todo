//
//  TodoAddRequest.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

struct TodoAddRequest: RestRequestContract {
    
    var url: String {
        return RestEndPoints.baseUrl
    }
    
    var params: [String : String] {
        return ["userId": "\(userId)", "id": "\(id)", "title": title, "completed": "\(completed)"]
    }
    
    var path: String {
        return Path.path
    }
    
    var type: RestRequestType {
        return .post
    }
    
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
