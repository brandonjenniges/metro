//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class RoutesViewController: UIViewController, RoutesViewModelListener {
    
    @IBOutlet weak var tableview: UITableView!
    var viewModel: RoutesViewModel!
    
    //test
    let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RoutesViewModel(listener: self)
        
        if !AppDelegate.isTesting() { // Needed to make mock server work for testing
            self.viewModel.getRoutes()
        }
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
            viewController.viewModel = DirectionsViewModel(listener: viewController, route: self.viewModel.displayRoutes[tableview.indexPathForSelectedRow!.row])
        } else if segue.identifier == VehiclesViewController.segue {
            let viewController = segue.destinationViewController as! VehiclesViewController
            let route = self.viewModel.displayRoutes[tableview.indexPathForSelectedRow!.row]
            let vehicles = self.viewModel.vehicles
            viewController.viewModel = VehiclesViewModel(listener: viewController, route: route, vehicles: vehicles)
        }
    }
    
    static func getViewController() -> RoutesViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(String(RoutesViewController)) as! RoutesViewController
    }
    
    // MARK : - Screen
    
    func showScreenPicker() {
        let route = self.viewModel.displayRoutes[tableview.indexPathForSelectedRow!.row]
        let controller = UIAlertController(title: route.name, message: nil, preferredStyle: .ActionSheet)
        
        let directionsAction = UIAlertAction(title: "Directions", style: .Default, handler: { (action: UIAlertAction) -> Void in
            self.performSegueWithIdentifier(DirectionsViewController.segue, sender: self)
        })
        
        let vehiclesAction = UIAlertAction(title: "Vehicles", style: .Default, handler: { (action: UIAlertAction) -> Void in
            VehicleLocation.get(route, complete: { (vehicles) -> Void in
                self.viewModel.vehicles = vehicles
                if (vehicles.count > 0) {
                    self.performSegueWithIdentifier(VehiclesViewController.segue, sender: self)
                } else {
                    self.alertNoVehicles(route)
                }
                })
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
    
    // MARK: - Routes view
    
    func reload() {
        self.tableview.reloadData()
    }
}