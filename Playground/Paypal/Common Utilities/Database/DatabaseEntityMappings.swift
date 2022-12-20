//
//  DatabaseEntityMappings.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation
import CoreData

protocol DatabaseEntityMappings{
    
    func updateManagedObject(managedObject:NSManagedObject, entity:AnyObject)
    
    func updateEntity(entity:AnyObject,managedObject:NSManagedObject)
        
    //This Predicate Must Return a Unique Match
    
    func updatePredicate(entity:AnyObject)->NSPredicate
}
