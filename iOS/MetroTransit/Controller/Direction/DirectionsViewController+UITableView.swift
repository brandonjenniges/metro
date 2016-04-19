//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension DirectionsViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let directions = self.viewModel.route.directions {
            return directions.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let direction = self.viewModel.route.directions![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = direction.name!
        return cell
    }
}
