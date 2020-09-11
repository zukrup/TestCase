//
//  Cases.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.

import Foundation
import RealmSwift

class Cases : Object, Decodable {
    
    @objc dynamic var id : String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var numbersNew : String = ""
    @objc dynamic var active : Int = 0
    @objc dynamic var critical : Int = 0
    @objc dynamic var recovered : Int = 0
    @objc dynamic var pop_1M : String = ""
    @objc dynamic var total : Int = 0
    
    
    enum CodingKeys: String, CodingKey {
        case new = "new", active = "active", critical = "critical" , recovered = "recovered", pop_1M = "1M_pop", total = "total"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
         
        self.numbersNew = try container.decode(String?.self, forKey: .new) ?? MyStrings.sharedInstance.NOT_AVAILABLE
        self.active = try container.decode(Int?.self, forKey: .active) ?? 0
        self.critical = try container.decode(Int?.self, forKey: .critical) ?? 0
        self.recovered = try container.decode(Int?.self, forKey: .recovered) ?? 0
        self.pop_1M = try container.decode(String?.self, forKey: .pop_1M) ?? MyStrings.sharedInstance.NOT_AVAILABLE
        self.total = try container.decode(Int?.self, forKey: .total) ?? 0
         
    }
    
    
}
