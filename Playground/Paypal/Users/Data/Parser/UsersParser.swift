//
//  UsersParser.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/4/22.
//

import Foundation


final class UserParser{
    
    
    func parseData(data:Data)->[User]{
        
        var userObjects:[User] = []
        
        do{
            
            let json = try JSONSerialization.jsonObject(with: data)
            print(json)
            if let jsonDict =  json as? [String:Any?]{
                userObjects = parseIntoUser(parse: jsonDict)
            }
        }catch{
            print(error.localizedDescription)
        }
                
        return userObjects
    }
    
    func parseIntoUser(parse:[String:Any?])->[User]{
        
        var userObjects:[User] = []
        if let users = parse["users"] as? Array<[String:Any]>{
        
            for user in users{
                
                let userObject = User()
                userObject.email = user["emailAddress"] as? String ?? ""
                userObject.firstName = user["firstName"] as? String ?? ""
                userObject.lastName = user["lastName"] as? String ?? ""
                userObject.phoneNumber = (user["phoneNumber"]) as? String ?? ""
                userObject.userId = (user["phoneNumber"]) as? String ?? ""
                
                
                
                userObjects.append(userObject)
            }
        
        }
        
        return userObjects
        
        
    }
    
}
