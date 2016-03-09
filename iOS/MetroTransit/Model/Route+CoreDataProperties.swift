//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import Foundation
import CoreData

extension Route {

    @NSManaged var name: String?
    @NSManaged var providerId: NSNumber?
    @NSManaged var routeNumber: NSNumber?
    @NSManaged var directions: NSOrderedSet?
    @NSManaged var provider: Provider?

}
