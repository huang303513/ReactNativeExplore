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
import dataList from './home';

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
      numColumns: 3,
      fullListLoaded: false,
      data: dataList,
    }
  }

  getView() {
    return <View style={styles.xx}>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text> Hello </Text>
    </View>;
  }

  getView1() {
    return <View>
      <Text style={styles.welcome}>We大法师t Native!</Text>
      <Text style={styles.welcome}>We大法师t Native!</Text>
      <Text style={styles.welcome}>We大法师t Native!</Text>
      <Text style={styles.welcome}>We大法师t Native!</Text>
    </View>;
  }

  render() {
    const {data, refreshing,fullListLoaded, numColumns} = this.state;
    return (
      <View style={styles.container}>
        <FlatList style={styles.flatList}
          renderItem={(numColumns === 1)?'RNSHomeCell':'RNSCategoryCollectionViewCell'}
          ListHeaderComponent={this.getView()}
          ListFooterComponent={this.getView1()}
          data={data}
          onClickItem={this.onClickItem}
          onRefresh={this.onRefresh}
          onEndReached={this.onEndReached}
          rowHeight={90}//collection must
          fullListLoaded={fullListLoaded}
          columns={numColumns}//collection only
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
    let temp = dataList;
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
    
    let temp = data.concat(dataList).concat(dataList);
    setTimeout(() =>{
      this.setState({
        data: temp,
        refreshing:false,
        fullListLoaded: temp.length>=300?true:false,
      })
    },1000);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'red',
  },
  flatList:{
    backgroundColor:'#999999',
    flex: 1,
    marginTop: 50,
    marginBottom: 50,
  },
  xx: {
    marginTop:20,
    paddingBottom: 30,
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
