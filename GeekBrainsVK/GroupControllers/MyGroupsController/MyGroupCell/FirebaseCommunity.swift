//
//  FirebaseCommunity.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import Firebase

// MARK: - Firebase для групп
class FirebaseCommunity {

    // определим проперти
    // проперти name с типом String
    let groupName: String

    // проперти id с типом Int
    let groupId: Int

    // проперти ref с сылкой на Reference
    let ref: DatabaseReference?

    // инициализируем нащи проперти
    init(name: String, id: Int) {
        // опередим дефольтные типы данных
        self.ref = nil
        self.groupId = id
        self.groupName = name
    }

    // инициализируем, где передадим что снапшот это ссылка на DataSnapShot
    init?(snapshot: DataSnapshot) {
        // сделаем проверку
        guard
            // проперти value присвоим значение типа [String: Any]
            let value = snapshot.value as? [String:Any],

            // проперти id присвоим значения полученные по ключу "id" c типом Int
            let id = value["groupId"] as? Int,

            // проперти name присвоим значения полученые по ключу "name" с типом String
            let name = value["groupName"] as? String

        else {
            // иначе возвращаем nil
            return nil
        }

        self.ref = snapshot.ref
        self.groupId = id
        self.groupName = name
    }

    // определим метод который вовзращает массив типа [String:Any] из выходных параметров
    func toAnyObject() -> [String: Any] {
        return [
            "groupId": groupId,
            "groupName": groupName
        ]
    }
}
