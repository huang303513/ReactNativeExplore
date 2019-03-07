import React, { Component, PropTypes } from 'react';
import { requireNativeComponent,Text, View,StyleSheet} from 'react-native';
import TableViewHeader from './TableViewHeader';
import TableViewFooter from './TableViewFooter';
var RNSTableView = requireNativeComponent('RNSTableView', null);

export default class FlatList extends Component {

  render() {
    const { ListHeaderComponent,ListFooterComponent } = this.props;
    return (
      <RNSTableView style={styles.container} {...this.props}>
        <TableViewHeader>
            {
              ListHeaderComponent
            }
        </TableViewHeader>
        <TableViewFooter>
            {
              ListFooterComponent
            }
        </TableViewFooter>
      </RNSTableView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  }
});