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
@property (nonatomic, strong) RNSTableView *rnsTableView;
@end

@implementation RNSTableViewManager

RCT_EXPORT_MODULE()
//将所需参数导出给JS
RCT_EXPORT_VIEW_PROPERTY(data, NSArray);
RCT_EXPORT_VIEW_PROPERTY(renderItem, NSString);
RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL);
RCT_EXPORT_VIEW_PROPERTY(rowHeight, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(fullListLoaded, BOOL);
RCT_EXPORT_VIEW_PROPERTY(isCurrentVersionOnline, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onClickItem, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRefresh, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onEndReached, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(columns, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(pullToRefresh, BOOL);
RCT_EXPORT_VIEW_PROPERTY(showFreeBuy, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onScroll, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onScrollBeginDrag, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(rowTemplate, NSDictionary);

- (UIView *)view
{
  self.rnsTableView = [[RNSTableView alloc] init];
  return self.rnsTableView;
}

RCT_REMAP_METHOD(scrollToOffset, params:(NSDictionary *)params)
{
  if (params && params[@"offset"]) {
    CGFloat offset = [params[@"offset"] floatValue];
    [self.rnsTableView.tableView setContentOffset:CGPointMake(0, offset) animated:YES];
  }
}


- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
