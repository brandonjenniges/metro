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
        
        guard let name = json["Text"] as? String,
            let stringValue = json["Value"] as? String,
            let value = Int(stringValue)
            else { return nil }
        
        self.text = name
        self.value = NSNumber(integer: value)
    }
    
    // MARK: - Metro API
    
    static func get(complete complete:(providers:[Provider]) -> Void) {
        let URL = NSURL(string: "http://svc.metrotransit.org/NexTrip/Providers")
        HTTPClient().get(URL!, parameters: ["format": "json"]) { (json:AnyObject?, response:NSHTTPURLResponse?, error:NSError?) -> Void in
            
            var providers = [Provider]()
            if let json = json  as? [[String : AnyObject]] {
                for item in json {
                    if let provider = Provider(json: item) {
                        providers.append(provider)
                    }
                }
            }
            complete(providers: providers)
        }
    }
}