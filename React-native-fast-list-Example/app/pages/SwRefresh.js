/**
 * created by hushicai on 2017/8/15
 */

// @see: https://github.com/shiwenwen/react-native-swRefresh

import React, {Component} from 'react';
import {
    Dimensions,
    StyleSheet,
    View,
    Text
} from 'react-native';
import {SwRefreshScrollView} from 'react-native-swRefresh';

export default class SwRefresh extends Component {
    static navigationOptions = {
        title: 'SwRefresh'
    };
    _onRefresh(end) {
        console.log('refreshing...');
        setTimeout(() => {
            console.log('refresh complete');
            end();
        }, 5000);
    }
    render() {
        return (
            <SwRefreshScrollView onRefresh={(end) => {this._onRefresh(end)}}>
                <View style={styles.container}>
                    <Text>react-native-swRefresh</Text>
                </View>
            </SwRefreshScrollView>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        minHeight: Dimensions.get('window').height,
        padding: 10,
    }
});
