//
//  CountryDAO.swift
//  TestCase
//
//  Created by musa fedakar on 11.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation

class CountryDAO : BaseDAO, IDAO {
    
     
    typealias T = Country
    
    func Get(id : Int) -> Country? {
    
        let retval : Country? = nil
        switch self.DbInterface {
        case .realm:
             
            break
        default:
            break
        }
        return retval
        
    }
    
    func Get(id : String) -> Country? {
    
        var retval : Country?
        switch self.DbInterface {
        case .realm:
            retval = RealmCountryOps.sharedInstance.Get(countryname: id)
            break
        default:
            break
        }
        return retval
    }
    
    func List() -> [Country] {
        
        var retval : [Country] = []
        switch self.DbInterface {
        case .realm:
            retval = RealmCountryOps.sharedInstance.List()
            break
        default:
            break
        }
         
        
        return retval
    }
    
    
    func InsertOrUpdate(_ obj: Country) -> Country? {
        var retval : Country?
        switch self.DbInterface {
        case .realm:
            retval = RealmCountryOps.sharedInstance.InsertOrUpdate(obj)
            break
        default:
            break
        }
        return retval
    }
    
}

