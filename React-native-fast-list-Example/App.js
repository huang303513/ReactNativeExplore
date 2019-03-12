/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View,TouchableOpacity} from 'react-native';
import FlatList from 'react-native-fast-list';
import dataList from './home';

export default class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      refreshing: false,
      numColumns: 1,
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

  scrollToOffset = () => {
    this._UI.scrollToOffset({offset:0});
  }

  render() {
    const {data, refreshing,fullListLoaded, numColumns} = this.state;
    return (
      <View style={styles.container}>
        <FlatList style={styles.flatList}
          ref={r=>{this._UI = r;}}
          renderItem={(numColumns === 1)?'RNSHomeCell':'RNSCategoryCollectionViewCell'}
          ListHeaderComponent={this.getView()}
          ListFooterComponent={this.getView1()}
          data={data}
          onClickItem={this.onClickItem}
          onRefresh={this.onRefresh}
          onEndReached={this.onEndReached}
          onScroll={this.onScroll}
          onScrollBeginDrag={this.onScrollBeginDrag}//开始拖动
          pullToRefresh={true}//default is true
          // rowHeight={294}//collection must
          showFreeBuy={false}//default is false, tableview only
          fullListLoaded={fullListLoaded}
          isCurrentVersionOnline={true}
          numColumns={numColumns}//collection only, default 2
          refreshing={refreshing}
        />
        <TouchableOpacity
                    style={styles.scrollToTop}
                    onPress={this.scrollToOffset}>
          </TouchableOpacity>
      </View>
    )
  }

  onClickItem = (e) => {
    console.log("点击索引==>" + e.nativeEvent.index);
  }

  onScroll(e){
    console.log("滚动事件===>" + e.nativeEvent.contentOffset);
  }

  onScrollBeginDrag(e){
    console.log("开始拖动===>" + e.nativeEvent.contentOffset);
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
    backgroundColor: '#F6F7F9',
    // backgroundColor:'green',
    flex: 1,
    marginTop: 0,
    marginBottom: 0,
  },
  xx: {
    marginTop:20,
    paddingBottom: 30,
  },
  scrollToTop:{
    width:30,
    height:30,
    backgroundColor:'blue',
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
