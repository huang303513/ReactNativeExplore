//
//  RNSUIViewModel.m
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUIViewModel.h"
#import "RNSConstant.h"

static NSString *strReg = @"[\{][\$]\\d{1,}[\}]";
static NSString *strNum = @"\\d{1,}";

@implementation RNSUIViewModel
@synthesize rect = _rect, backgroundColor = _backgroundColor, borderRadius = _borderRadius, type = _type, content = _content, regular = _regular, index = _index;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
  [self customTransformFromDictionary:dic];
  return YES;
}

- (void)customTransformFromDictionary:(NSDictionary *)dic{
  NSArray *rectArray = dic[@"rect"];
  NSArray *colorArray = dic[@"backgroundColor"];
  NSString *content = dic[@"content"];
  if ([rectArray isKindOfClass:[NSArray class]]) {
    self.rect = CGRectMake([rectArray[1] floatValue], [rectArray[0] floatValue], [rectArray[2] floatValue], [rectArray[3] floatValue]);
  }
  if ([colorArray isKindOfClass:[NSArray class]]) {
    self.backgroundColor = RGBColor([colorArray[0] floatValue],[colorArray[1] floatValue],[colorArray[2] floatValue], [colorArray[3] floatValue]);
  }
  //模板content解析
  if (content && [content isKindOfClass:[NSString class]]) {
    self.content = content;
    NSRange range = [content rangeOfString:strReg options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
      self.regular = [content substringWithRange:range];
    }
    if (self.regular) {
      range = [self.regular rangeOfString:strNum options:NSRegularExpressionSearch];
      if (range.location != NSNotFound) {
        self.index = [[self.regular substringWithRange:range] integerValue];
      }
    }
  }else if([content isKindOfClass:[NSNumber class]]){
    NSLog([NSString stringWithFormat:@"-------------%@", content]);
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

- (NSString *)getLastContent:(NSString *)params{
  if (self.index == 0 && !self.regular && self.content) {
    return self.content;
  }else if(params && (self.index > 0) && self.regular && self.content){
    NSLog(@"=====%@",self.content);
    NSString *lastContent = [[self.content mutableCopy] stringByReplacingOccurrencesOfString:self.regular withString:params];
    NSLog(@"%@",lastContent);
    return lastContent;
  }
  return @"";
}

- (void)updateView:(UIView *)view content:(NSString *)content{
//  view.backgroundColor = self.backgroundColor;
//  view.layer.cornerRadius = self.borderRadius;
}

@end
