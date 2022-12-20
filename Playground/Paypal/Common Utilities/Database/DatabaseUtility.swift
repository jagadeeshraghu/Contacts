//
//  DataManager.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/20/22.
//

import Foundation
import UIKit
import CoreData

class DatabaseServiceUtility{
    
    //MARK: Persistant Containter
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    //MARK: Managed Object Context

   
    static var managedObjectContext = {
        return DatabaseServiceUtility.backgroundObjectContext
        
    }()
    
    
    static var backgroundObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
   
   //MARK: Fetch
   
   static func fetch(dataBaseEntityName:String,sortDescriptors:[NSSortDescriptor]?,predicate:NSPredicate?)->[NSManagedObject]?{
       
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: dataBaseEntityName)
       fetchRequest.sortDescriptors = sortDescriptors
       fetchRequest.predicate = predicate
       
       return executeRequest(fetchRequest: fetchRequest)
       
   }
   
   static func fetchAsEntity<EntityType>(dataBaseEntityName:String,sortDescriptors:[NSSortDescriptor]?,predicate:NSPredicate?,entityType:EntityType.Type,mapper:DatabaseEntityMappings)->[EntityType]{
       
       let managedObjects = fetch(dataBaseEntityName: dataBaseEntityName, sortDescriptors: sortDescriptors, predicate: predicate)
       if let type = EntityType.self as? Initiable.Type{
           return map(managedObjects: managedObjects, entityType:type, mapper: mapper)
       }else{
           print("Intializer Missing for type: \(EntityType.self)")
           let entities:[EntityType] = []
           return entities
       }
       
   }
        
    //MARK: Map

   
   static func map<EntityType>(managedObjects:[NSManagedObject]?,entityType:Initiable.Type,mapper:DatabaseEntityMappings)->[EntityType]{
       
       var entities:[Initiable] = []
       if let objects = managedObjects{
           for object in objects{
               let entityobject = entityType.init()
               mapper.updateEntity(entity: entityobject as AnyObject, managedObject: object)
               entities.append(entityobject)
           }
       }
       
       return entities as! [EntityType]
       
   }
   
    //MARK: Query
   
   static func executeRequest(fetchRequest:NSFetchRequest<NSFetchRequestResult>)->[NSManagedObject]?{
  
       var results:[NSManagedObject]?
       

       managedObjectContext.performAndWait {
           
           do{
               results = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
           }catch{
               results =  nil
               print(error)
           }
           
   
       }
   
       return results

   }
   
   
   //MARK: Update

   static func update(entities:[AnyObject],databaseEntityName:String,fetchPredicate:NSPredicate?,mapper:DatabaseEntityMappings){


       if let fetchedObjects = fetch(dataBaseEntityName: databaseEntityName, sortDescriptors: nil, predicate: fetchPredicate){

           let managedObjects = NSMutableArray.init(array: fetchedObjects)

           for entity in entities{
               
               let filteredObjects = managedObjects.filtered(using:mapper.updatePredicate(entity: entity))
     
               if filteredObjects.count == 0{

                   
                   if let entityDescription = NSEntityDescription.entity(forEntityName: databaseEntityName, in: managedObjectContext){
                       let managedObject = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
                       mapper.updateManagedObject(managedObject: managedObject, entity: entity)
                   }
                       
                   //Not Found - Creating

              
                   

               }else{

                   //Found - Updating

                   mapper.updateManagedObject(managedObject: filteredObjects.first as! NSManagedObject, entity: entity)
                   managedObjects.remove(filteredObjects.first!)

               }

           }

           //Deleting Remaining Objects

           deleteManagedObjects(managedObjects: managedObjects as! [NSManagedObject])


       }
       
   }
   
   
   //MARK: Delete
   
   
   static func delete(databaseEntityName:String,predicate:NSPredicate){
       
       if let fetchedObjects = fetch(dataBaseEntityName: databaseEntityName, sortDescriptors: nil, predicate: predicate){
           
           deleteManagedObjects(managedObjects: fetchedObjects)

       }
   }
   
   static func deleteManagedObjects(managedObjects:[NSManagedObject]){
   
       for object in managedObjects{
           managedObjectContext.delete(object)
       }

   }
   
   //MARK: Save
   
   static func save(){
       
       DatabaseServiceUtility.saveMangedObjectContext(context: DatabaseServiceUtility.managedObjectContext)
   }
    
    static func saveMangedObjectContext(context:NSManagedObjectContext){

        
        context.perform{
            
            guard context.hasChanges else {return}
            
            do {

                try context.save()
                

            }catch{

                let saveError = error as NSError
                print("\(saveError),\(saveError.userInfo)")

            }
        }
        
    }


   
}
