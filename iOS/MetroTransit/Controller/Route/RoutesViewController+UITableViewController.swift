//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension RoutesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK : - UITableView datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.displayRoutes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let route = self.presenter.displayRoutes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = route.name!
        return cell
    }
    
    // MARK : - UITableView delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showScreenPicker()
    }
}
