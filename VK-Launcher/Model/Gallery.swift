//
//  Gallery.swift
//  VK-Launcher
//
//  Created by Kirill on 17.04.2022.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class Gallery: Object, Codable {
    dynamic var id = 0
    dynamic var url = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["owner_id"].intValue
        self.url = json["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
