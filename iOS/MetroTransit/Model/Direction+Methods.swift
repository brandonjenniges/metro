//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import CoreData
import Alamofire

extension Direction {
    enum RouteDirection: Int {
        case South = 1, East = 2, West = 3, North = 4
    }
    
    // MARK: - Core Data
    
    convenience init?(json: [String : AnyObject]) {
        let entity = Direction.getEntity(String(Direction))
        self.init(entity: entity, insertIntoManagedObjectContext: Direction.getManagedObjectContext())
        
        guard let name = json["Text"] as? String, let stringValue = json["Value"] as? String, let value = Int(stringValue) else { return nil }
        
        self.name = name
        self.value = NSNumber(integer: value)
    }
    
    // MARK: - Metro API
    
    static func get(route: Route, complete:(directions:[Direction]) -> Void) {
        Alamofire.request(.GET, "http://svc.metrotransit.org/NexTrip/Directions/\(route.routeNumber!)", parameters: ["format": "json"])
            .responseJSON { response in
                debugPrint(response)
                
                var directions = [Direction]()
                if let JSON = response.result.value  as? [[String : AnyObject]] {
                    for item in JSON {
                        if let direction = Direction(json: item) {
                            directions.append(direction)
                        }
                    }
                }
                complete(directions: directions)
        }
    }
    
    // MARK: - Helper methods
    
    static func stringForDirection(direction: RouteDirection) -> String {
        switch direction {
        case .North:
            return "North"
        case .South:
            return "South"
        case .East:
            return "East"
        case .West:
            return "West"
        }
    }
    
    static func routeDirectionForInt(int: Int) -> RouteDirection {
        if let routeDirection = RouteDirection(rawValue: int) {
            return routeDirection
        }
        return .North
    }
}
