//
//  User.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/4/22.
//

import Foundation

protocol Initiable{
    init()
}

class User:Initiable{

    var firstName:String = ""
    var lastName:String = ""
    var phoneNumber:String = ""
    var userId:String = ""
    var email:String = ""
    
    required init() {
        
    }
    
    
}
