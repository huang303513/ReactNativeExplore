import React, { Component, PropTypes } from 'react';
import { requireNativeComponent, NativeModules, StyleSheet} from 'react-native';
const RNSTableHeaderView = requireNativeComponent('RNSTableHeaderView', null)
const RNSTableFooterView = requireNativeComponent('RNSTableFooterView', null)
const RNSTableView = requireNativeComponent('RNSTableView', null);
const RNSCollectionHeaderView = requireNativeComponent('RNSCollectionHeaderView', null);
const RNSCollectionFooterView = requireNativeComponent('RNSCollectionFooterView', null);
const RNSCollectionView = requireNativeComponent('RNSCollectionView', null);

export default class FlatList extends Component {

  scrollToOffset = (params)=>{
    const { numColumns = 1 } = this.props;
    if(numColumns == 1){
      NativeModules.RNSTableViewManager.scrollToOffset(params);
    }else{
      NativeModules.RNSCollectionViewManager.scrollToOffset(params);
    }
  }

  render() {
    const { ListHeaderComponent,ListFooterComponent,numColumns = 1 } = this.props;
    if(numColumns > 1){
      return (
        <RNSCollectionView style={styles.container} {...this.props} ref={r=>{this.list = r;}}>
          {ListHeaderComponent && <RNSCollectionHeaderView style={styles.defaultBG}>
              {
                ListHeaderComponent
              }
          </RNSCollectionHeaderView>}
          {ListFooterComponent && <RNSCollectionFooterView style={styles.defaultBG}>
              {
                ListFooterComponent
              }
          </RNSCollectionFooterView>}
        </RNSCollectionView>
      );
    }
    return (
      <RNSTableView style={styles.container} {...this.props} ref={r=>{this.list = r;}}>
        {ListHeaderComponent && <RNSTableHeaderView style={styles.defaultBG}>
              {
                ListHeaderComponent
              }
          </RNSTableHeaderView>}
          {ListFooterComponent && <RNSTableFooterView style={styles.defaultBG}>
              {
                ListFooterComponent
              }
          </RNSTableFooterView>}
      </RNSTableView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,

  },
  defaultBG: {
    backgroundColor: 'brown',
  },
});