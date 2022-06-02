//
//  Data.swift
//  PushNotification
//
//  Created by Dmitry Sokoltsov on 02.06.2022.
//

import Foundation

protocol Data {
    
    func saveData(_ string: String)
    func deleteData()
    func fetch()
    
}
