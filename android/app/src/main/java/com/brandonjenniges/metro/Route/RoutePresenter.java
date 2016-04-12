package com.brandonjenniges.metro.Route;

import com.brandonjenniges.metro.Model.Route;
import com.brandonjenniges.metro.Network.RequestBuilder;

import java.util.regex.Pattern;

import rx.Observable;
import rx.Subscription;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

public class RoutePresenter implements RouteViewHolder.Callback {

    private RouteView view;
    private Route[] routes;

    Subscription routeSubscription;

    public RoutePresenter(RouteView view) {
        this.view = view;
    }

    public void onStart() {
        fetchRoutes();
    }

    public void onPause() {
        if (routeSubscription != null) {
            routeSubscription.unsubscribe();
        }
    }

    public void fetchRoutes() {
        RouteService service = RequestBuilder.getRetrofit().create(RouteService.class);
        routeSubscription = service.routes()
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(this::routesFetched);
    }

    public void routesFetched(Route[] routes) {
        this.routes = routes;
        this.view.setRoutes(routes);
    }

    public void filterRoutes(final String s) {
        if (routes == null) { return; }

        Observable.from(routes)
                .filter(route -> Pattern.compile(Pattern.quote(s), Pattern.CASE_INSENSITIVE).matcher(route.getName()).find())
                .toList()
                .map(routes -> routes.toArray(new Route[routes.size()]))
                .subscribe(view::setRoutes);
    }

    @Override
    public void selectedLocationRow(int row) {
        view.selectedRouteRow(row);
    }

}
