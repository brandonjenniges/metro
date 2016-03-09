//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation

class ProvidersPresenter {
    unowned let view: ProvidersView
    
    var providers = [Provider]()
    
    required init(view: ProvidersView) {
        self.view = view
        getProviders()
    }
    
    func getProviders() {
        Provider.get(complete: { (providers) -> Void in
            self.providers = providers
            self.view.reload()
        })
    }
}