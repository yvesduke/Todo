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
        return ["name": name, "description": desc, "timeStamp": "\(Date.now)"]
    }
    var path: String {
        return Path.path
    }
    var type: RestRequestType {
        return .post
    }
    var name: String
    var desc: String
}
