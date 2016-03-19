//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkConfig {
    static let useTestConfig: Bool = UITesting() ? true : false
}

private func UITesting() -> Bool {
    return NSProcessInfo.processInfo().arguments.contains("UI-TESTING")
}
