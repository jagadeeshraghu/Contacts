//
//  DataManager.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/20/22.
//

import Foundation

class UserDataManager:GetUserDataContract{
    
    var userDatabaseService: UserDataBaseGateway?
    var userNetworkService: UserNetworkGateway?
    var userParser:UserParser?
    
        
    func fetchUsers(params: [AnyHashable : Any], callback: @escaping ([User], [AnyHashable : Any]?) -> Void) {
        
        let requestType = params[ParamType.RequestType] as? RequestType
        let userIds = params[ParamType.Id.User] as? [String]
        
        switch requestType{
            
        case .Network:
            
            userNetworkService?.fetchUsersFromNetwork(params: [:]) {[weak self] data, resultParams in
                if let users = self?.userParser?.parseData(data: data){
                    callback(users,[:])
                    self?.userDatabaseService?.updateUsers(entities: users, conditionParams: [:])

                }
                
                
            }
            
        case .Database:
            var resultUsers:[User] = []
            if let userIds = userIds{
                resultUsers = userDatabaseService?.fetchUsers(userIds: userIds) ?? []
            }else{
                resultUsers = userDatabaseService?.fetchUsers(userIds: []) ?? []
            }
            callback(resultUsers,[:])
            
        case .DatabaseNetwork:
            
            var resultUsers:[User] = []
            if let userIds = userIds{
                resultUsers = userDatabaseService?.fetchUsers(userIds: userIds) ?? []
            }else{
                resultUsers = userDatabaseService?.fetchUsers(userIds: []) ?? []
            }
            callback(resultUsers,[:])
            
            userNetworkService?.fetchUsersFromNetwork(params: [:]) {[weak self] data, resultParams in
                if let users = self?.userParser?.parseData(data: data){
                    callback(users,[:])
                    self?.userDatabaseService?.updateUsers(entities: users, conditionParams: [:])
                }
                
                
            }
            

        case .none:
            break
        }
        
        
        
        
    }

    
}
