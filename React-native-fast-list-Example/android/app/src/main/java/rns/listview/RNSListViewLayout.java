package rns.listview;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.LinearLayout;

import com.example.R;

public class RNSListViewLayout extends LinearLayout {

    public  RNSListViewLayout(Context context, AttributeSet attrs){
        super(context, attrs);
        LayoutInflater.from(context).inflate(R.layout.rns_listview_layout,this);
    }
}
