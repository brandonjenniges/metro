//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import CoreData
import Alamofire

extension Provider {
    
    // MARK: - Core Data
    
    convenience init?(json: [String : AnyObject]) {
        let entity = Provider.getEntity(String(Provider))
        self.init(entity: entity, insertIntoManagedObjectContext: Provider.getManagedObjectContext())
        
        guard let name = json["Text"] as? String, let stringValue = json["Value"] as? String, let value = Int(stringValue) else { return nil }
        
        self.text = name
        self.value = NSNumber(integer: value)
    }
    
    // MARK: - Metro API
    
    static func get(complete complete:(providers:[Provider]) -> Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Providers", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var providers = [Provider]()
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        if let provider = Provider(json: item) {
                            providers.append(provider)
                        }
                    }
                }
                complete(providers: providers)
        }
    }
    
}
