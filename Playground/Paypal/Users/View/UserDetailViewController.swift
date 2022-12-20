//
//  UsersDetailViewController.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 12/20/22.
//

import Foundation
import UIKit

class UserDetailController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var user:User?
    
    //MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user{
            self.title = "\(user.firstName) \(user.lastName)"
        }else{
            self.title = "User Detail"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        setLayout()
        
    }
        
    //MARK: AutoLayout
    func setLayout(){
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        
    }
    
    //MARK: User Meta Mappings
    
    var metaData = ["First Name","Last Name","Email Address","Phone Number"]

    func getUserDetail(indexpath:IndexPath) -> String?{
        
        switch indexpath.row{
        case 0:
            return user?.firstName
            
        case 1:
            return user?.lastName
            
        case 2:
            return user?.email
        
        case 3:
            return user?.phoneNumber
            
        default:
            return nil
        }
    }
    
    //MARK: TableView
    
    lazy var tableView:UITableView = {
       
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource  = self
        tableView.delegate = self
        return tableView
        
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        if cell == nil{
            cell = UITableViewCell.init(style: .value2, reuseIdentifier: "tableCell")
            cell?.selectionStyle = .none
        }
        
        cell?.textLabel?.text = metaData[indexPath.row]
        cell?.detailTextLabel?.text = getUserDetail(indexpath: indexPath)
        return cell ?? UITableViewCell()
        
    }
    
    //    var metaData = ["Murugar","Shiva","Natarajar","Pamaban Swamigal","Ramana Maharishi","Maha Avatar Babaji"]

}

