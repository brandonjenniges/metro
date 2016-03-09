//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class RoutesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var routes = [Route]()
    var displayRoutes = [Route]()
    var vehicles = [VehicleLocation]()
    
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
            viewController.presenter = DirectionsPresenter(view: viewController, route: displayRoutes[tableview.indexPathForSelectedRow!.row])
        } else if segue.identifier == VehiclesViewController.segue {
            let viewController = segue.destinationViewController as! VehiclesViewController
            viewController.route = displayRoutes[tableview.indexPathForSelectedRow!.row]
            viewController.vehicles = self.vehicles
        }
    }
    
    func getRoutes() {
        Route.getRoutes(success: { (routes) -> Void in
            self.routes = routes
            self.displayRoutes = routes
            self.tableview.reloadData()
            }) { (routes, error) -> Void in
                
        }
    }
    
    static func getViewController() -> RoutesViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(String(RoutesViewController)) as! RoutesViewController
    }
    
    // MARK : - UITableView datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRoutes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let route = displayRoutes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = route.name!
        return cell
    }
    
    // MARK : - UITableView delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showScreenPicker()
    }
    
    // MARK : - UISearchBar delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.displayRoutes = Route.getRoutesContainingName(searchText, routes: routes)
        self.tableview.reloadData()
    }
    
    // MARK : - Screen
    
    func showScreenPicker() {
        let route = displayRoutes[tableview.indexPathForSelectedRow!.row]
        let controller = UIAlertController(title: route.name, message: nil, preferredStyle: .ActionSheet)
        
        let directionsAction = UIAlertAction(title: "Directions", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier(DirectionsViewController.segue, sender: self)
        })
        
        let vehiclesAction = UIAlertAction(title: "Vehicles", style: .Default, handler: { (action: UIAlertAction) -> Void in
            VehicleLocation.getVehicles(route, success: { (vehicles) -> Void in
                self.vehicles = vehicles
                if (vehicles.count > 0) {
                    self.performSegueWithIdentifier(VehiclesViewController.segue, sender: self)
                } else {
                    self.alertNoVehicles(route)
                }
                }) { (routes, error) -> Void in
                    
            }
        })
        
        controller.addAction(directionsAction)
        controller.addAction(vehiclesAction)
        controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
            if let selectedIndexPath = self.tableview.indexPathForSelectedRow {
                self.tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
            }
        }))
        
        self.presentViewController(controller, animated: true, completion:nil)
    }
    
    func alertNoVehicles(route: Route) {
        let title = route.name!
        let message = "There are currently no active vehicles for this route."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}