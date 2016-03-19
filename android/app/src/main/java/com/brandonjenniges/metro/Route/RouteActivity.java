package com.brandonjenniges.metro.Route;

import android.app.SearchManager;
import android.os.Bundle;
import android.support.annotation.UiThread;
import android.support.v4.view.MenuItemCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SearchView;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.widget.Toast;

import com.brandonjenniges.metro.R;
import com.brandonjenniges.metro.View.RecyclerViewListDivider;
import com.jakewharton.rxbinding.support.v7.widget.RxSearchView;

import butterknife.Bind;
import butterknife.ButterKnife;
import rx.android.schedulers.AndroidSchedulers;

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
        Toast.makeText(getApplicationContext(), presenter.getDisplayRoutes()[row].getName(), Toast.LENGTH_SHORT).show();
    }

    @Override @UiThread
    public void reload() {
        mAdapter.setRoutes(presenter.getDisplayRoutes());
        mAdapter.notifyDataSetChanged();
    }

    private void setupRecyclerView() {
        mRecyclerView.setHasFixedSize(true);
        RecyclerView.LayoutManager mLayoutManager = new LinearLayoutManager(this);
        mRecyclerView.setLayoutManager(mLayoutManager);

        mRecyclerView.addItemDecoration(
                new RecyclerViewListDivider(this, R.drawable.divider));

        mAdapter = new RouteListAdapter(presenter.getDisplayRoutes(), presenter);
        mRecyclerView.setAdapter(mAdapter);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        setupSearchView(menu);
        return true;
    }

    public void setupSearchView(Menu menu) {
        final SearchView searchView = (SearchView) MenuItemCompat.getActionView(menu.findItem(R.id.action_search));
        // Text change listener
        RxSearchView.queryTextChanges(searchView)
                //.debounce(500, TimeUnit.MILLISECONDS)
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(charSequence -> {
                    presenter.filterRoutes(charSequence.toString());
                });
        SearchManager searchManager = (SearchManager) getSystemService(SEARCH_SERVICE);
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
    }
}
