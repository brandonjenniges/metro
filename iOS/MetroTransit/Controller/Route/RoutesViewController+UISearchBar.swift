//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension RoutesViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.displayRoutes = Route.getRoutesContainingName(searchText, routes: self.presenter.routes)
        self.tableview.reloadData()
    }
}