//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension RoutesViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.routes.updateRoutes(Routes.getRoutesContainingName(searchText, routes: self.viewModel.objects.value))
        self.viewModel.listener.reload()
    }
}