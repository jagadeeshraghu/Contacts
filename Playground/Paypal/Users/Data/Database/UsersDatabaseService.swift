//
//  UsersDatabaseService.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation
import CoreData

class UsersDatabaseService:UserDataBaseGateway {
    
    func fetchUsers(userIds:[String])->[User]{
        
        let predicate:NSPredicate? = nil
        
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: false)
        
        let objects = DatabaseServiceUtility.fetchAsEntity(dataBaseEntityName: "UserManagedObject", sortDescriptors: [sortDescriptor], predicate: predicate, entityType: User.self, mapper: UserMapping())
        
        
                
        return objects
        
    }
    
    
    func updateUsers(entities: [User], conditionParams: [AnyHashable : Any]) {
        
        var fetchpredicate:NSPredicate? = nil
        
        
        
        
        if let userId = conditionParams[ParamType.Id.User] as? String{
            
            let userIdPredicate = NSPredicate(format: "userId == %@",userId )
            
            fetchpredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userIdPredicate])
            
        }
        
        DatabaseServiceUtility.update(entities: entities, databaseEntityName: "UserManagedObject", fetchPredicate: fetchpredicate, mapper: UserMapping())
        
        
        DatabaseServiceUtility.save()
        
    }
    
}
