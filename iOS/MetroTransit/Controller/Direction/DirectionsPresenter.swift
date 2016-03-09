//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class DirectionsPresenter {
    unowned let view: DirectionsView
    
    let route: Route
    
    required init(view: DirectionsView, route: Route) {
        self.view = view
        self.route = route
    }
    
    func getDirections() {
        Direction.get(route, complete: { (directions) -> Void in
            self.route.directions = NSMutableOrderedSet(array: directions)
            self.view.reload()
            })
    }
}