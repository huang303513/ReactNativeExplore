import React from 'react';
import { Text, View } from 'react-native';
import App from './App';
import AppSecond from './AppSecond'
import { createBottomTabNavigator, createAppContainer } from 'react-navigation';

// class HomeScreen extends React.Component {
//   render() {
//     return (
//       <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
//         <Text>Home!</Text>
//       </View>
//     );
//   }
// }

// class SettingsScreen extends React.Component {
//   render() {
//     return (
//       <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
//         <Text>Settings!</Text>
//       </View>
//     );
//   }
// }

const TabNavigator = createBottomTabNavigator({
  "App": App,
  "AppSecond": AppSecond,
});

export default createAppContainer(TabNavigator);