//
//  Assembler.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation

class UserAssembler{

    var viewController = UserViewController()
    var presenter = UserViewPresenter()
    var getUsersUseCase = GetUsers()
    var userDataManager = UserDataManager()
    var databaseService = UsersDatabaseService()
    var networkService = UserNetworkService()
    var parser = UserParser()

    func assemble(){
        viewController.presenter = presenter
        presenter.getUsers = getUsersUseCase
        getUsersUseCase.userDataManager = userDataManager
        userDataManager.userDatabaseService = databaseService
        userDataManager.userNetworkService = networkService
        userDataManager.userParser = parser
    }
    
}
