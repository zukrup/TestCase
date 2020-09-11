//
//  BaseDAO.swift
//  TestCase
//
//  Created by musa fedakar on 11.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation

class BaseDAO {
      
    var DbInterface: enDbInterface
    
    required init(dbType: enDbInterface) {
        self.DbInterface = dbType
    }
    
    public enum enDbInterface : Int
    {
        case realm
        case sqlite
    }
}
