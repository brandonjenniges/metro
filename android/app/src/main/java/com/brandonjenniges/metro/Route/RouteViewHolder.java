package com.brandonjenniges.metro.Route;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.brandonjenniges.metro.R;

import butterknife.Bind;
import butterknife.ButterKnife;

public class RouteViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
    public @Bind(R.id.route_tv) TextView routeTextView;

    private Callback callback;

    public RouteViewHolder(View view, Callback callback) {
        super(view);
        ButterKnife.bind(this, view);
        view.setOnClickListener(this);
        this.callback = callback;
    }

    @Override
    public void onClick(View view) {
        callback.selectedLocationRow(getLayoutPosition());
    }

    public interface Callback {
        void selectedLocationRow(int row);
    }
}
