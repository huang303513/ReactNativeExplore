import React, { Component } from 'react';
import { StyleSheet, View, Text, Alert, Button, Platform, TouchableHighlight, TouchableOpacity, TouchableNativeFeedback, TouchableWithoutFeedback } from 'react-native';

export default class ButtonModule extends Component {
    constructor(props) {
        super(props)
    }
    _onPressButton() {
        Alert.alert("Press Button");
    }
    _onLongPressButton() {
        Alert.alert('You long-pressed the button!')
    }
    render() {
        // return (
        //     <View style={styles.container}>
        //         <View style={styles.buttonContainer}>
        //             <Button onPress={this._onPressButton} title="Press Me"></Button>
        //         </View>
        //         <View style={styles.buttonContainer}>
        //             <Button onPress={this._onPressButton} title="Press Me" color="#841584"></Button>
        //         </View>
        //         <View style={styles.alternativeLayoutButtonContainer}>
        //             <Button
        //                 onPress={this._onPressButton}
        //                 title="This looks great!"
        //             />
        //             <Button
        //                 onPress={this._onPressButton}
        //                 title="OK!"
        //                 color="#841584"
        //             />
        //         </View>
        //     </View>);
        return (
            <View style={styles.container}>
                <TouchableHighlight onPress={this._onPressButton} underlayColor="white">
                    <View style={styles.button}>
                        <Text style={styles.buttonText}>TouchableHighlight</Text>
                    </View>
                </TouchableHighlight>
                <TouchableOpacity onPress={this._onPressButton}>
                    <View style={styles.button}>
                        <Text style={styles.buttonText}>TouchableOpacity</Text>
                    </View>
                </TouchableOpacity>
                <TouchableNativeFeedback
                    onPress={this._onPressButton}
                    background={Platform.OS === 'android' ? TouchableNativeFeedback.SelectableBackground() : ''}>
                    <View style={styles.button}>
                        <Text style={styles.buttonText}>TouchableNativeFeedback</Text>
                    </View>
                </TouchableNativeFeedback>
                <TouchableWithoutFeedback
                    onPress={this._onPressButton}
                >
                    <View style={styles.button}>
                        <Text style={styles.buttonText}>TouchableWithoutFeedback</Text>
                    </View>
                </TouchableWithoutFeedback>
                <TouchableHighlight onPress={this._onPressButton} onLongPress={this._onLongPressButton} underlayColor="white">
                    <View style={styles.button}>
                        <Text style={styles.buttonText}>Touchable with Long Press</Text>
                    </View>
                </TouchableHighlight>
            </View>
        );
    }
}

// let styles = StyleSheet.create({
//     container: {
//         flex: 1,
//         justifyContent: 'center'
//     },
//     buttonContainer: {
//         backgroundColor:'red',
//         margin: 20
//     },
//     alternativeLayoutButtonContainer: {
//         backgroundColor:'green',
//         margin: 20,
//         flexDirection: 'row',
//         justifyContent: 'space-between'
//     }
// });

const styles = StyleSheet.create({
    container: {
        paddingTop: 60,
        alignItems: 'center'
    },
    button: {
        marginBottom: 30,
        width: 260,
        alignItems: 'center',
        backgroundColor: '#2196F3'
    },
    buttonText: {
        padding: 20,
        color: 'white'
    }
})