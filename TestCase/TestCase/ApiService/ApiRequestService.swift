//
//  ApiRequestService.swift
//  MyX
//
//  Created by Musa Fedakar on 12/05/16.
//  Copyright © 2016 Br Magazacilik. All rights reserved.
//

import Foundation
import Alamofire 

class ApiRequestService : ApiOperation {
    
    //var URL_ACTIVE = "http://windows-10/mgn/"
    var URL_ACTIVE = "https://covid-193.p.rapidapi.com/"
    let HEADERS : HTTPHeaders = HTTPHeaders.init(["x-rapidapi-host": "covid-193.p.rapidapi.com",
    "x-rapidapi-key": "7230f0073fmsh19c10074c514c59p16793ejsn6aa0e35fe867"])
    
    var apiRequestCommand : ApiRequestCommand?
    
    override func main() {
        
        executing(true)
        
        if (apiRequestCommand == nil) {
            return
        }
        else if let Command = apiRequestCommand?.apiCommandType {
            switch (Command) {
            case ApiRequestCommandType.get_countries:
                get_countries()
                break
            case ApiRequestCommandType.get_country_detail:
                get_country_details()
                break 
            }
        }
    }
    
    func getServiceEndPointAddress() -> URLConvertible {
        
        var retval : String = self.URL_ACTIVE
        if let methodName = self.apiRequestCommand?.getMethodName() {
            retval += methodName
        }
        return retval
    }
    
    func getServiceEndPointAddressString() -> String {
        
        var retval : String = self.URL_ACTIVE
        if let methodName = self.apiRequestCommand?.getMethodName() {
            retval += methodName
        }
        return retval
    }
    
    fileprivate func get_country_details() {
        
        let endPoint = getServiceEndPointAddressString()
        var stats_params : [String: AnyObject] = [:]
        if let qobj = self.apiRequestCommand?.queryObject as? BaseRequest {
            stats_params = qobj.queryDictionary
        }
         
        AF.request((endPoint as URLConvertible), method: .get, parameters: stats_params, headers: HEADERS)
            .validate().responseJSON { (data) in
                
                
                if let _ = data.error {
                    self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.error
                    self.handle_api_response(data: data)
                    
                }
                
                if let datavalue = data.value {
                    self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.success
                    let jsonResult = JSON(datavalue)
                    do {
                        let returnObj = ApiResponseObject<Country>(json: jsonResult, object: try JSONDecoder().decode(Country.self, from: jsonResult["response"].arrayValue.first!.rawData()))
                        self.apiRequestCommand?.returnObject = returnObj
                    }
                    catch {
                        print(error)
                        self.handle_api_response(data: data)
                    }
                }
                 
                self.complete_operation()
        }
        
    }
    
    fileprivate func get_countries() {
        
       
        AF.request(getServiceEndPointAddress(), method: .get, parameters: nil, headers: HEADERS)
            .validate().responseJSON { (data) in
                
                
                if let _ = data.error {
                    self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.error
                    self.handle_api_response(data: data)
                    
                }
                
                if let datavalue = data.value {
                    self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.success
                    let jsonResult = JSON(datavalue)
                    let returnObj = ApiResponseObject<String>(json: jsonResult, objectList: jsonResult["response"].arrayValue.map { $0.stringValue} )
                    self.apiRequestCommand?.returnObject = returnObj
                }
                 
                self.complete_operation()
        }
        
    }
        
    fileprivate func handle_api_response(data : AFDataResponse<Any>) {
        
        let responseErrorObj : ApiResponse
         
        
        if let statuscode = data.response?.statusCode {
            switch statuscode {
            case 408:
                self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.timeout
                responseErrorObj = ApiResponse(err: "ApiRequestResponseState.timeout")
                break
            case 400:
                self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.error
                responseErrorObj = ApiResponse(err: "ApiRequestResponseState.error")
                break
            default:
                self.apiRequestCommand?.apiResponseState = ApiRequestResponseState.error
                responseErrorObj = ApiResponse(err: "ApiRequestResponseState.httpError")
                break
            }
            
        }
        else {
            responseErrorObj = ApiResponse(err: "ApiRequestResponseState.genericError")
        }
        
        self.apiRequestCommand?.returnObject = responseErrorObj
    }
    
    
}

