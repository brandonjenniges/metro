//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class RoutesPresenter {
    unowned let view: RoutesView
    
    var routes = [Route]()
    var displayRoutes = [Route]()
    var vehicles = [VehicleLocation]()
    
    required init(view: RoutesView) {
        self.view = view
    }
    
    func getRoutes() {
        Route.getRoutes(complete: { (routes) -> Void in
            self.routes = routes
            self.displayRoutes = routes
            self.view.reload()
        })
    }
}