//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    
    static func getManagedObjectContext() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    static func getEntity(name: String) -> NSEntityDescription {
        let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: getManagedObjectContext())
        return entity!
    }
}
