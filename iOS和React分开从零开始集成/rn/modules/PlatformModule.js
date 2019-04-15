import React, { Component } from 'react';
import { StyleSheet, View, Alert, Text, Button, Platform } from 'react-native';

export default class PlatformModule extends Component {
    _showOs() {
        Alert.alert(Platform.OS + JSON.stringify(Platform));
    }
    render() {
        return (
            <View style={styles.container}>
                <Button onPress={this._showOs} title="显示操作系统类型"></Button>
            </View>
        );
    }
}

let styles = StyleSheet.create({
    container: {
        flex: 1,
        ...Platform.select({
            ios: {
                backgroundColor: 'red',
            },
            android: {
                backgroundColor: 'blue',
            }
        })
    }

});