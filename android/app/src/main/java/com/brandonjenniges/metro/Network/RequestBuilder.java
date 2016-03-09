package com.brandonjenniges.metro.Network;

import com.brandonjenniges.metro.BuildConfig;
import com.facebook.stetho.okhttp3.StethoInterceptor;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

public class RequestBuilder {
    private static String SERVER_URL = "http://svc.metrotransit.org/NexTrip/";

    // Method to override baseURL for unit and instrumentation testing
    public static void overrideBaseURL(String baseURL) {
        RequestBuilder.SERVER_URL = baseURL;
    }

    public static Retrofit getRetrofit() {

        OkHttpClient client;
        if (BuildConfig.BUILD_TYPE.equals("debug")) {
            // chrome://inspect
            client = new OkHttpClient.Builder()
                    .addNetworkInterceptor(new StethoInterceptor())
                    .build();
        } else {
            client = new OkHttpClient();
        }

        return new Retrofit.Builder()
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .addConverterFactory(GsonConverterFactory.create())
                .baseUrl(SERVER_URL)
                .client(client)
                .build();
    }
}