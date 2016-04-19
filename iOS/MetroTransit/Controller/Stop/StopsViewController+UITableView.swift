//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension StopsViewController: UITableViewDataSource {
    
    // MARK: - UITableview datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stops = self.viewModel.direction.stops {
            return stops.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let stop = self.viewModel.direction.stops![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = stop.name!
        return cell
    }
}
