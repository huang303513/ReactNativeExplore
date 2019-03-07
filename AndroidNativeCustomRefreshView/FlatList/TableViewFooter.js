import React from 'react'
import { requireNativeComponent } from 'react-native'

const RNFooterView = requireNativeComponent('RNSTableFooterView', null)

export default class TableViewFooter extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return (
      <RNFooterView {...this.props}/>
    )
  }
}
