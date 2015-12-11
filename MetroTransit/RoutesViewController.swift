//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class RoutesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var routes = [Route]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRoutes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == DirectionsViewController.segue {
            let viewController = segue.destinationViewController as! DirectionsViewController
            viewController.route = routes[tableview.indexPathForSelectedRow!.row]
        } else if segue.identifier == VehiclesViewController.segue {
            let viewController = segue.destinationViewController as! VehiclesViewController
            viewController.route = routes[tableview.indexPathForSelectedRow!.row]
        }
    }
    
    func getRoutes() {
        Route.getRoutes(success: { (routes) -> Void in
            self.routes = routes
            self.tableview.reloadData()
            }) { (routes, error) -> Void in
                
        }
    }
    
    // MARK: - UITableview datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let route = routes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = route.name!
        return cell
    }
    
    // MARK: - UITableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showScreenPicker()
    }
    
    // MARK: - Screen
    
    func showScreenPicker() {
        let controller = UIAlertController(title: "Choose", message: "Choose", preferredStyle: .ActionSheet)
        let directionsAction = UIAlertAction(title: "Directions", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier(DirectionsViewController.segue, sender: self)
        })
        let vehiclesAction = UIAlertAction(title: "Vehicles", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier(VehiclesViewController.segue, sender: self)
        })
        controller.addAction(directionsAction)
        controller.addAction(vehiclesAction)
        self.presentViewController(controller, animated: true, completion: nil)
    }
}