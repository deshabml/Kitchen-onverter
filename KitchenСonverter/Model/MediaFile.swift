//
//  MediaFile.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 27.04.2023.
//

import Foundation

struct MediaFile: Identifiable {

    var id: String = UUID().uuidString
    var data: Data
    
}
