//
//  UserMappings.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation
import CoreData

class UserMapping:DatabaseEntityMappings {

    func updateManagedObject(managedObject:NSManagedObject, entity:AnyObject){
        
        if let entity = entity as? User{
            
            if let managedObject  = managedObject as? UserManagedObject{
                
                managedObject.firstName = entity.firstName
                managedObject.lastName = entity.lastName
                managedObject.phoneNumber  = entity.phoneNumber
                managedObject.emailId = entity.email
                managedObject.userId = entity.userId
                
            }
            
        }
        
    }
    
    func updateEntity(entity:AnyObject, managedObject:NSManagedObject){
        
        if let entity = entity as? User{
            
            if let timeEntryManagedObject  = managedObject as? UserManagedObject{
                
                entity.firstName = timeEntryManagedObject.firstName ?? ""
                entity.lastName = timeEntryManagedObject.lastName ?? ""
                entity.phoneNumber = timeEntryManagedObject.phoneNumber ?? ""
                entity.email = timeEntryManagedObject.emailId ?? ""
                entity.userId = timeEntryManagedObject.userId ?? ""
                
            }
            
        }
    }
    
    func updatePredicate(entity: AnyObject) -> NSPredicate {
        
        let timeEntryEntity = entity as! User
        
        return NSPredicate(format: "userId == %@", timeEntryEntity.userId)
        
    }
    
    
}
