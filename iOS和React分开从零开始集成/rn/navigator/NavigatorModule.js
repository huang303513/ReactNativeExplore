import React, { Component } from 'react';
import { View, Button, Image, Text, NativeModules } from 'react-native';
import { StackNavigator, TabNavigator,TabBarBottom } from 'react-navigation';
import Ionicons from 'react-native-vector-icons/Ionicons';

const { ReactNativeBridgeManager } = NativeModules;

//导出事件常量
const navigatorPopEvent = ReactNativeBridgeManager.navigatorPopEvent;

/**
 * https://www.npmjs.com/package/react-native-vector-icons
 * 参考资料地址：https://reactnavigation.org/docs/headers.html
 */

class LogoTitle extends React.Component {
    render() {
        return (
            <Image
                source={require('./spiro.png')}
                style={{ width: 30, height: 30 }}
            />
        );
    }
}

class HomeScreen extends Component {
    static navigationOptions = {
        headerTitle: <LogoTitle />,
        headerRight: (
            <Button
                onPress={() => alert('This is a button!')}
                title="Info"
                color="#fff"
            />
        ),
        headerLeft: (
            <Button
                onPress={() => ReactNativeBridgeManager.pop(navigatorPopEvent)}
                title="返回"
                color="#fff"
            />
        ),
        // title: 'Home',
        //单个设置属性通过下面
        // headerStyle: {
        //     backgroundColor: '#f4511e',
        // },
        // headerTintColor: '#fff',
        // headerTitleStyle: {
        //     fontWeight: 'bold',
        // },
    }
    render() {
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <Text>Home Screen</Text>
                <Button title="Go to Details" onPress={() => {
                    this.props.navigation.navigate('Details', {
                        itemId: 86,
                        otherParam: 'First Details'
                    })
                }}></Button>
            </View>
        )
    }
}

class DetailsScreen extends React.Component {
    //navigationOptions如果写成一个方法，那么参数包含{ navigation, navigationOptions, screenProps }
    static navigationOptions = ({ navigation, navigationOptions }) => {
        const { params } = navigation.state;
        //重写通用的header设置
        return {
            title: params ? params.otherParam : 'A Nested Details Screen',
            /* These values are used instead of the shared configuration! */
            headerStyle: {
                backgroundColor: "#dfddfd",
            },
            headerTintColor: navigationOptions.headerStyle.backgroundColor,
        };
    }
    render() {
        const { params } = this.props.navigation.state;
        const itemId = params ? params.itemId : null;
        const otherParam = params ? params.otherParam : null;
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <Text>Details Screen</Text>
                <Text>itemId:{JSON.stringify(itemId)}</Text>
                <Text>otherParam:{JSON.stringify(otherParam)}</Text>
                <Button title="Go to Details ...again" onPress={() =>
                    this.props.navigation.navigate('Details'
                    )}></Button>
                <Button title="go back" onPress={() =>
                    this.props.navigation.goBack()
                }></Button>
                <Button
                    title="Update the title"
                    onPress={() => this.props.navigation.setParams({ otherParam: 'Updated!' })}
                />
            </View>

        );
    }
}

class SettingsScreen extends React.Component {
    render() {
        return (
            <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
                <Text>Settings!</Text>
                <Button title="Go to Details" onPress={() => {
                    this.props.navigation.navigate('Details', {
                        itemId: 86,
                        otherParam: 'First Details'
                    })
                }}></Button>
            </View>
        );
    }
}

let NavigatorModule = StackNavigator(
    {
        Home: {
            screen: HomeScreen,
        },
        Details: {
            screen: DetailsScreen,
        },
    },
    {
        initialRouteName: 'Home',
        //给所有navigator设置属性在这里
        navigationOptions: {
            headerStyle: {
                backgroundColor: '#f4511e',
            },
            headerTintColor: '#fff',
            headerTitleStyle: {
                fontWeight: 'bold',
            },
        },
    }
);

// export default NavigatorModule;
//=========================================
// export default class App extends Component {
//     render() {
//         return <NavigatorModule />;
//     }
// }
//=========================================
class App extends Component {
    render() {
        return <NavigatorModule />;
    }
}

let NavigatorModuleOne = StackNavigator(
    {
        Home: {
            screen: SettingsScreen,
        },
        Details: {
            screen: DetailsScreen,
        },
    },
    {
        initialRouteName: 'Home',
        //给所有navigator设置属性在这里
        navigationOptions: {
            headerStyle: {
                backgroundColor: '#f4511e',
            },
            headerTintColor: '#fff',
            headerTitleStyle: {
                fontWeight: 'bold',
            },
        },
    }
);
class AppOne extends Component {
    render() {
        return <NavigatorModuleOne />;
    }
}


export default TabNavigator({
    Home: { screen: App },
    Settings: { screen: AppOne },
}, {
        navigationOptions: ({ navigation }) => ({
            tabBarIcon: ({ focused, tintColor }) => {
                const { routeName } = navigation.state;
                let iconName;
                if (routeName === 'Home') {
                    iconName = `ios-information-circle${focused ? '' : '-outline'}`;
                } else if (routeName === 'Settings') {
                    iconName = `ios-options${focused ? '' : '-outline'}`;
                }

                // You can return any component that you like here! We usually use an
                // icon component from react-native-vector-icons
                return <Ionicons name={iconName} size={25} color={tintColor} />;
            },
        }),
        tabBarOptions: {
            activeTintColor: 'tomato',
            inactiveTintColor: 'gray',
        },
        tabBarComponent: TabBarBottom,
        tabBarPosition: 'bottom',
        animationEnabled: false,
        swipeEnabled: false,
    });
//=========================================