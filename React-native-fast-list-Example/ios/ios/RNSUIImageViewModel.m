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

@synthesize rect = _rect, backgroundColor = _backgroundColor, borderRadius = _borderRadius, type = _type, content = _content, regular = _regular, index = _index;
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
  
  NSString *lastContent = [self getLastContent:content];
  if ([lastContent hasPrefix:@"http"]) {
    [imageView sd_setImageWithURL:[NSURL URLWithString:lastContent] placeholderImage:nil options:SDWebImageRefreshCached];
  }else{
//    NSString *path =  [[NSBundle mainBundle] pathForResource:@"tb-icon-1" ofType:@"png" inDirectory:@"/assets/"];
    
    NSString *path =  [[NSBundle mainBundle]resourcePath];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",path,@"/"]);
    NSLog(@"===%@",NSHomeDirectory());
    UIImage *image = [UIImage imageNamed:lastContent];
    if (image) {
      imageView.image = image;
    }
    
  }
  return imageView;
}

- (void)updateView:(UIImageView *)view content:(NSString *)content{
  NSString *lastContent = [self getLastContent:content];
  if ([lastContent hasPrefix:@"http"]) {
    [view sd_setImageWithURL:[NSURL URLWithString:lastContent] placeholderImage:nil options:SDWebImageRefreshCached];
  }
}


@end
