//
//  RNTableHeaderViewManager.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/7.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSTableHeaderViewManager.h"
#import "RNSTableHeaderView.h"


@implementation RNSTableHeaderViewManager

RCT_EXPORT_MODULE()
- (UIView *)view
{
  return [[RNSTableHeaderView alloc] init];
}

@end
