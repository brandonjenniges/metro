//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class StopsViewModel {
    
    unowned let listener: StopsViewModelListener
    let direction: Direction
    
    required init(listener: StopsViewModelListener, direction: Direction) {
        self.listener = listener
        self.direction = direction
    }
    
    func getStops() {
        Stop.get(direction, complete: { (routes) -> Void in
            self.direction.stops = NSOrderedSet(array: routes)
            self.listener.reload()
        })
    }
}

protocol StopsViewModelListener: class {
    func reload()
}