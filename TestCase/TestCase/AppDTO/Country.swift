//
//  Country.swift
//  TestCase
//
//  Created by musa fedakar on 10.09.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import Foundation

class Country : Decodable {
    
    dynamic var id = 0
    dynamic var continent : String = ""
    dynamic var country : String = ""
    dynamic var population : Int = 0
    dynamic var day : Date = Date()
    dynamic var time : Date = Date()
    
    dynamic var cases : Cases?
    dynamic var deaths : Deaths?
    dynamic var tests : Tests?
         
    
    enum CodingKeys: String, CodingKey {
        case continent = "continent", country = "country", population = "population", day = "day", time = "time", cases = "cases", deaths = "deaths", tests = "tests"
    }
    
    ///TODO: bazı ülkeler için nil değerler var hepsine kontrol koyulacak
    
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
        }
         
        if let deathsObj = try container.decodeIfPresent(TestCase.Deaths.self, forKey: .deaths) {
            self.deaths = deathsObj
        }
        
        if let testsObj = try container.decodeIfPresent(TestCase.Tests.self, forKey: .tests) {
            self.tests = testsObj
        }
         
    }
     
}
