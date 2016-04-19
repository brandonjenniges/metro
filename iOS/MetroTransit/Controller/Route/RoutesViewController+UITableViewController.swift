//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

extension RoutesViewController: UITableViewDelegate {
    
    // MARK : - UITableView delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showScreenPicker()
    }
}
