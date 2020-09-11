//
//  OpRealmCountry.swift
//  TestCase
//
//  Created by musa fedakar on 11.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCountryOps {
    
    static let sharedInstance = RealmCountryOps()
    
    fileprivate func asdto(_ c : Country) -> Country {
        
        let i = Country()
        i.population = c.population
        i.country = c.country
        i.continent = c.continent
        i.day = c.day
        i.time = c.time
        i.cases = c.cases
        i.tests = c.tests
        i.deaths = c.deaths
        
        return i
    }
    
    func Get(countryname: String) -> Country? {
        
        let realm = try! Realm()
        let filterStr = "country == '" + (countryname) + "'"
        if let dbobj = realm.objects(Country.self).filter(filterStr).first {
            return asdto(dbobj)
        }
        return nil
        
    }
    
    func List() -> [Country] {
        let realm = try! Realm()
        
        var retval : [Country] = []
        
        let dblist = realm.objects(Country.self).sorted(byKeyPath: "country", ascending: true)
            
        for dbobj in dblist {
           retval.append(asdto(dbobj))
        }
        
        return retval
    }
    
    
    func InsertOrUpdate(_ c : Country) -> Country {
        let realm = try! Realm()
        try! realm.write {
            realm.add(c, update: .all)
             
        }
         
        return asdto(c)
    }
    
}
