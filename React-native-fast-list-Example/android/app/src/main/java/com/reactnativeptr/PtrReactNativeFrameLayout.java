package com.reactnativeptr;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;

import in.srain.cube.views.ptr.PtrFrameLayout;

/**
 * Created by hushicai on 2017/8/13.
 */

public class PtrReactNativeFrameLayout extends PtrFrameLayout {
    private PtrReactNativeHeader mPtrReactNativeHeader;

    public PtrReactNativeFrameLayout(Context context) {
        super(context);
        initViews();
    }

    public PtrReactNativeFrameLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
        initViews();
    }

    public PtrReactNativeFrameLayout(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        initViews();
    }

    public void initViews() {
        mPtrReactNativeHeader = new PtrReactNativeHeader(getContext());
        setHeaderView(mPtrReactNativeHeader);
        addPtrUIHandler(mPtrReactNativeHeader);
    }

    public PtrReactNativeHeader getHeader() {
        return mPtrReactNativeHeader;
    }

    /**
     * update layout when rn addView
     */
    public void setContentView(View content) {
        if (mContent != null && content != null && mContent != content) {
            removeView(content);
        }

        mContent = content;
        addView(content);

//        super.onFinishInflate();
    }
}
