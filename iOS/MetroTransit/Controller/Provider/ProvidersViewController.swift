//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire

class ProvidersViewController: UIViewController, ProvidersView {

    @IBOutlet weak var tableview: UITableView!
    var presenter: ProvidersPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ProvidersPresenter(view: self)
        self.presenter.getProviders()
    }
    
    // MARK: - Providers view
    
    func reload() {
        self.tableview.reloadData()
    }
}