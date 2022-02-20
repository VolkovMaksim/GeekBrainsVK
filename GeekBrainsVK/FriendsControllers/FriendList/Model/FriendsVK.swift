//
//  FriendsVK.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import RealmSwift
import Foundation

struct FriendsVK: Codable {
    let response: ResponseFriends
}

struct ResponseFriends: Codable {
    let count: Int
    let items: [Friend]
}

class Friend: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo50: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
