//
//  AlertManager.swift
//  DemoRealm
//
//  Created by M. Zharif Hadi M. Khairuddin on 28/07/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class AlertManager {
    private init() {}
    
    static func addAlert(in vc: UIViewController, completion: @escaping (String) -> Void)
    {
        let alert = UIAlertController(title: "Add Menu", message: nil, preferredStyle: .alert)
        alert.addTextField { (addMenu) in
            addMenu.placeholder = "Enter new menu"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let menu = alert.textFields?.first?.text else {return}
            
            completion(menu)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
