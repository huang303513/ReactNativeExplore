//
//  RNSCollectionFooterViewManager.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/8.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSCollectionFooterViewManager.h"
#import "RNSCollectionFooterView.h"

@implementation RNSCollectionFooterViewManager

RCT_EXPORT_MODULE()
- (UIView *)view
{
  return [[RNSCollectionFooterView alloc] init];
}


- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
@end
