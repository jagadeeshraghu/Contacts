//
//  ViewPresenter.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/4/22.
//

import Foundation

class UserViewPresenter:UsersViewContract{
    
    var getUsers:GetUsers?

    func getUsers(callback:@escaping(_ users:[User])->Void){
        
        let getUsersRequest = GetUsersRequest()
        getUsersRequest.requestType = .DatabaseNetwork
        
        getUsers?.execute(request: getUsersRequest) {
            (response:GetUsersResponse) in
            print(response.users.count)
            
            let resultUsers = response.users.sorted { user1, user2 in
                if user1.firstName < user2.firstName{
                    return true
                }else{
                    return false
                }
            }
            callback(resultUsers)
        }

    }
}
