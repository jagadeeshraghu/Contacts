//
//  SelectViewController.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/4/22.
//

import UIKit

class SelectViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    
    
    lazy var collectionViewLayout:UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 100, height: 50)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize =  CGSize.init(width: 100, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 5, bottom: 5, right: 5)

        
        return layout
    }()
    
    lazy var collectionView:UICollectionView = {
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Ways"
        navigationController?.navigationBar.prefersLargeTitles = true
        setLayout()
    }
    
    func setLayout(){
        
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        collectionView.collectionViewLayout = layout
        
        for _ in 0...3{
            section.append(data)
            
        }
        
    }
    
    var data = ["god","heaven","nature","fire","space","time"]
    
    var section:[[String]] = []
    //Mark: CollectionView Delegates
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        section.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.section[section].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell
        
        cell?.label.text = section[indexPath.section][indexPath.row]
        cell?.backgroundColor = UIColor.red
        
        return cell ?? UICollectionViewCell()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
