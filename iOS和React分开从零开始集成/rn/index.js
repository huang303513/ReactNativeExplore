// import { AppRegistry } from 'react-native';
// import App from './App';

// AppRegistry.registerComponent('App', () => App);

import React from 'react';
import {AppRegistry} from 'react-native';
import RNHighScores from './modules/RNHighScores';
import BlinkApp from './modules/BlinkApp';
import StyleModule from './modules/StyleModule';
import ButtonModule from './modules/ButtonModule';
import ListModule from './modules/ListModule';
import PlatformModule from './modules/PlatformModule';
import BridgeModule from './bridge/BridgeModule';
import NativeBridge from './bridge/NativeBridge';
import MapViewModule from './view/MapViewModule';
import NavigatorModule from './navigator/NavigatorModule';


AppRegistry.registerComponent('RNHighScores', () => RNHighScores);
AppRegistry.registerComponent('BlinkApp', () => BlinkApp);
AppRegistry.registerComponent('StyleModule', () => StyleModule);
AppRegistry.registerComponent('ButtonModule', () => ButtonModule);
AppRegistry.registerComponent('ListModule', () => ListModule);
AppRegistry.registerComponent('PlatformModule', () => PlatformModule);
AppRegistry.registerComponent('BridgeModule', () => BridgeModule);
AppRegistry.registerComponent('NativeBridge', () => NativeBridge);
AppRegistry.registerComponent('MapViewModule', () => MapViewModule);
AppRegistry.registerComponent('NavigatorModule', () => NavigatorModule);



