package com.brandonjenniges.metro;

import android.app.Application;

import com.facebook.stetho.Stetho;

public class MetroApplication extends Application{

    @Override
    public void onCreate() {
        super.onCreate();
        Stetho.initializeWithDefaults(this);
    }
}
