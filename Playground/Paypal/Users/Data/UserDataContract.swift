//
//  UserDataContract.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation
protocol UserDataBaseGateway:AnyObject {
    
    func fetchUsers(userIds:[String])->[User]
    func updateUsers(entities: [User], conditionParams: [AnyHashable : Any])

}



protocol UserNetworkGateway:AnyObject {
    
    func fetchUsersFromNetwork(params:[AnyHashable:Any],callback: @escaping (Data, [AnyHashable : Any]?) -> Void)
    
}

