//
//  Router.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation
import UIKit

class UserRouter{
    
    static func getUsersVC()->UIViewController{
        
        let userAssembler = UserAssembler()
        userAssembler.assemble()
        
        return userAssembler.viewController
        
                
    }
    
    
}
