import Foundation

class ApiResponse {
    var get : String
    var parameters : [String: Any]? = nil
    var errors: [Any?]
    var results : Int = 0
    
    init(err: String) {
        self.get = ""
        self.errors = []
        self.errors.append(err)
    }
    
    init(json: JSON) {
        self.get = json["get"].stringValue
         self.parameters = json["parameters"].dictionaryObject
         self.errors = json["errors"].arrayValue
        
         if let count  = json["results"].int {
             self.results = count
         }
    }
    
}

class ApiResponseObject<T> : ApiResponse {
     
    var response : [T] = []
    
    init(json: JSON, object: T) {
        
        super.init(json: json)
        self.response.append(object)
        
    }
    
    init(json: JSON, objectList: [T]) {
        
        super.init(json: json)
        self.response = objectList
        
    }
    
}
 
