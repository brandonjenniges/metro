//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import CoreData

extension Direction {

    @NSManaged var name: String?
    @NSManaged var value: NSNumber?
    @NSManaged var route: Route?
    @NSManaged var stops: NSOrderedSet?

}
