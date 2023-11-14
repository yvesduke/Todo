//
//  TodoDeleteRequest.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

struct TodoDeleteRequest: RestRequestContract {
    var url: String {
        return RestEndPoints.baseUrl
    }
    var params: [String : String] {
        return [:]
    }
    var path: String {
        return Path.deletePath.appending("\(todoId)")
    }
    var type: RestRequestType {
        return .delete
    }
    var todoId: Int
}

