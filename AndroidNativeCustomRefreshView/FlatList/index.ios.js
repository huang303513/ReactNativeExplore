import React, { Component, PropTypes } from 'react';
import { requireNativeComponent, StyleSheet} from 'react-native';
const RNSTableHeaderView = requireNativeComponent('RNSTableHeaderView', null)
const RNSTableFooterView = requireNativeComponent('RNSTableFooterView', null)
const RNSTableView = requireNativeComponent('RNSTableView', null);
const RNSCollectionHeaderView = requireNativeComponent('RNSCollectionHeaderView', null);
const RNSCollectionFooterView = requireNativeComponent('RNSCollectionFooterView', null);
const RNSCollectionView = requireNativeComponent('RNSCollectionView', null);

export default class FlatList extends Component {

  render() {
    const { ListHeaderComponent,ListFooterComponent,columns } = this.props;
    if(columns > 1){
      return (
        <RNSCollectionView style={styles.container} {...this.props}>
          <RNSCollectionHeaderView style={styles.defaultBG}>
              {
                ListHeaderComponent
              }
          </RNSCollectionHeaderView>
          <RNSCollectionFooterView style={styles.defaultBG}>
              {
                ListFooterComponent
              }
          </RNSCollectionFooterView>
        </RNSCollectionView>
      );
    }
    return (
      <RNSTableView style={styles.container} {...this.props}>
        <RNSTableHeaderView>
            {
              ListHeaderComponent
            }
        </RNSTableHeaderView>
        <RNSTableFooterView style={styles.defaultBG}>
            {
              ListFooterComponent
            }
        </RNSTableFooterView>
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
  }
});