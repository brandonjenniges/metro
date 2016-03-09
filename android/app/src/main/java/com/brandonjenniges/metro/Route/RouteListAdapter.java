package com.brandonjenniges.metro.Route;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.brandonjenniges.metro.Model.Route;
import com.brandonjenniges.metro.R;

public class RouteListAdapter extends RecyclerView.Adapter<RouteViewHolder> {
    private Route[] routes;
    private RoutePresenter presenter;

    public RouteListAdapter(Route[] routes, RoutePresenter presenter) {
        this.routes = routes;
        this.presenter = presenter;
    }

    public void setRoutes(Route[] routes) {
        this.routes = routes;
    }

    @Override
    public RouteViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.route_list_row, null);
        RouteViewHolder viewHolder = new RouteViewHolder(view, presenter);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(RouteViewHolder locationViewHolder, int i) {
        Route route = routes[i];
        locationViewHolder.routeTextView.setText(route.getName());
    }

    @Override
    public int getItemCount() {
        return routes.length;
    }
}