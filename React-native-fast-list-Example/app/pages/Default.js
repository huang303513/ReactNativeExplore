/**
 * created by hushicai on 2017/8/15
 */

import React, {Component} from 'react';
import {
    View,
    Text,
    ScrollView,
    RefreshControl,
    StyleSheet
} from 'react-native';

export default class Default extends Component {
    static navigationOptions = {
        title: 'Default'
    };
    constructor(props) {
        super(props);
        this.state = {
            refreshing: false
        };
    }
    _onRefresh() {
        this.setState({
            refreshing: true
        });

        console.log('refreshing...');

        setTimeout(() => {
            console.log('refresh complete');
            this.setState({
                refreshing: false
            });
        }, 5000);
    }
    render() {
        return (
            <ScrollView
                style={styles.container}
                refreshControl={
                    <RefreshControl
                        title="Loading..."
                        refreshing={this.state.refreshing}
                        onRefresh={() => this._onRefresh()}
                    />
                }
            >
                <View>
                    <Text>React Native内置的RefreshControl组件</Text>
                </View>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        padding:10
    }
});

