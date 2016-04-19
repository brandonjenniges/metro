//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class StopsViewController: UIViewController, StopsViewModelListener {
    
    @IBOutlet weak var tableview: UITableView!
    var viewModel: StopsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.viewModel.direction.name
        self.viewModel.getStops()
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