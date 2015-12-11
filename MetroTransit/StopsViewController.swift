//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class StopsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var direction: Direction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStops()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    func getStops() {
        Stop.getStops(direction, success: { (routes) -> Void in
            self.direction.stops = NSOrderedSet(array: routes)
            self.tableview.reloadData()
            }) { (routes, error) -> Void in
                
        }
    }
    
    // MARK: - UITableview datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stops = self.direction.stops {
            return stops.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let stop = self.direction.stops![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = stop.name!
        return cell
    }
}