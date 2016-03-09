//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class DirectionsViewController: UIViewController, DirectionsView {
    static let segue = "showDirections"
    
    @IBOutlet weak var tableview: UITableView!
    var presenter: DirectionsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.presenter.route.name!
        self.presenter.getDirections()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! StopsViewController
        viewController.direction = self.presenter.route.directions![tableview.indexPathForSelectedRow!.row] as! Direction
    }
    
    // MARK: - Directions view
    
    func reload() {
        self.tableview.reloadData()
    }
}