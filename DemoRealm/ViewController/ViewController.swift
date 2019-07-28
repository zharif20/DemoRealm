//
//  ViewController.swift
//  DemoRealm
//
//  Created by M. Zharif Hadi M. Khairuddin on 27/07/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    let menuId = "menuId"
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: menuId)
        }
    }
    
    var menus : Results<Menu>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addItemBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_add"), style: .plain, target: self, action: #selector(ViewController.addItem))
        self.navigationItem.setRightBarButton(addItemBarButton, animated: false)
        
        let realm = RealmManager.shared.realm
        menus = realm.objects(Menu.self)
        
        RealmManager.shared.addObserverNotification(in: self) { (err) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RealmManager.shared.removeObserverNotification(in: self)
    }
    
    @objc func addItem() {
        AlertManager.addAlert(in: self) { (s) in
            print("\(s)")
            let newMenu = Menu(menu: s)
            RealmManager.shared.createObject(newMenu)
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuId, for: indexPath)
        var titleMenu = UILabel(frame: CGRect(x: 10, y: 0, width: cell.frame.size.width - 10, height: cell.frame.size.height))
        cell.addSubview(titleMenu)

        let menu = menus[indexPath.item]
        
        titleMenu.text = menu.menu

        return cell
    }
    
    
}

