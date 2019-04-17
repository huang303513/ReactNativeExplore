//
//  RNSUILableModel.m
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUILableModel.h"
#import "RNSConstant.h"

@implementation RNSUILableModel

@synthesize rect = _rect, backgroundColor = _backgroundColor, borderRadius = _borderRadius, type = _type, contentIndex = _contentIndex;

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
  [super customTransformFromDictionary:dic];
  
  NSString *alignStr = dic[@"align"];
  NSArray *colorArray = dic[@"color"];
  if ([alignStr isKindOfClass:[NSString class]]) {
    if ([alignStr isEqualToString:@"center"]) {
      _align = NSTextAlignmentCenter;
    }else if ([alignStr isEqualToString:@"right"]) {
      _align = NSTextAlignmentRight;
    }else{
      _align = NSTextAlignmentLeft;
    }
  }
  if ([colorArray isKindOfClass:[NSArray class]]) {
      _color = RGBColor([colorArray[0] floatValue],[colorArray[1] floatValue],[colorArray[2] floatValue], [colorArray[3] floatValue]);
  }
  
  return YES;
}


- (id)getView:(NSString *)content{
  UILabel *label = [[UILabel alloc]initWithFrame:self.rect];
  if (self.backgroundColor) {
    label.backgroundColor = self.backgroundColor;
  }
  if (self.borderRadius) {
    label.layer.cornerRadius = self.borderRadius;
  }
  if (self.color) {
    label.textColor = self.color;
  }
  if (self.align) {
    label.textAlignment = self.align;
  }
  if (self.fontSize) {
    label.font = [UIFont systemFontOfSize:self.fontSize];
  }
  label.text = content;
  return label;
}

- (void)updateView:(UILabel *)label content:(NSString *)content{
  label.text = content;
}

@end
