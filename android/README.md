# metro

A demo Android application that utilizes the [NexTrip API][1]. This app is used for demonstrating various Android development practices.

## Pre-requisites

- Java 1.8
- Android SDK v23
- Gradle 2.8

## Getting Started

This project uses the Gradle build system. To build this project, use the "gradlew build" command or use "Import Project" in Android Studio.

## Development Examples

### MVP

Model View Presenter (MVP) is a derivative of the Model View Controller (MVC) design pattern. MVP is great for Android development because it allows a break from often made mistakes of trying to fit everything into a more Model View pattern which results in the Activity/Fragment becoming too complex.

MVP enforces a separation of complexity into various layers. This allows the app to have smaller objects, simpler tasks and become more testable.

### Retrofit + RxJava

Network requests are made using a combination of [Retrofit 2][2] and [RxJava][3].

```java
public interface RouteService {
    @GET("Routes?format=json")
    Observable<Route[]> routes();
}

```
```java
RouteService service = RequestBuilder.getRetrofit().create(RouteService.class);
Observable<Route[]> routes = service.routes();

routes.subscribeOn(Schedulers.newThread())
	.observeOn(AndroidSchedulers.mainThread())
	.subscribe(subscriber);
```
RxJava is also used heavily in other parts of the application. Example of text change in SearchView:

 ```java
RxSearchView.queryTextChanges(searchView)
	.observeOn(AndroidSchedulers.mainThread())
	.subscribe(charSequence -> {
		presenter.filterRoutes(charSequence.toString());
	});
 ``` 
 ```java
public void filterRoutes(final String s) {
	Observable.from(routes)
		.filter(route -> Pattern.compile(Pattern.quote(s), Pattern.CASE_INSENSITIVE).matcher(route.getName()).find())
		.subscribe(subscriber);
}
 ```

### Web Server Response Stubbing

Using [MockWebServer][4] to stub out network requests with controlled user defined responses from a local mock web server.

```java
MockWebServer server = new MockWebServer();
MockResponse mockResponse = new MockResponse();
mockResponse.setBody("[{\"Description\":\"Stubbed Route\",\"ProviderID\":\"8\",\"Route\":\"901\"}]");
mockResponse.setResponseCode(201);
server.enqueue(mockResponse);
server.start();
```
This allows for easy and controlled UI Testing using [Espresso][5]  

### Code Coverage Reporting

I used [JacocoEverywhere][6] to combine code coverage reports for unit and instrumentation tests.

```gradle
./gradlew connectedCheck
```

## License

This project is released under the MIT license. See LICENSE for details.

[1]: http://svc.metrotransit.org/
[2]: https://github.com/square/retrofit
[3]: https://github.com/ReactiveX/RxJava
[4]: https://github.com/square/okhttp/tree/master/mockwebserver
[5]: https://google.github.io/android-testing-support-library/docs/espresso/
[6]: https://github.com/paveldudka/JacocoEverywhere