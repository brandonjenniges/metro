package com.brandonjenniges.metro.Route;

import com.brandonjenniges.metro.Model.Route;
import com.brandonjenniges.metro.Network.RequestBuilder;

import rx.Observable;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

public class RoutePresenter implements RouteViewHolder.Callback, RouteService.Callback {

    private RouteView view;
    private Route[] routes;

    RouteSubscriber subscriber = new RouteSubscriber(this);

    public RoutePresenter(RouteView view) {
        this.view = view;

        RouteService service = RequestBuilder.getRetrofit().create(RouteService.class);
        Observable<Route[]> routes = service.routes();

        routes.subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(subscriber);
    }

    @Override
    public void selectedLocationRow(int row) {
        view.selectedRouteRow(row);
    }

    public Route[] getRoutes() {
        if (routes == null) {
            return new Route[]{};
        }
        return routes;
    }

    @Override
    public void receivedRoutes(Route[] routes) {
        this.routes = routes;
        view.reload();
    }
}
