//
//  Product.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//
//
import Foundation
import RealmSwift

//public protocol Persistable {
//    associatedtype ManagedObject: RealmSwift.Object
//    init(managedObject: ManagedObject)
//    func managedObject() -> ManagedObject
//}

class Product: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var density: Double

    convenience init(name: String, density: Double) {
        self.init()
        self.name = name
        self.density = density
    }

}
