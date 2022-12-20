//
//  GetUsers.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation

class GetUsersRequest:Request{
    
    var userIds:[String] = []
}

class GetUsersResponse:Response{
    
    var users:[User] = []
    
}

protocol GetUserDataContract:AnyObject {
    
    func fetchUsers(params:[AnyHashable:Any],callback:@escaping ([User],[AnyHashable:Any]?) -> Void)
    
}

final class GetUsers:Usecase<GetUsersRequest, GetUsersResponse> {
        
    var userDataManager: GetUserDataContract?
    
    override func run(request: GetUsersRequest, callback: @escaping (GetUsersResponse) -> Void) {
        
        var params:[AnyHashable:Any]=[:]
        
        params[ParamType.RequestType] = request.requestType
        
        userDataManager?.fetchUsers(params: params, callback: { (entities, requestStatus) -> Void in
            
            let response = GetUsersResponse()
            response.users = entities
                        
            self.invoke(callback: callback , response: response)
            
        })
        
    }
    
    
}

