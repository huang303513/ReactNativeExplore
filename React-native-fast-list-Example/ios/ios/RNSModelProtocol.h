//
//  RNSModelProtocol.h
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#ifndef RNSModelProtocol_h
#define RNSModelProtocol_h

#import "RNSConstant.h"

@protocol RNSModelProtocol <NSObject>

@property(nonatomic, assign)CGRect rect;
@property(nonatomic, strong)UIColor *backgroundColor;
@property(nonatomic, assign)CGFloat borderRadius;
@property(nonatomic, strong, nonnull)NSString *type;
@property(nonatomic, strong)NSString *content;
//类似于{$21}
@property(nonatomic, strong)NSString *regular;
//21
@property(nonatomic, assign)NSInteger index;

- (id)getView:(NSString *)content;
- (void)updateView:(UIView *)view content:(NSString *)content;
- (NSString *)getLastContent:(NSString *)content;

- (void)customTransformFromDictionary:(NSDictionary *)dic;
@end


//inline void customTransformModelFromDictionary(id<RNSModelProtocol> model, NSDictionary *dic){
//  NSArray *rectArray = dic[@"rect"];
//  NSArray *colorArray = dic[@"backgroundColor"];
//  if ([rectArray isKindOfClass:[NSArray class]]) {
//    model.rect = CGRectMake([rectArray[1] floatValue], [rectArray[0] floatValue], [rectArray[2] floatValue], [rectArray[3] floatValue]);
//  }
//  if ([colorArray isKindOfClass:[NSArray class]]) {
//    model.backgroundColor = RGBColor([colorArray[0] floatValue],[colorArray[1] floatValue],[colorArray[2] floatValue], [colorArray[3] floatValue]);
//  }
//}

#endif /* RNSModelProtocol_h */
