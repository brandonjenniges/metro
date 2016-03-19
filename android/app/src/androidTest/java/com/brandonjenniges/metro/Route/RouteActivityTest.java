package com.brandonjenniges.metro.Route;

import android.support.test.InstrumentationRegistry;
import android.support.test.espresso.contrib.RecyclerViewActions;
import android.test.ActivityInstrumentationTestCase2;

import com.brandonjenniges.metro.Network.RequestBuilder;
import com.brandonjenniges.metro.R;

import okhttp3.HttpUrl;
import okhttp3.mockwebserver.MockResponse;
import okhttp3.mockwebserver.MockWebServer;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.assertion.ViewAssertions.doesNotExist;
import static android.support.test.espresso.assertion.ViewAssertions.matches;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withId;
import static android.support.test.espresso.matcher.ViewMatchers.withText;

public class RouteActivityTest extends ActivityInstrumentationTestCase2<RouteActivity> {
    RouteActivity activity;

    public RouteActivityTest() {
        super(RouteActivity.class);
    }

    @Override
    protected void setUp() throws Exception {
        super.setUp();

        injectInstrumentation(InstrumentationRegistry.getInstrumentation());
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    public void test_SelectFirstRouteInList() throws Exception {
        MockWebServer server = stubSimpleRouteResponse();
        activity = getActivity();

        // Validate stubbed text exists
        onView(withText("Stubbed Route"))
                .check(matches(isDisplayed()));

        // Select route
        onView(withId(R.id.routes_rv)).perform(
                RecyclerViewActions.actionOnItemAtPosition(0, click()));

        server.shutdown();
    }

    public void test_NoRoutesReceivedFromSever() throws Exception {
        MockWebServer server = stubErrorRouteResponse();
        activity = getActivity();

        // Validate stubbed text doesn't exist in view
        onView(withText("Stubbed Route"))
                .check(doesNotExist());

        server.shutdown();
    }

    public MockWebServer stubSimpleRouteResponse() throws Exception {
        MockWebServer server = new MockWebServer();
        MockResponse mockResponse = new MockResponse();
        mockResponse.setBody("[{\"Description\":\"Stubbed Route\",\"ProviderID\":\"8\",\"Route\":\"901\"}]");
        mockResponse.setResponseCode(201);
        server.enqueue(mockResponse);
        server.start();

        HttpUrl baseUrl = server.url("");
        RequestBuilder.overrideBaseURL(baseUrl.toString());
        return server;
    }

    public MockWebServer stubErrorRouteResponse() throws Exception {
        MockWebServer server = new MockWebServer();
        MockResponse mockResponse = new MockResponse();
        mockResponse.setBody(""); //TODO: add what actual error response is
        mockResponse.setResponseCode(500);
        server.enqueue(mockResponse);
        server.start();

        HttpUrl baseUrl = server.url("");
        RequestBuilder.overrideBaseURL(baseUrl.toString());
        return server;
    }
}