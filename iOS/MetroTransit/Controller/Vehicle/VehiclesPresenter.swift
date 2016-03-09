//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class VehiclesPresenter {
    unowned let view: VehiclesView
    
    required init(view: VehiclesView) {
        self.view = view
    }
}