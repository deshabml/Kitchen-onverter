//
//  RealmService.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 17.04.2023.
//

import Foundation
import RealmSwift

class RealmService {

    static let shared = RealmService()
    private let dataBase = try! Realm()

    private init() { }

    func createConverter(converter: Converter) {
        do {
            try dataBase.write {
                dataBase.add(converter)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func getConverter() -> [Converter] {
        let converterList = dataBase.objects(Converter.self)
        var converters = [Converter]()
        for converter in converterList {
            converters.append(converter)
        }
        return converters
    }

    func deleteConverter(converter: Converter) {
        do {
            try dataBase.write {
                dataBase.delete(converter)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }
}
