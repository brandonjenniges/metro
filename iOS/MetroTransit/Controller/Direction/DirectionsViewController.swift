//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class DirectionsViewController: UIViewController, DirectionsViewModelListener {
    static let segue = "showDirections"
    
    @IBOutlet weak var tableview: UITableView!
    var viewModel: DirectionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.viewModel.route.name!
        self.viewModel.getDirections()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! StopsViewController
        let direction = self.viewModel.route.directions![tableview.indexPathForSelectedRow!.row] as! Direction
        viewController.viewModel = StopsViewModel(listener: viewController, direction: direction)
    }
    
    // MARK: - Directions view
    
    func reload() {
        self.tableview.reloadData()
    }
}