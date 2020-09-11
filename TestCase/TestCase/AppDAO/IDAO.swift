//
//  IDAO.swift
//  TestCase
//
//  Created by musa fedakar on 11.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation

protocol IDAO {
    associatedtype T
    
    func InsertOrUpdate(_ obj : T) -> T?
    
    func Get(id: Int) -> T?
    
    func Get(id: String) -> T?
    
    func List() -> [T]
}

