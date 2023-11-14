//
//  TodoRequest.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

struct TodoRequest: RestRequestContract {
    var url: String {
        return RestEndPoints.baseUrl
    }
    var params: [String : String] {
        return [:]
    }
    var path: String {
        return Path.path
    }
    var type: RestRequestType {
        return .get
    }
}
