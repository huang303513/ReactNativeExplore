//
//  RNSUIViewModel.m
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUIViewModel.h"
#import "RNSConstant.h"

@implementation RNSUIViewModel


@synthesize rect = _rect, backgroundColor = _backgroundColor, borderRadius = _borderRadius, type = _type, contentIndex = _contentIndex;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
  [self customTransformFromDictionary:dic];
  return YES;
}

- (void)customTransformFromDictionary:(NSDictionary *)dic{
  NSArray *rectArray = dic[@"rect"];
  NSArray *colorArray = dic[@"backgroundColor"];
  if ([rectArray isKindOfClass:[NSArray class]]) {
    self.rect = CGRectMake([rectArray[1] floatValue], [rectArray[0] floatValue], [rectArray[2] floatValue], [rectArray[3] floatValue]);
  }
  if ([colorArray isKindOfClass:[NSArray class]]) {
    self.backgroundColor = RGBColor([colorArray[0] floatValue],[colorArray[1] floatValue],[colorArray[2] floatValue], [colorArray[3] floatValue]);
  }
}

- (id)getView:(NSString *)content{
  UIView *view = [[UIView alloc]initWithFrame:self.rect];
  if (self.backgroundColor) {
    view.backgroundColor = self.backgroundColor;
  }
  if (self.borderRadius) {
    view.layer.cornerRadius = self.borderRadius;
  }
  return view;
}

- (void)updateView:(UIView *)view content:(NSString *)content{
//  view.backgroundColor = self.backgroundColor;
//  view.layer.cornerRadius = self.borderRadius;
}

@end
