//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class DirectionsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var route: Route!
    static let segue = "showDirections"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = route.name!
        getDirections()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! StopsViewController
        viewController.direction = route.directions![tableview.indexPathForSelectedRow!.row] as! Direction
    }
    
    func getDirections() {
        Direction.getDirections(route, success: { (directions) -> Void in
            self.route.directions = NSMutableOrderedSet(array: directions)
            self.tableview.reloadData()
            }) { (directions, error) -> Void in
                
        }
    }
    
    // MARK: - UITableview datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let directions = route.directions {
            return directions.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let direction = route.directions![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = direction.name!
        return cell
    }
}