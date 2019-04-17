//
//  RNSCollectionViewManager.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSCollectionViewManager.h"
#import "RNSCollectionView.h"

@interface RNSCollectionViewManager ()

@property (nonatomic, strong) RNSCollectionView *rnsCollectionView;

@end

@implementation RNSCollectionViewManager

RCT_EXPORT_MODULE()
//将所需参数导出给JS
RCT_EXPORT_VIEW_PROPERTY(data, NSArray);
RCT_EXPORT_VIEW_PROPERTY(renderItem, NSString);
RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL);
RCT_EXPORT_VIEW_PROPERTY(rowHeight, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(numColumns, NSInteger);
RCT_EXPORT_VIEW_PROPERTY(fullListLoaded, BOOL);
RCT_EXPORT_VIEW_PROPERTY(pullToRefresh, BOOL);
RCT_EXPORT_VIEW_PROPERTY(isCurrentVersionOnline, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onClickItem, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onScroll, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onRefresh, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onEndReached, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onScrollBeginDrag, RCTDirectEventBlock);

- (UIView *)view
{
  self.rnsCollectionView = [[RNSCollectionView alloc] init];
  return self.rnsCollectionView;
}

RCT_REMAP_METHOD(scrollToOffset, params:(NSDictionary *)params)
{
  if (params && params[@"offset"]) {
    CGFloat offset = [params[@"offset"] floatValue];
    [self.rnsCollectionView.collectionView setContentOffset:CGPointMake(0, offset) animated:YES];
  }
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
