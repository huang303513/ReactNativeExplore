/**
 * @format
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import {AppRegistry} from 'react-native';
import App from './App.js';
import {name as appName} from './app.json';
import ReactNativePullToRefreshSample from './app/root'

// AppRegistry.registerComponent(appName, () => App);

AppRegistry.registerComponent(appName, () => ReactNativePullToRefreshSample);
