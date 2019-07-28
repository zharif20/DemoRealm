//
//  Menu.swift
//  DemoRealm
//
//  Created by M. Zharif Hadi M. Khairuddin on 28/07/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import Foundation
import RealmSwift

@objc class Menu: Object {
    
    dynamic var menu: String? = ""
    
    convenience init(menu: String) {
        self.init()
        self.menu = menu
    }
    
    
}
