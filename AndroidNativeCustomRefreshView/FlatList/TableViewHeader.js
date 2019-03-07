import React from 'react'
import { requireNativeComponent } from 'react-native'

const RNHeaderView = requireNativeComponent('RNSTableHeaderView', null)

export default class TableViewHeader extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <RNHeaderView {...this.props}/>
    )
  }
}
