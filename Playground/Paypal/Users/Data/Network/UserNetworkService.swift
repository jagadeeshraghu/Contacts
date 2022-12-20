//
//  UserNetworkService.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation

import Foundation

import CoreData


class UserNetworkService:UserNetworkGateway {
    
    
    func fetchUsersFromNetwork(params:[AnyHashable:Any],callback: @escaping (Data, [AnyHashable : Any]?) -> Void){
        
        var networkParams:[AnyHashable:Any] = [:]
        networkParams[ParamType.HttpMethod] = HttpMethod.Get
        
        NetworkManager.downloadData(api: "https://mocki.io/v1/aec03f84-29c2-42e8-9fba-1c621a4033c7",params:[:]) { data, response, error in
            
            if let downloadData = data{
                
                var params:[AnyHashable:Any]=[:]
                
                params[ParamType.HTTPResponse] = response
                
                callback(downloadData,params)

            }
            
    
        }
        

        
    }

    
}
