//
//  FriendsSection.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

struct FriendsSection: Comparable {

    var key: Character
    var data: [Friend]

    static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key < rhs.key
    }

    static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key == rhs.key
    }
}
