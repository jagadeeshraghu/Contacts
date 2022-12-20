//
//  ViewController.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/4/22.
//

import UIKit

//MARK: View Contract

protocol UsersViewContract:AnyObject {
        func getUsers(callback:@escaping(_ users:[User])->Void)
}

//MARK: View Controller

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var users:[User] = []
    var presenter:UsersViewContract? = UserViewPresenter()

    //MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        setLayout()
        showLoadingIndicator()
        presenter?.getUsers { [weak self] users in
            self?.users = users
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator.removeFromSuperview()
            self?.tableView.reloadData()
            
        }
        
    }
    
    //MARK: Loading Indicator
    
    var loadingIndicator = UIActivityIndicatorView()
    
    func showLoadingIndicator(){
        view.addSubview(loadingIndicator)
        loadingIndicator.color = .darkGray
        loadingIndicator.startAnimating()
        loadingIndicator.center = view.center
    }
    
    
    //Mark: AutoLayout
    
    func setLayout(){
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        
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
        users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        if cell == nil{
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "tableCell")
        }
       
        let user = users[indexPath.row] as User
        cell?.textLabel?.text = "\(user.firstName) \(user.lastName)"
        cell?.detailTextLabel?.text = user.email
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let controller  = UserDetailController()
        controller.user =  users[indexPath.row] as User

        self.navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //    var data = ["Murugar","Shiva","Natarajar","Pamaban Swamigal","Ramana Maharishi","Maha Avatar Babaji"]

    
}

