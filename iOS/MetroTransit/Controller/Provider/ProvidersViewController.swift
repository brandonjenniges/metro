//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class ProvidersViewController: UIViewController, ProvidersViewModelListener {

    @IBOutlet weak var tableview: UITableView!
    var viewModel: ProvidersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ProvidersViewModel(listener: self)
        self.viewModel.getProviders()
    }
    
    // MARK: - Providers view
    
    func reload() {
        self.tableview.reloadData()
    }
}