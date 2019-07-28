//
//  RealmManager.swift
//  DemoRealm
//
//  Created by M. Zharif Hadi M. Khairuddin on 27/07/2019.
//  Copyright © 2019 M. Zharif Hadi M. Khairuddin. All rights reserved.
//


// Implement CRUD
// C = Create
// R = Read
// U = Update
// D = Delete

// add, stop and post observer

import Foundation
import RealmSwift

class RealmManager {
    
    private init() {}

    static let shared = RealmManager()
    var realm = try! Realm() // Get the default Realm
    
    func createObject<T: Object>(_ object: T) {
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let err {
            postObserverNotification(err)
        }
    }
    
    // Queries using nspredicate
    func fetchObject<T: Object>(_ object: T, with predicate: NSPredicate) -> Results<T>{
        let obj = realm.objects(T.self).filter(predicate)
        return obj
    }
    
    func fetchSortedObject<T: Object>(_ object: T, with predicate: NSPredicate,
                                      with sortKey: (String), with isAscending: (Bool)) -> Results<T> {
        let obj = realm.objects(T.self).filter(predicate).sorted(byKeyPath: sortKey, ascending: isAscending)
        return obj
    }
    
    func updateObject<T: Object>(_ object: T, with dictionary: [String : Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch let err {
            postObserverNotification(err)
        }
    }
    
    func deleteObject<T: Object>(_ object: T) {
        
//        let realmURL = Realm.Configuration.defaultConfiguration.fileURL
//        let realmURLs = [
//            realmURL,
//            realmURL?.appendingPathExtension("lock"),
//            realmURL?.appendingPathExtension("management"),
//            realmURL?.appendingPathExtension("note")
//        ]
//        for URL in realmURLs {
//            do {
//                try FileManager.default.removeItem(at: URL!)
//            } catch {
//
//            }
//        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let err {
            postObserverNotification(err)
        }
    }
    
    func addObserverNotification(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Error"),
                                               object: nil,
                                               queue: nil) { (noti) in
            completion(noti.object as? Error)
        }
    }
    
    func removeObserverNotification(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("Error"), object: nil)
    }
    
    func postObserverNotification(_ err: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("Error"), object: err)
    }
    
}
