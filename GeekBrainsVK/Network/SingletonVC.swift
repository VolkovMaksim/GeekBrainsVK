//
//  SingletonVC.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import Foundation

class Session {

    static let instance = Session()

    private init() {}

    var token: String?
    var userId: Int?
}
