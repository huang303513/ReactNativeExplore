//
//  FlatList.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "RNSTableViewManager.h"
#import "RNSTableView.h"

@interface RNSTableViewManager ()
@property (nonatomic) RNSTableView *tableView;
@end

@implementation RNSTableViewManager

RCT_EXPORT_MODULE()
//将所需参数导出给JS
RCT_EXPORT_VIEW_PROPERTY(data, NSArray);
RCT_EXPORT_VIEW_PROPERTY(renderItem, NSString);
RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL);
RCT_EXPORT_VIEW_PROPERTY(rowHeight, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(fullListLoaded, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onClickItem, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRefresh, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onEndReached, RCTDirectEventBlock)

- (UIView *)view
{
  _tableView = [[RNSTableView alloc] init];
  return _tableView;
}




- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
