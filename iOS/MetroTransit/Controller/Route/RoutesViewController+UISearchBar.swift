//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension RoutesViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.displayRoutes = Route.getRoutesContainingName(searchText, routes: self.viewModel.routes)
        self.tableview.reloadData()
    }
}