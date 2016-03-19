# metro

A demo iOS application that utilizes the [NexTrip API][1]. This app is used for demonstrating various iOS development practices.

## Pre-requisites

- iOS 8
- Swift 2
- Xcode 7

## Getting Started

This project uses [CocoaPods][2]. To build this project, install cocoapods and use the
"pod install" command. After pods install, open "MetroTransit.xcworkspace" in Xcode.

## Development Examples

### MVP

Model View Presenter (MVP) is a derivative of the Model View Controller (MVC) design pattern. MVP is great for iOS development because it allows a break from often made mistakes of trying to fit everything into the UIViewController.

MVP enforces a separation of complexity into various layers. This allows the app to have smaller objects, simpler tasks and become more testable.

### Alamofire

Network requests made using the popular HTTP networking library [Alamofire][3].

### Stubbing Network Requests
Using [OHHTTPStubs][4], network requests can easily be stubbed to provide controlled data for unit tests.

```swift
let readyExpectation = expectationWithDescription("request")
        
stub(isMethodGET()) { _ in
    let stubPath = OHPathForFile("full_routes.txt", self.dynamicType)
    return fixture(stubPath!, status: 200, headers: ["Content-Type":"application/json"])
}
    
Route.getRoutes { (routes) -> Void in
    XCTAssert(routes.count == 221)
    readyExpectation.fulfill()
}
    
waitForExpectationsWithTimeout(5.0) { (error: NSError?) -> Void in
```
### UI Testing with Stubbed Network Data

Xcode's UI Tests can be a great tool to improve the quality of code you're writing. However, attempting to create UI tests for apps that rely on a web server can be very difficulty. 

The above method worked great for stubbing our data for the unit tests but it doesn't work as nicely for UI tests because the application is first launched and then the UI testing bundle is injected into the app's bundle.

I've struggled to find a great way to be able to achieve stubbed server responses while UI testing.  Most ways require stuffing your production app with test code and fake responses that are only used when you're running the UI Tests. Joe Masilotti's [article][5] offers the best idea that I've seen so far.  It requires very little production altering code to get network requesting stubbing up and running.

#### Example


UI testing target:

```swift
let app = XCUIApplication()
let routeResponse = "[{\"Description\":\"METRO Blue Line\",\"ProviderID\":\"8\"}]"

app.launchArguments += ["UI-TESTING"]        
app.launchEnvironment["http://svc.metrotransit.org/NexTrip/Routes"] = routeResponse
app.launch()
```
App target's HTTPClient

```swift
let useTestConfig = NSProcessInfo.processInfo().arguments.contains("UI-TESTING")

func get(url: NSURL, parameters: [String: AnyObject]?, completion: HTTPResult) {
	if useTestConfig {
		if let json = NSProcessInfo.processInfo().environment[url.absoluteString] {
			let response = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
	      	let data = json.dataUsingEncoding(NSUTF8StringEncoding)
	      	completion(parse(data), response, nil)
	   	} else {
			print("Unable to find json")
	   }
	}
}
```
### Screenshots using Fastlane
TODO

## License
This project is released under the MIT license. See LICENSE for details.


[1]: http://svc.metrotransit.org/
[2]: http://cocoapods.org/
[3]: https://github.com/Alamofire/Alamofire
[4]: https://github.com/AliSoftware/OHHTTPStubs
[5]: http://masilotti.com/testing-nsurlsession/
[6]: https://travis-ci.org/steveholt55/metro