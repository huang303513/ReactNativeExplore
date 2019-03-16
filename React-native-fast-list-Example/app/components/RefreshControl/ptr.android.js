/**
 * created by hushicai on 2017/8/12
 */


import React, {Component} from 'react';
import {
    View,
    requireNativeComponent,
    findNodeHandle
} from 'react-native';
import PropTypes from 'prop-types';
import UIManager from 'UIManager';

const Commands = {
    REFRESH_COMPLETE: 0
};

const NativePtrView = requireNativeComponent(
    'PtrLayout',
    PtrView,
    {nativeOnly: {onPtrRefresh: true}}
);

export default class PtrView extends Component {
    static propTypes = {
        ...View.propTypes,
        onRefresh: PropTypes.func,
        refreshing: PropTypes.bool.isRequired
    };

    _nativeRef = null;

    componentWillReceiveProps(nextProps) {
        if(this.props.refreshing !== nextProps.refreshing) {
            if(nextProps.refreshing === false) {
                this._refreshComplete();
            }
        }
    }

    shouldComponentUpdate(nextProps) {
        if(this.props.refreshing !== nextProps.refreshing) {
            return true;
        }
        return false;
    }

    render() {
        return (
            <NativePtrView
                {...this.props}
                durationToCloseHeader={200}
                ref={ref => this._nativeRef = ref}
                onPtrRefresh={this._onPtrRefresh.bind(this)}/>
        )
    }

    _refreshComplete() {
        console.log('refresh complete');
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this._nativeRef),
            Commands.REFRESH_COMPLETE,
            null
        );
    }

    _onPtrRefresh() {
        this.props.onRefresh && this.props.onRefresh();
        // this.forceUpdate();
    }
}

