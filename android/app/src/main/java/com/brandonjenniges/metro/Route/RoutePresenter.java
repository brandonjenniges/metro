package com.brandonjenniges.metro.Route;

import com.brandonjenniges.metro.Model.Route;
import com.brandonjenniges.metro.Network.RequestBuilder;

import java.util.ArrayList;
import java.util.regex.Pattern;

import rx.Observable;
import rx.Subscriber;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

public class RoutePresenter implements RouteViewHolder.Callback, RouteService.Callback {

    private RouteView view;
    private Route[] routes;
    private Route[] displayRoutes;

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

    public Route[] getDisplayRoutes() {
        if (displayRoutes == null) {
            return new Route[]{};
        }
        return displayRoutes;
    }

    @Override
    public void receivedRoutes(Route[] routes) {
        this.routes = routes;
        this.displayRoutes = routes;
        view.reload();
    }

    public void filterRoutes(final String s) {
        if (routes == null) { return; }

        ArrayList<Route> tempRoutes = new ArrayList<>();
            Observable.from(routes)
                    .filter(route -> Pattern.compile(Pattern.quote(s), Pattern.CASE_INSENSITIVE).matcher(route.getName()).find())
                    .subscribe(new Subscriber<Route>() {
            @Override
            public void onCompleted() {
                Route[] filteredRoutes = new Route[tempRoutes.size()];
                filteredRoutes = tempRoutes.toArray(filteredRoutes);
                displayRoutes = filteredRoutes;
                view.reload();
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(Route route) {
                tempRoutes.add(route);
            }
        });
    }
}
