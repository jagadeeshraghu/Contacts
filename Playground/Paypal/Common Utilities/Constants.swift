//
//  Constants.swift
//  Playground
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation

enum ParamType:String{
    enum Id:String {
        case User = "UserId"
    }
    case HTTPResponse = "HTTPResponse"
    
    case RequestType = "RequestType"
    
    case HttpMethod = "HttpMethod"
    
}
enum HttpMethod:String {
    case Get = "Get"
    case Post = "Post"
}

enum RequestType:String{
    
    case Network = "RequestTypeNetwork"
    case Database = "RequestTypeDatabase"
    case DatabaseNetwork = "RequestTypeDatabase-Network"
    
}

