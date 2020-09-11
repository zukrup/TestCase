//
//  Tests.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation
 
class Tests : Deaths {
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
          
        self.pop_1M = try container.decode(String?.self, forKey: .pop_1M) ?? MyStrings.sharedInstance.NOT_AVAILABLE
        self.total = try container.decode(Int.self, forKey: .total)
         
     }
}
