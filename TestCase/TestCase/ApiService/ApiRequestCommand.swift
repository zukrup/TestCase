//
//  ApiRequestCommand.swift
//  BaylanMgn
//
//  Created by musa fedakar on 12.08.2018.
//  Copyright © 2018 musa fedakar. All rights reserved.
//

import Foundation
import UIKit

class ApiRequestCommand : NSObject {
    
    var apiCommandType : ApiRequestCommandType?
    var apiResponseState : ApiRequestResponseState?
    var queryObject : AnyObject?
    var returnObject : AnyObject?
    
    init(ct: ApiRequestCommandType) {
        self.apiCommandType = ct
    }
    
    func showProgressDialog() -> Bool {
        
        switch self.apiCommandType! {
        default:
            return true
        }
        
    }
    
    func getMethodName() -> String {
        
        var retval : String = String.init()
        
        switch (self.apiCommandType!) {
        case ApiRequestCommandType.get_countries:
            retval = "countries"
            break
        case ApiRequestCommandType.get_country_detail:
            retval = "statistics"
            break 
        }
        return retval
    }
    
}
