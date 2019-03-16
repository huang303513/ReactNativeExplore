package com.reactnativeptr;

import android.view.LayoutInflater;
import android.view.View;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.ViewGroupManager;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.Event;
import com.facebook.react.uimanager.events.RCTEventEmitter;

import java.util.Map;

import javax.annotation.Nullable;

import in.srain.cube.views.ptr.PtrDefaultHandler;
import in.srain.cube.views.ptr.PtrFrameLayout;

/**
 * Created by hushicai on 2017/8/12.
 */

public class PtrLayout extends ViewGroupManager<PtrReactNativeFrameLayout> {
    private static final int REFRESH_COMPLETE = 0;

    protected static final String REACT_CLASS = "PtrLayout";

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    protected PtrReactNativeFrameLayout createViewInstance(ThemedReactContext reactContext) {
        return new PtrReactNativeFrameLayout(reactContext);
    }

    @Nullable
    @Override
    public Map<String, Integer> getCommandsMap() {
        return MapBuilder.of("refreshComplete", REFRESH_COMPLETE);
    }

    @Override
    public void receiveCommand(PtrReactNativeFrameLayout root, int commandId, @Nullable ReadableArray args) {
        switch (commandId) {
            case REFRESH_COMPLETE:
                root.refreshComplete();
                break;
            default:
                break;
        }
    }

    @Override
    protected void addEventEmitters(final ThemedReactContext reactContext, final PtrReactNativeFrameLayout view) {
        view.setPtrHandler(
                new PtrDefaultHandler() {
                    @Override
                    public void onRefreshBegin(PtrFrameLayout frame) {
                        reactContext.getNativeModule(UIManagerModule.class)
                                .getEventDispatcher()
                                .dispatchEvent(new PtrRefreshEvent(view.getId()));
                    }
                }
        );
    }

    @Nullable
    @Override
    public Map<String, Object> getExportedCustomDirectEventTypeConstants() {
        return MapBuilder.<String, Object>builder()
                .put("ptrRefresh", MapBuilder.of("registrationName", "onPtrRefresh"))
                .build();
    }

    @Override
    public void addView(PtrReactNativeFrameLayout parent, View child, int index) {
        parent.setContentView(child);
    }

    // -----------------  styleable attrs ----------------

    @ReactProp(name = "resistance", defaultFloat = 1.7f)
    public void setResistance(PtrReactNativeFrameLayout view, float resistance) {
        view.setResistance(resistance);
    }

    @ReactProp(name = "durationToCloseHeader", defaultInt = 200)
    public void setDurationToCloseHeader(PtrReactNativeFrameLayout view, int duration) {
        view.setDurationToCloseHeader(duration);
    }

    @ReactProp(name = "durationToClose", defaultInt = 300)
    public void setDurationToClose(PtrReactNativeFrameLayout view, int duration) {
        view.setDurationToClose(duration);
    }

    @ReactProp(name = "ratioOfHeaderHeightToRefresh", defaultFloat = 1.2f)
    public void setRatioOfHeaderHeightToRefresh(PtrReactNativeFrameLayout view, float ratio) {
        view.setRatioOfHeaderHeightToRefresh(ratio);
    }

    @ReactProp(name = "pullToRefresh", defaultBoolean = false)
    public void setPullToRefresh(PtrReactNativeFrameLayout view, boolean pullToRefresh) {
        view.setPullToRefresh(pullToRefresh);
    }

    @ReactProp(name = "keepHeaderWhenRefresh", defaultBoolean = false)
    public void setKeepHeaderWhenRefresh(PtrReactNativeFrameLayout view, boolean keep) {
        view.setKeepHeaderWhenRefresh(keep);
    }

    @ReactProp(name = "pinContent", defaultBoolean = false)
    public void setPinContent(PtrReactNativeFrameLayout view, boolean pinContent) {
        view.setPinContent(pinContent);
    }

    public void setHeaderRotateAniTime(PtrReactNativeFrameLayout view, int time) {
        view.getHeader().setRotateAniTime(time);
    }

    // ------------------- end styleable -------------
}
