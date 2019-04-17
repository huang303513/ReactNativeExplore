//
//  RNSUIImageViewModel.m
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUIImageViewModel.h"
#import <SDWebImage/SDWebImage.h>
#import "RNSConstant.h"

@implementation RNSUIImageViewModel

@synthesize rect = _rect, backgroundColor = _backgroundColor, borderRadius = _borderRadius, type = _type, contentIndex = _contentIndex;

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
  [super customTransformFromDictionary:dic];
  NSString *resizeModeStr = dic[@"resizeMode"];
  if ([resizeModeStr isKindOfClass:[NSString class]]) {
    _resizeMode = UIViewContentModeScaleToFill;
  }
  
  return YES;
}

- (id)getView:(NSString *)content{
  UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.rect];
  if (self.backgroundColor) {
    imageView.backgroundColor = self.backgroundColor;
  }
  if (self.resizeMode) {
     imageView.contentMode = self.resizeMode;
  }

  [imageView sd_setImageWithURL:[NSURL URLWithString:content] placeholderImage:nil options:SDWebImageRefreshCached];
  return imageView;
}

- (void)updateView:(UIImageView *)view content:(NSString *)content{
   [view sd_setImageWithURL:[NSURL URLWithString:content] placeholderImage:nil options:SDWebImageRefreshCached];
}


@end
