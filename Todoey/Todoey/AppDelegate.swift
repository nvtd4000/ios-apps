//
//  AppDelegate.swift
//  Todoey
//
//  Created by Dung Nguyen on 2/10/19.
//  Copyright © 2019 dapp. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
//        let data = Data()
//        data.name = "David"
//        data.age = 12
        
        do{
//            let realm = try Realm()
            _ = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        }catch {
            print("Error initializing new realm, \(error)")
        }
        
        return true
    }

   


}

