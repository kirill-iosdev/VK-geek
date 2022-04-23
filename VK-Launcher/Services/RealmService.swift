//
//  RealmService.swift
//  VK-Launcher
//
//  Created by Kirill on 15.04.2022.
//

import RealmSwift

class RealmService {
    
    static func save<T: Object>(items: [T], configuration: Realm.Configuration = .defaultConfiguration, update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
            //Как сделать что бы при уменьшении поступающих обьектов из json в реалме удалялись лишние?
        }
    }
    
//    static func get<T: Object>(_ type: T.Type, configuration: Realm.Configuration = .defaultConfiguration) throws -> Results<T> {
//        print(configuration.fileURL ?? "")
//        return try Realm(configuration: configuration).objects(type)
//    }
}
