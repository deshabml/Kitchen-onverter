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

//struct Product: Identifiable, Hashable {
//
//    var id = UUID().uuidString
//    let name: String
//    let density: Double
//
//}
//
//final class ProductObject: Object {
//    dynamic var id = UUID().uuidString
//    dynamic var name = ""
//    dynamic var density: Double = 0
//}
//
//extension Product: Persistable {
//
//    public init(managedObject: ProductObject) {
//        id = managedObject.id
//        name = managedObject.name
//        density = managedObject.density
//    }
//    public func managedObject() -> ProductObject {
//        let Product = ProductObject()
//        Product.id = id
//        Product.name = name
//        Product.density = density
//        return Product
//    }
//}
