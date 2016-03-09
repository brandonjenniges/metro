//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import UIKit
import Alamofire


class ProvidersViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var providers = [Provider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProviders()
    }

    func getProviders() {
        Provider.getProviders(success: { (providers) -> Void in
            self.providers = providers
            self.tableview.reloadData()
            }) { (providers, error) -> Void in
                
        }
    }
    
    // MARK: - UITableview datasource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let provider = providers[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = provider.text!
        return cell
    }
}

