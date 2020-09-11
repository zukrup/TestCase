//
//  Deaths.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation
import RealmSwift

class Deaths : Object, Decodable {
     
    @objc dynamic var id : String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var numbersNew : String = ""
    @objc dynamic var pop_1M : String? = nil
    @objc dynamic var total : Int = 0

    enum CodingKeys: String, CodingKey {
       case new = "new", pop_1M = "1M_pop", total = "total"
    }

    required convenience init(from decoder: Decoder) throws {
       self.init()
       
       let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.numbersNew = try container.decode(String?.self, forKey: .new) ?? MyStrings.sharedInstance.NOT_AVAILABLE
        self.pop_1M = try container.decode(String?.self, forKey: .pop_1M) ?? MyStrings.sharedInstance.NOT_AVAILABLE
       self.total = try container.decode(Int?.self, forKey: .total) ?? 0
        
    }
     
 
}
