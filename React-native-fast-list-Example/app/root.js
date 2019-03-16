/**
 * created by hushicai on 2017/8/12
 */


import React, {Component} from 'react';
import {
    AppRegistry,
    Text,
    View,
    Button
} from 'react-native';
import { StackNavigator } from 'react-navigation';

import Home from './pages/Home';
import Default from './pages/Default';
import SwRefresh from './pages/SwRefresh';
import Refreshable from './pages/Refreshable';


const ReactNativePullToRefreshSample = StackNavigator({
    // Home: { screen: Home },
    // Default: {screen: Default},
    // SwRefresh: {screen: SwRefresh},
    Refreshable: {screen: Refreshable}
});

export default  ReactNativePullToRefreshSample;


