//
//  Group.swift
//  VK-Launcher
//
//  Created by Kirill on 12.02.2022.

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class Group: Object, Codable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var photo50 = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo50 = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
