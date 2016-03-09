package com.brandonjenniges.metro.Route;

import com.brandonjenniges.metro.Model.Route;

import retrofit2.http.GET;
import rx.Observable;

public interface RouteService {
    @GET("Routes?format=json")
    Observable<Route[]> routes();

    interface Callback {
        void receivedRoutes(Route[] routes);
    }

}
