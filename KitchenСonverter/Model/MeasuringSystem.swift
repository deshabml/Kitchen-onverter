//
//  MeasuringSystem.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 11.04.2023.
//

import Foundation
import RealmSwift

class MeasuringSystem: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var isWeight: Bool
    @Persisted var ratio: Double

    convenience init(name: String, isWeight: Bool, ratio: Double) {
        self.init()
        self.name = name
        self.isWeight = isWeight
        self.ratio = ratio
    }

}

//
//struct MeasuringSystem: Identifiable, Hashable {
//
//    var id = UUID().uuidString
//    let name: String
//    let isWeight: Bool
//    let ratio: Double
//
//}
//
//
//final class MeasuringSystemObject: Object {
//    dynamic var id = UUID().uuidString
//    dynamic var name = ""
//    dynamic var isWeight = true
//    dynamic var ratio: Double = 0
//}
//
//extension MeasuringSystem: Persistable {
//
//    public init(managedObject: MeasuringSystemObject) {
//        id = managedObject.id
//        name = managedObject.name
//        isWeight = managedObject.isWeight
//        ratio = managedObject.ratio
//    }
//    public func managedObject() -> MeasuringSystemObject {
//        let measuringSystem = MeasuringSystemObject()
//        measuringSystem.id = id
//        measuringSystem.name = name
//        measuringSystem.isWeight = isWeight
//        measuringSystem.ratio = ratio
//        return measuringSystem
//    }
//}
//
