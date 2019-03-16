package com.reactnativeptr;

import com.facebook.react.uimanager.events.Event;
import com.facebook.react.uimanager.events.RCTEventEmitter;

/**
 * Created by hushicai on 2017/8/13.
 */

public class PtrRefreshEvent extends Event<PtrRefreshEvent> {
    protected PtrRefreshEvent(int viewTag) {
        super(viewTag);
    }

    @Override
    public String getEventName() {
        return "ptrRefresh";
    }

    @Override
    public void dispatch(RCTEventEmitter rctEventEmitter) {
        rctEventEmitter.receiveEvent(getViewTag(),getEventName(),null);
    }
}
