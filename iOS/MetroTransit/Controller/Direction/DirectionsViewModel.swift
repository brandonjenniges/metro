//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class DirectionsViewModel {
    
    unowned let listener: DirectionsViewModelListener
    let route: Route
    
    required init(listener: DirectionsViewModelListener, route: Route) {
        self.listener = listener
        self.route = route
    }
    
    func getDirections() {
        Direction.get(route, complete: { (directions) -> Void in
            self.route.directions = NSMutableOrderedSet(array: directions)
            self.listener.reload()
        })
    }
}

protocol DirectionsViewModelListener: class {
    func reload()
}