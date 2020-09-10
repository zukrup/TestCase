//
//  Cases.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.

import Foundation

class Cases : Decodable {
    
   
    dynamic var new : String = ""
    dynamic var active : Int = 0
    dynamic var critical : Int = 0
    dynamic var recovered : Int = 0
    dynamic var pop_1M : String? = nil
    dynamic var total : Int = 0
    
    
    enum CodingKeys: String, CodingKey {
        case new = "new", active = "active", critical = "critical" , recovered = "recovered", pop_1M = "1M_pop", total = "total"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
         
        self.new = try container.decode(String.self, forKey: .new)
        self.active = try container.decode(Int.self, forKey: .active)
        self.critical = try container.decode(Int.self, forKey: .critical)
        self.recovered = try container.decode(Int.self, forKey: .recovered)
        self.pop_1M = try container.decode(String.self, forKey: .pop_1M)
        self.total = try container.decode(Int.self, forKey: .total)
         
    }
    
    
}
