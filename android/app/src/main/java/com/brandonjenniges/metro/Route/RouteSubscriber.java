package com.brandonjenniges.metro.Route;

import android.util.Log;

import com.brandonjenniges.metro.Model.Route;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.ResponseBody;
import retrofit2.adapter.rxjava.HttpException;
import rx.Subscriber;

public class RouteSubscriber extends Subscriber<Route[]> {

    private RouteService.Callback presenter;

    public RouteSubscriber(RouteService.Callback presenter) {
        this.presenter = presenter;
    }

    @Override
    public void onCompleted() {

    }

    @Override
    public void onError(Throwable e) {
        e.printStackTrace();
        if (e instanceof HttpException) {
            ResponseBody body = ((HttpException) e).response().errorBody();
            try {
                String jsonString = body.string();
                JSONObject json = new JSONObject(jsonString).getJSONArray("errors").getJSONObject(0);
                Log.d("JSON", jsonString);
            } catch (IOException | JSONException e1) {
                e1.printStackTrace();
            }
        }

        presenter.receivedRoutes(new Route[]{});
    }

    @Override
    public void onNext(Route[] routes) {
        presenter.receivedRoutes(routes);
    }

}