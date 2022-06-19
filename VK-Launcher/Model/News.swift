//
//  News.swift
//  VK-Launcher
//
//  Created by Kirill on 04.06.2022.
//

//import Foundation
//import SwiftyJSON
//
//class News: Codable {
//    dynamic var text = ""
//
//    convenience init(_ json: JSON) {
//        self.init()
//        self.text = json["text"].stringValue
//    }
//}

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class News: Object, Codable {
    dynamic var text = ""
    dynamic var id = 0
//    dynamic var photoUrl = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.text = json["text"].stringValue
        self.id = json["source_id"].intValue
//        self.photoUrl = json["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
