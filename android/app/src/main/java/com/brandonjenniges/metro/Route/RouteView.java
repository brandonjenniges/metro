package com.brandonjenniges.metro.Route;

import com.brandonjenniges.metro.Model.Route;

interface RouteView {
    void selectedRouteRow(int row);
    void setRoutes(Route[] routes);
}
