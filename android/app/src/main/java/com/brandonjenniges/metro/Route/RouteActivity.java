package com.brandonjenniges.metro.Route;

import android.os.Bundle;
import android.support.annotation.UiThread;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.widget.Toast;

import com.brandonjenniges.metro.R;
import com.brandonjenniges.metro.View.RecyclerViewListDivider;

import butterknife.Bind;
import butterknife.ButterKnife;

public class RouteActivity extends AppCompatActivity implements RouteView {

    @Bind(R.id.routes_rv)
    RecyclerView mRecyclerView;

    private RoutePresenter presenter;
    private RouteListAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_route);
        ButterKnife.bind(this);

        presenter = new RoutePresenter(this);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        setupRecyclerView();
    }

    @Override
    public void selectedRouteRow(int row) {
        Toast.makeText(getApplicationContext(), presenter.getRoutes()[row].getName(), Toast.LENGTH_SHORT).show();
    }

    @Override @UiThread
    public void reload() {
        mAdapter.setRoutes(presenter.getRoutes());
        mAdapter.notifyDataSetChanged();
    }

    private void setupRecyclerView() {
        mRecyclerView.setHasFixedSize(true);
        RecyclerView.LayoutManager mLayoutManager = new LinearLayoutManager(this);
        mRecyclerView.setLayoutManager(mLayoutManager);

        mRecyclerView.addItemDecoration(
                new RecyclerViewListDivider(this, R.drawable.divider));

        mAdapter = new RouteListAdapter(presenter.getRoutes(), presenter);
        mRecyclerView.setAdapter(mAdapter);
    }
}
