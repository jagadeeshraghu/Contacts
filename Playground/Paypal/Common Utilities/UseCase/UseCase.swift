//
//  UseCase.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation

class Request{
    
    var qos: DispatchQoS.QoSClass = .background
    var requestType:RequestType =  .Network
}

class Response{

    enum Status {
        case success
        case networkUnavailable
        case timeout
        case authenticationFailure
        case unknownError
        case successNoEntries
        case responseError
        case internalServerError
        case restricted
    }
    
    var status: Status
    var handleMessage:String?
    var forRequestType:RequestType?
    
    init() {
        self.status = .success
    }
    
    func setDefault(){
        handleMessage = nil
        self.status = .success
    }
    
}

class Usecase<CustomRequest: Request, CustomResponse: Response>: NSObject {
    
    
    final func execute(request: CustomRequest, callback: @escaping (_ response: CustomResponse) -> Void = { _ in } ) {
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.run(request: request, callback: callback)
        }
    }
    
    func run(request: CustomRequest, callback: @escaping (_ response: CustomResponse) -> Void) {
        
    }
    
    final func invoke(callback:@escaping (_ response: CustomResponse) -> Void, response: CustomResponse) {
        if Thread.isMainThread {
            callback(response)
        } else {
            DispatchQueue.main.async(execute: {
                callback(response)
            })
        }

    }
    
    deinit {
        
    }
        
}




