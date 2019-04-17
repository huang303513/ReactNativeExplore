//
//  RNSTableFooterViewManager.m
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/7.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSTableFooterViewManager.h"
#import "RNSTableFooterView.h"

@implementation RNSTableFooterViewManager

RCT_EXPORT_MODULE()
- (UIView *)view
{
  return [[RNSTableFooterView alloc] init];
}


@end
