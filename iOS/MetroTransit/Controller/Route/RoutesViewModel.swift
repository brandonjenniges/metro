//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import ReactiveCocoa

class RoutesViewModel {
    
    unowned let listener: RoutesViewModelListener
    
    let routes = Routes()
    var objects = MutableProperty<[Route]>([Route]())
    
    var vehicles = [VehicleLocation]()
    
    required init(listener: RoutesViewModelListener) {
        self.listener = listener
    }
    
    func getRoutes() {
        Routes.get(complete: { (routes) -> Void in
            self.routes.updateRoutes(routes)
            self.objects.value = routes
            self.listener.reload()
        })
    }
}

protocol RoutesViewModelListener: class {
    func reload()
}