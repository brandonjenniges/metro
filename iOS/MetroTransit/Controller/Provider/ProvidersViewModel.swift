//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class ProvidersViewModel {
    
    unowned let listener: ProvidersViewModelListener
    var providers = [Provider]()
    
    required init(listener: ProvidersViewModelListener) {
        self.listener = listener
    }
    
    func getProviders() {
        Provider.get(complete: { (providers) -> Void in
            self.providers = providers
            self.listener.reload()
        })
    }
}

protocol ProvidersViewModelListener: class {
    func reload()
}