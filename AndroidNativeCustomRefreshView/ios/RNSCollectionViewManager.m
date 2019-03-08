//
//  RNSCollectionViewManager.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSCollectionViewManager.h"
#import "RNSCollectionView.h"

@implementation RNSCollectionViewManager

RCT_EXPORT_MODULE()
//将所需参数导出给JS
RCT_EXPORT_VIEW_PROPERTY(data, NSArray);
RCT_EXPORT_VIEW_PROPERTY(renderItem, NSString);
RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL);
RCT_EXPORT_VIEW_PROPERTY(rowHeight, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(columns, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(fullListLoaded, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onClickItem, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRefresh, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onEndReached, RCTDirectEventBlock)

- (UIView *)view
{
  RNSCollectionView *view = [[RNSCollectionView alloc] init];
  return view;
}

@end
