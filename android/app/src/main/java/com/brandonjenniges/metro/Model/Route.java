package com.brandonjenniges.metro.Model;

import com.google.gson.annotations.SerializedName;

public class Route {
    @SerializedName("Description")
    private String name;
    @SerializedName("Route")
    private long routeNumber;

    public Route(String name, long routeNumber) {
        this.name = name;
        this.routeNumber = routeNumber;
    }

    public long getRouteNumber() {
        return routeNumber;
    }

    public void setRouteNumber(long routeNumber) {
        this.routeNumber = routeNumber;
    }

    public String getName() {
        return name;
    }
    //private Direction[] directions;

    public void setName(String name) {
        this.name = name;
    }
}
