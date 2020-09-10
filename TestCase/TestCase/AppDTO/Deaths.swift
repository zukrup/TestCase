//
//  Deaths.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation

class Deaths : Decodable {
     
    dynamic var new : String = ""
    dynamic var pop_1M : String? = nil
    dynamic var total : Int = 0

    enum CodingKeys: String, CodingKey {
       case new = "new", pop_1M = "1M_pop", total = "total"
    }

    required convenience init(from decoder: Decoder) throws {
       self.init()
       
       let container = try decoder.container(keyedBy: CodingKeys.self)
        
       self.new = try container.decode(String.self, forKey: .new) 
       self.pop_1M = try container.decode(String.self, forKey: .pop_1M)
       self.total = try container.decode(Int.self, forKey: .total)
        
    }
     
 
}
