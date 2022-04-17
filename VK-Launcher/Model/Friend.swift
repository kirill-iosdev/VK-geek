//
//  Friend.swift
//  VK-Launcher
//
//  Created by Kirill on 19.02.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class Friend: Object, Codable {
    dynamic var id = 0
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var photo50 = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo50 = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
