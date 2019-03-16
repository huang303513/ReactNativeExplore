/**
 * created by hushicai on 2017/8/15
 */

import React, {Component} from 'react';
import {
    Text,
    View,
    ScrollView,
    StyleSheet
} from 'react-native';
import PullToRefreshLayout from '../components/PullToRefreshLayout/index2';

export default class Refreshable extends Component {
    static navigationOptions = {
        title: 'Refreshable'
    };

    _layoutRef = null;

    _onRefresh() {
        console.log('refreshing...');

        setTimeout(() => {
            console.log('refresh complete');

            this._layoutRef.stopRefresh();
        }, 5000);
    }

    render() {
        return (
            <PullToRefreshLayout
                ref={(ref) => {this._layoutRef = ref}}
                style={styles.container}
                onRefresh={() => this._onRefresh()}>
                <View>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>1</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>2</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                    <Text>Refreshable</Text>
                </View>
            </PullToRefreshLayout>
        );
    }
}


const styles = StyleSheet.create({
    container: {}
});
