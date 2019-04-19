//
//  RNSUtil.m
//  Example
//
//  Created by huangchengdu on 2019/4/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUtil.h"

@implementation RNSUtil

+ (NSString *)getContent:(NSArray *)params regular:(NSString *)regular{
  if ((regular == nil) || (regular.length == 0)) {
    return nil;
  }
  NSString *str = @"[\{][\$]\\d{1,}[\}]";
  NSString *str1 = @"\\d{1,}";
  
  
  
  return @"";
}

@end
