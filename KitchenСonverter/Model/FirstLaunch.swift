//
//  FirstLaunch.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 18.04.2023.
//

import Foundation
import RealmSwift

class FirstLaunch: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString

}

