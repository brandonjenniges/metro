//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class StopsPresenter {
    unowned let view: StopsView
    
    let direction: Direction
    
    required init(view: StopsView, direction: Direction) {
        self.view = view
        self.direction = direction
    }
    
    func getStops() {
        Stop.get(direction, complete: { (routes) -> Void in
            self.direction.stops = NSOrderedSet(array: routes)
            self.view.reload()
        })
    }
}