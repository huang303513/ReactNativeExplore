//
//  RNSConvertModel.h
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/16.
//

#import <Foundation/Foundation.h>


@interface Content : NSObject

@property(nonatomic, strong)NSString *type;
@property(nonatomic, assign)NSInteger contentIndex;

//text
@property(nonatomic, strong)NSString *align;
@property(nonatomic, strong)NSString *font;
@property(nonatomic, strong)NSNumber *fontSize;
@end


NS_ASSUME_NONNULL_BEGIN

@interface RNSConvertModel : NSObject

@property(nonatomic, strong)NSArray *rect;
@property(nonatomic, strong)NSArray *size;
@property(nonatomic, strong)NSArray<NSNumber *> *bgColor;
@property(nonatomic, assign)float cornerRadius;
@property(nonatomic, strong)NSNumber *tag;
@property(nonatomic, strong)Content *content;
@property(nonatomic, strong)NSArray<RNSConvertModel *> *child;
@end

NS_ASSUME_NONNULL_END
