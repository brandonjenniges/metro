//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import CoreData
import Alamofire

extension Provider {
    
    // MARK: - Core Data
    
    static func insert(attributes: [String : AnyObject], managedObjectContext:NSManagedObjectContext) -> Provider {
        let entity = NSEntityDescription.entityForName("Provider", inManagedObjectContext: managedObjectContext)
        let provider = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Provider
        
        if let stringValue = attributes["Value"] as? String, let intValue = Int(stringValue) {
            provider.value = NSNumber(integer: intValue)
        }
        
        provider.text = attributes["Text"] as? String
        return provider
    }
    
    // MARK: - Metro API
    
    static func getProviders(success onSuccess:(providers:[Provider])->Void, failure onFailure:(providers:[Provider], error:NSError?)->Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Providers", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var providers = [Provider]()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        let provider = insert(item, managedObjectContext: appDelegate.managedObjectContext)
                        providers.append(provider)
                    }
                    onSuccess(providers: providers)
                } else {
                    onFailure(providers: providers, error: nil)
                }
        }
    }
    
}
