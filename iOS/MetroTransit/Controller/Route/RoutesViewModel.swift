//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class RoutesViewModel {
    
    unowned let listener: RoutesViewModelListener
    
    var routes = [Route]()
    var displayRoutes = [Route]()
    var vehicles = [VehicleLocation]()
    
    required init(listener: RoutesViewModelListener) {
        self.listener = listener
    }
    
    func getRoutes() {
        Route.getRoutes(complete: { (routes) -> Void in
            self.routes = routes
            self.displayRoutes = routes
            self.listener.reload()
        })
    }
}

protocol RoutesViewModelListener: class {
    func reload()
}