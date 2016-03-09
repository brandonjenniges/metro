//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class StopsViewController: UIViewController, StopsView {
    
    @IBOutlet weak var tableview: UITableView!
    var presenter: StopsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.presenter.direction.name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableview.indexPathForSelectedRow {
            tableview.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    // MARK: - Stops view
    
    func reload() {
        self.tableview.reloadData()
    }
}