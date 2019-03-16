/**
 * created by hushicai on 2017/8/16
 */

import React, {Component} from 'react';

import {
    StyleSheet,
    View,
    Button
} from 'react-native';

export default class Home extends Component {
    static navigationOptions = {
        title: 'Home'
    };
    render() {
        const {navigate} = this.props.navigation;

        return (
            <View style={styles.container}>
                <Button
                    title="Default"
                    onPress={() => navigate('Default')} />
                <Button
                    title="SwRefresh"
                    onPress={() => navigate('SwRefresh')}/>
                <Button
                    title="Refreshable"
                    onPress={() => navigate('Refreshable')} />
                <Button
                    title="NativeUIComponent"
                    onPress={() => navigate('NativeUIComponent')}
                />
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        paddingVertical: 10
    }
});