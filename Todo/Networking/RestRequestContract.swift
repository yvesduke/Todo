//
//  RestRequestContract.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

enum RestRequestType: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

protocol RestRequestContract {
    
    var url: String {get}
    var path: String {get}
    var params: [String: String] {get}
    var type: RestRequestType {get}
    
}
