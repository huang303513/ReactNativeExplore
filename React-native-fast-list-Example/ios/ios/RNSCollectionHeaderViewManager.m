//
//  RNSCollectionHeaderViewManager.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSCollectionHeaderViewManager.h"
#import "RNSCollectionHeaderView.h"

@implementation RNSCollectionHeaderViewManager

RCT_EXPORT_MODULE()
- (UIView *)view
{
  return [[RNSCollectionHeaderView alloc] init];
}


- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
@end
