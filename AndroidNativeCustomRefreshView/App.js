/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View} from 'react-native';
import FlatList from './FlatList/';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      refreshing: false,
      numColumns: 1,
      data: [],
    }
  }

  getView() {
    return <View>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text> Hello </Text>
    </View>;
  }

  render() {
    const {data, refreshing} = this.state;
    return (
      <View style={styles.container}>
        <FlatList style={styles.flatList}
          renderItem={'RNSHomeCell'}
          ListHeaderComponent={this.getView()}
          ListFooterComponent={this.getView()}
          data={data}
          onClickItem={this.onClickItem}
          onRefresh={this.onRefresh}
          onEndReached={this.onEndReached}
          fullListLoaded={false}
          columns={1}
          refreshing={refreshing}
        />
      </View>
    )
  }

  onClickItem = (e) => {
    console.log("点击索引==>" + e.nativeEvent.index);
  }

  onRefresh = () =>{
    this.setState({
      refreshing:true,
    })
    let temp = [];
    for(let i = 0; i < 10; i++){
      temp.push({title:Date.now().toLocaleString()})
    }
    setTimeout(() =>{
      this.setState({
        data: temp,
        refreshing:false,
      })
    },5000);
  }

  onEndReached = () =>{
    this.setState({
      refreshing:true,
    })
    const {data} = this.state;
    let temp = [];
    for(let i = 0; i < 10; i++){
      temp.push({title:Date.now().toLocaleString()})
    }
    setTimeout(() =>{
      this.setState({
        data: data.concat(temp),
        refreshing:false,
      })
    },5000);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    // justifyContent: 'center',
    // alignItems: 'center',
    backgroundColor: 'yellow',
  },
  flatList:{
    // position: 'absolute',
    // top: 40,
    // left: 0,
    // bottom: 0,
    // right: 0,
    // backgroundColor:'blue',
    // position:'relative',
    flex: 1,
    // width:'100%',
    // height:'100%',
    marginTop: 50,
    marginBottom: 50,
    // width: 300,
    // height: 300,
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    // margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    // marginBottom: 5,
  },
});
