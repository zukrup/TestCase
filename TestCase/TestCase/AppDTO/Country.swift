//
//  Country.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation
import RealmSwift

class Country : Object, Decodable {
     
    @objc dynamic var continent : String = ""
    @objc dynamic var country : String = ""
    override static func primaryKey() -> String? {
        return "country"
    }
    @objc dynamic var population : Int = 0
    @objc dynamic var day : Date = Date()
    @objc dynamic var time : Date = Date()
    
    @objc dynamic var cases : Cases?
    @objc dynamic var deaths : Deaths?
    @objc dynamic var tests : Tests?
         
    
    enum CodingKeys: String, CodingKey {
        case continent = "continent", country = "country", population = "population", day = "day", time = "time", cases = "cases", deaths = "deaths", tests = "tests"
    }
     
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
         
        self.continent = try container.decode(String.self, forKey: .continent)
        self.country = try container.decode(String.self, forKey: .country)
        self.population = try container.decode(Int.self, forKey: .population)
        if let dayStr = try container.decodeIfPresent(String.self, forKey: .day) {
            self.day = Scully.sharedInstance.isoStringToDate(dayStr, format: "dd.MM.yyyy") ?? Date()
        }
        if let timeStr = try container.decodeIfPresent(String.self, forKey: .time) {
            self.time = Scully.sharedInstance.isoStringToDate(timeStr) ?? Date()
        }
        
        if let casesObj = try container.decodeIfPresent(TestCase.Cases.self, forKey: .cases) {
            self.cases = casesObj
            self.cases?.id = "cases_" + self.country
        }
         
        if let deathsObj = try container.decodeIfPresent(TestCase.Deaths.self, forKey: .deaths) {
            self.deaths = deathsObj
            self.deaths?.id = "deaths_" + self.country
        }
        
        if let testsObj = try container.decodeIfPresent(TestCase.Tests.self, forKey: .tests) {
            self.tests = testsObj
            self.tests?.id = "tests_" + self.country
        }
         
    }
     
}
